resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = terraform.workspace == "default" ? var.default_instance_type : var.instance_type
}

# #==========================================
# # Remote State Storage S3 Bucket
# #==========================================

# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "terraform-state-irz"
#   #Prevent accidental deletion of the bucket
#   lifecycle {
#     prevent_destroy = true
#   }
# }

# # Enable versioning so you can see the full revision history of your
# # state files
# resource "aws_s3_bucket_versioning" "name" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enable server-side encryption by default
# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.terraform_state.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# #Explicitly block public access to the bucket
# resource "aws_s3_bucket_public_access_block" "block_public_access" {
#   bucket                  = aws_s3_bucket.terraform_state.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# #==========================================
# # Remote State Storage DynamoDB Table
# #==========================================
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-locks-irz"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
