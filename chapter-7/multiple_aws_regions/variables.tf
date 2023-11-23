variable "ami_id_region_1" {
  type        = string
  default     = "ami-0230bd60aa48260c6"
  description = "The AMI to use for the EC2 instance"
}

variable "ami_id_region_2" {
  type        = string
  default     = "ami-06d4b7182ac3480fa"
  description = "The AMI to use for the EC2 instance"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"

}
