# iam.tf - Roles y Policies con permisos mínimos
resource "aws_iam_policy" "cloudwatch_dashboard_minimal" {
  name        = "CloudWatchDashboardMinimalPolicy"
  description = "Permisos mínimos para crear dashboards de CloudWatch"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutDashboard",
          "cloudwatch:GetDashboard", 
          "cloudwatch:DeleteDashboards",
          "cloudwatch:ListDashboards"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ]
        Resource = "*"
      }
    ]
  })
}

# Opcional: Role para EC2/instancias (si usas desde una instancia EC2)
resource "aws_iam_role" "dashboard_role" {
  name = "cloudwatch-dashboard-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dashboard_policy_attach" {
  role       = aws_iam_role.dashboard_role.name
  policy_arn = aws_iam_policy.cloudwatch_dashboard_minimal.arn
}