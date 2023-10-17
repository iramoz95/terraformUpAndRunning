variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of allowed CIDR blocks"
}

variable "ami_id" {
  type        = string
  description = "The AMI to run in the cluster"
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}

variable "key_name" {
  type        = string
  description = "Name of the ec2 instance"
}

variable "name" {
  type        = string
  description = "Name of the ec2 instance"
}
