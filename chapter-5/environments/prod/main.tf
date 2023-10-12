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
  source             = "../../modules/services/webserver-cluster"
  cluster_name       = "webservers-prod"
  db_address         = module.rds.address
  db_port            = module.rds.port
  ami_id             = "ami-03a6eaae9938c858c"
  server_port        = 8080
  server_text        = "Hello, World - Env: Prod"
  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = false

  custom_tags = {
    Owner     = "ian"
    ManagedBy = "terraform"
  }


  depends_on = [module.rds]
}
