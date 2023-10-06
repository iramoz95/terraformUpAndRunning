output "address" {
  value       = aws_db_instance.data_storage.address
  description = "The connection endpoint"
}

output "port" {
  value       = aws_db_instance.data_storage.port
  description = "The connection port"
}
