resource "aws_cloudwatch_dashboard" "cost_dashboard" {
  dashboard_name = "cost-monitoring-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Billing", "EstimatedCharges", "ServiceName", "AmazonEMR", "Currency", "USD"]
          ]
          period = 86400
          stat   = "Maximum"
          region = "us-east-1"
          title  = "Costos EMR (USD)"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Billing", "EstimatedCharges", "ServiceName", "AmazonEC2", "Currency", "USD"]
          ]
          period = 86400
          stat   = "Maximum"
          region = "us-east-1"
          title  = "Costos EC2 (USD)"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 6
        width  = 24
        height = 3

        properties = {
          markdown = "# Dashboard de Costos - EMR & EC2\n*Última actualización: ${timestamp()}*"
        }
      }
    ]
  })
}