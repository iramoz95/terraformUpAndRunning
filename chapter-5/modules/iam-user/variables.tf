variable "user_names" {
  description = "The name of the IAM user"
  type        = list(string)
}

variable "give_ian_cloudwatch_full_access" {
  description = "If true, ian gets full access to CloudWatch"
  type        = bool
}
