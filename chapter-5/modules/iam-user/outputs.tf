output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}

output "all_names" {
  value = values(aws_iam_user.example)[*].name
}
