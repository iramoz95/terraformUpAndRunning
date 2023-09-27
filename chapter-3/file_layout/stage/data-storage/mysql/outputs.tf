output "address" {
  value       = aws_db_instance.example.address
  description = "The connection endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The connection port"
}
