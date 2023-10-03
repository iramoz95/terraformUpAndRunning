module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "stage-irz-terraform-state"
  db_remote_state_key    = "data-stores/mysql/terraform.tfstate"
  ami_id                 = "ami-03a6eaae9938c858c"
  server_port            = 8080
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 10
}
