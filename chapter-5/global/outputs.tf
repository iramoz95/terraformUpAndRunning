output "all_iam_user_arns" {
  value       = module.users.all_arns
  description = "The ARNs of the created IAM users"
}

output "upper_names" {
  value       = [for name in module.users.all_names : upper(name)]
  description = "The upper case names of the created IAM users"
}

output "short_upper_names" {
  value       = [for name in module.users.all_names : upper(name) if length(name) < 5]
  description = "The short than 5 chars upper case names of the created IAM users"
}

output "clouds" {
  value       = [for acronym, name in var.clouds : "${acronym} stands for ${name}"]
  description = "The acronym - name of the clouds"
}

output "upper_cloud_names" {
  value       = { for acronym, name in var.clouds : upper(acronym) => upper(name) }
  description = "The upper case names of the clouds"
}

output "for_directive" {
  value       = "%{for acronym, name in var.clouds}${acronym} stands for ${name}, %{endfor}"
  description = "The acronyms of the clouds"
}

output "for_dirictive_index" {
  value       = "%{for i, name in var.iam_user_names}(${i}) ${name}, %{endfor}"
  description = "The acronyms of the clouds"
}

output "all_s3_backend_bucket_arns" {
  value       = module.s3_backends[*].s3_bucket_arn
  description = "The ARNs of the created S3 backend state buckets"
}

output "all_dynamodb_table_names" {
  value       = module.dynamodb_table[*].dynamodb_table_name
  description = "The name of the DynamoDB table"
}


