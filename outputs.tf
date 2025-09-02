output "dashboard_url" {
  description = "URL del dashboard de CloudWatch"
  value       = "https://${var.region}.console.aws.amazon.com/cloudwatch/home?region=${var.region}#dashboards:name=${aws_cloudwatch_dashboard.cost_dashboard.dashboard_name}"
}
