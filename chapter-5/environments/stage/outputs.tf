output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}

output "db_address" {
  value       = module.rds.address
  description = "The connection endpoint"
}

output "db_port" {
  value       = module.rds.port
  description = "The connection port"
}
