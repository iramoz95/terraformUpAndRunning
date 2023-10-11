variable "iam_user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["ian", "terraform"]
}

variable "clouds" {
  description = "map"
  type        = map(string)
  default = {
    AWS   = "Amazon Web Services",
    GCP   = "Google Cloud Platform",
    AZURE = "Microsoft Azure",
  }
}

variable "backend_bucket_names" {
  description = "Create S3 buckets for backend state with these names"
  type        = list(string)
  default     = ["stage-irz-terraform-state", "prod-irz-terraform-state"]
}

variable "backend_dynamodb_table_names" {
  description = "Create DynamoDB tables for backend state with these names"
  type        = list(string)
  default     = ["stage-irz-terraform-locks", "prod-irz-terraform-locks"]
}
