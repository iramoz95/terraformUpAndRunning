variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "example_db"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of allowed CIDR blocks"
  default     = ["0.0.0.0/0"]
}
