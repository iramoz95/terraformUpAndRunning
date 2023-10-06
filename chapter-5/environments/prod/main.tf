#=========================
#RDS
#========================
module "rds" {
  source              = "../../modules/rds"
  db_identifier       = "prod-db"
  db_engine           = "mysql"
  db_port             = 3306
  db_username         = var.db_username
  db_password         = var.db_password
  db_name             = "example_db"
  allowed_cidr_blocks = var.allowed_cidr_blocks
}
#========================
#Webserver cluster
#========================
module "webserver_cluster" {
  source        = "../../modules/services/webserver-cluster"
  cluster_name  = "webservers-prod"
  db_address    = module.rds.address
  db_port       = module.rds.port
  ami_id        = "ami-03a6eaae9938c858c"
  server_port   = 8080
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10

  depends_on = [module.rds]
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 5
  recurrence             = "31 18 * * *"
  start_time             = var.autoscaling_schedule_start_time
  end_time               = var.autoscaling_schedule_end_time
  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "40 18 * * *"
  start_time             = var.autoscaling_schedule_start_time
  end_time               = var.autoscaling_schedule_end_time
  autoscaling_group_name = module.webserver_cluster.asg_name
}
