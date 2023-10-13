#================================
#Locals
#================================
locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

#================================
#Data Sources
#================================
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
#================================
# Load Balancer
#================================
resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"

  # Allow inbound HTTP requests
  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }

  # Allow all outbound requests
  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
}

resource "aws_lb" "example" {
  name               = "${var.cluster_name}-asg"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = local.http_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-asg"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2

  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

#================================
#Autoscaling group
#================================
resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-instance"

  ingress {
    from_port       = var.server_port
    to_port         = var.server_port
    protocol        = local.tcp_protocol
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
}

resource "aws_launch_template" "example" {
  name_prefix   = var.cluster_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    security_groups = [aws_security_group.instance.id]
  }

  //user_data = filebase64("./config/user_data.sh")
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    server_text = var.server_text
    db_address  = var.db_address
    db_port     = var.db_port
  }))
}

resource "aws_autoscaling_group" "example" {
  # name                = "${var.cluster_name}-${aws_launch_template.example.name}"
  name                = var.cluster_name
  vpc_zone_identifier = data.aws_subnets.default.ids
  target_group_arns   = [aws_lb_target_group.asg.arn]
  health_check_type   = "ELB"
  min_size            = var.min_size
  max_size            = var.max_size

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  # Use instance refresh to roll out changes to the ASG for Zero Downtime
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
    }
  }

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = {
      for key, value in var.custom_tags :
      key => upper(value)
      if key != "Name"
    }

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  count                  = var.enable_autoscaling ? 1 : 0
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = 5
  recurrence             = "15 10 * * *"
  start_time             = "2023-10-11T16:15:00Z"
  end_time               = "2023-10-11T23:59:59Z"
  time_zone              = "UTC"
  autoscaling_group_name = aws_autoscaling_group.example.name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  count                  = var.enable_autoscaling ? 1 : 0
  scheduled_action_name  = "scale-in-at-night"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = 2
  recurrence             = "30 10 * * *"
  start_time             = "2023-10-11T16:30:00Z"
  end_time               = "2023-10-11T23:59:59Z"
  time_zone              = "UTC"
  autoscaling_group_name = aws_autoscaling_group.example.name
}
