variable "db_identifier" {
  description = "The name for the database"
  type        = string
}

variable "db_engine" {
  description = "The engine for the database"
  type        = string
}

variable "db_port" {
  description = "The port for the database"
  type        = number
}

variable "db_name" {
  description = "The name for the database"
  type        = string
}

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

