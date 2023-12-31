variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "ami_id" {
  description = "The AMI to run in the cluster"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "db_address" {
  description = "The connection endpoint"
  type        = string
}

variable "db_port" {
  description = "The connection port"
  type        = number
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}

variable "server_text" {
  description = "The text the server should return"
  type        = string
}
