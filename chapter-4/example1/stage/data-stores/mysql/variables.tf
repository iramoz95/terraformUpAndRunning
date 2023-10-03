variable "db_identifier" {
  description = "The name for the database"
  type        = string
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
