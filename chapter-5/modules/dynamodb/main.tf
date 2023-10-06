resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  //name         = "stage-irz-terraform-locks"
  //billing_mode = "PAY_PER_REQUEST"
  //hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
