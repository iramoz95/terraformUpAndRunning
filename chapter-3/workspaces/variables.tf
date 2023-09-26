variable "ami_id" {
  description = "The AMI to run in the ec2"
  type        = string
  default     = "ami-04cb4ca688797756f"
}

variable "default_instance_type" {
  description = "The type of ec2 instance to run"
  type        = string
  default     = "t2.micro"
}

variable "instance_type" {
  description = "The type of ec2 instance to run"
  type        = string
  default     = "t2.nano"
}
