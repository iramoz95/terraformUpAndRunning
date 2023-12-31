#========================
# IAM users
#========================
module "users" {
  source                          = "../modules/iam-user"
  user_names                      = var.iam_user_names
  give_ian_cloudwatch_full_access = false
}

#========================
# S3 remote state backend
#========================
module "s3_backends" {
  source      = "../modules/s3_backend"
  count       = length(var.backend_bucket_names)
  bucket_name = var.backend_bucket_names[count.index]
}

#========================
# DynamoDB remote state backend
#========================
module "dynamodb_table" {
  source       = "../modules/dynamodb"
  count        = length(var.backend_dynamodb_table_names)
  table_name   = var.backend_dynamodb_table_names[count.index]
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
}
