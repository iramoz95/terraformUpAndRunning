#================================
#Locals
#================================
locals {
  instance_class      = "db.t2.micro"
  allocated_storage   = 10
  publicly_accessible = true
}

#================================
#RDS
#================================
resource "aws_security_group" "mysql" {
  name        = "${var.db_identifier}-sg"
  description = "Security group for RDS"
  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

}

resource "aws_db_instance" "data_storage" {
  identifier          = var.db_identifier
  engine              = var.db_engine
  allocated_storage   = local.allocated_storage
  instance_class      = local.instance_class
  skip_final_snapshot = true
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  publicly_accessible = local.publicly_accessible

  vpc_security_group_ids = [aws_security_group.mysql.id]

  tags = {
    Name = var.db_identifier
  }
}

