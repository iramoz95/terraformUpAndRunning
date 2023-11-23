data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-04cb4ca688797756f" #Amazon Linux 2023 
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    
    # install httpd (Amazon Linux 2023)                
    dnf update -y
    dnf install -y httpd.x86_64

    #change httpd default port
    port=${var.server_port}
    config_file="/etc/httpd/conf/httpd.conf"
    # Check if the configuration file exists
    if [ -f "$config_file" ]; then        
        sudo sed -i "s/Listen 80/Listen $port/" "$config_file"    
        echo "Apache port changed to $port"
    else
        echo "Apache configuration file not found."
    fi

    #start Apache
    systemctl start httpd.service
    systemctl enable httpd.service
    echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
    EOF

}

resource "aws_security_group" "instance" {
  name = "terrform-examaple-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  min_size = 2
  max_size = 10
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

  # Required when using a launch configuration with an auto scaling group
  lifecycle {
    create_before_destroy = true
  }
}
