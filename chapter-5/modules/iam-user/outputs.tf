output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}

output "all_names" {
  value = values(aws_iam_user.example)[*].name
}

output "ian_cloudwatch_policy_arn" {
  value = one(concat((
    var.give_ian_cloudwatch_full_access
    ? aws_iam_user_policy_attachment.ian_cloudwatch_full_access[*].policy_arn
    : aws_iam_user_policy_attachment.ian_cloudwatch_read_only[*].policy_arn
  )))
}
