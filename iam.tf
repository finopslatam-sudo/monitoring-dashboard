# =====================================================
# POLICY - CLOUDWATCH DASHBOARD
# =====================================================

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

# =====================================================
# ROLE - DASHBOARD (EC2 LOCAL)
# =====================================================

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

# =====================================================
# POLICY - FINOPS READONLY
# =====================================================

resource "aws_iam_policy" "finops_readonly_policy" {
  name        = "FinOpsLatamReadOnlyPolicy"
  description = "Permisos mínimos para análisis FinOps"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      {
        Effect = "Allow"
        Action = [
          "ce:GetCostAndUsage",
          "ce:GetCostForecast"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes"
        ]
        Resource = "*"
      },

      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
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

# =====================================================
# ROLE - FINOPS SaaS (ASSUME ROLE DESDE HETZNER)
# =====================================================

resource "aws_iam_role" "finops_saas_role" {
  name = "FinOpsLatamSaaSRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*" # protegido por External ID
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.finops_external_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "finops_attach" {
  role       = aws_iam_role.finops_saas_role.name
  policy_arn = aws_iam_policy.finops_readonly_policy.arn
}
