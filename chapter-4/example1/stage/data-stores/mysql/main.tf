resource "aws_db_instance" "example" {
  identifier          = var.db_identifier
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  publicly_accessible = true
}
