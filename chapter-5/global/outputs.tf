output "all_iam_user_arns" {
  value       = module.users[*].user_arn
  description = "The ARNs of the created IAM users"
}

output "all_s3_backend_bucket_arns" {
  value       = module.s3_backends[*].s3_bucket_arn
  description = "The ARNs of the created S3 backend state buckets"
}

output "all_dynamodb_table_names" {
  value       = module.dynamodb_table[*].dynamodb_table_name
  description = "The name of the DynamoDB table"
}
