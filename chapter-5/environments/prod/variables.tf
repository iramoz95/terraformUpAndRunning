variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "allowed_cidr_blocks" {
  description = "The CIDR blocks allowed to access the database"
  type        = list(string)
  sensitive   = true
}

variable "autoscaling_schedule_start_time" {
  description = "The start time of the autoscaling schedule"
  type        = string
}

variable "autoscaling_schedule_end_time" {
  description = "The end time of the autoscaling schedule"
  type        = string
}
