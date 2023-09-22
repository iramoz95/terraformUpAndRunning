output "autoscaling_group_arn" {
  value       = aws_autoscaling_group.example.arn
  description = "An Auto Scaling Group ARN that the load balancer will use for health checks"
}
