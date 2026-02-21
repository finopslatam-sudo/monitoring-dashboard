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
# POLICY - FINOPS READONLY (CORREGIDA Y EXPANDIDA)
# =====================================================

resource "aws_iam_policy" "finops_readonly_policy" {
  name        = "FinOpsLatamReadOnlyPolicy"
  description = "Permisos read-only seguros para análisis FinOps y Cost Explorer"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # =========================
      # COST EXPLORER
      # =========================
      {
        Effect = "Allow"
        Action = [
          "ce:GetCostAndUsage",
          "ce:GetCostForecast",
          "ce:GetDimensionValues"
        ]
        Resource = "*"
      },

      # =========================
      # EC2 READ ONLY
      # =========================
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:DescribeAddresses",
          "ec2:DescribeImages",
          "ec2:DescribeSecurityGroups"
        ]
        Resource = "*"
      },

      # =========================
      # ELB READ ONLY
      # =========================
      {
        Effect = "Allow"
        Action = [
          "elasticloadbalancing:DescribeLoadBalancers"
        ]
        Resource = "*"
      },

      # =========================
      # S3 READ ONLY
      # =========================
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Resource = "*"
      },

      # =========================
      # CLOUDWATCH READ ONLY
      # =========================
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ]
        Resource = "*"
      },

      # =========================
      # STS SAFE CHECK
      # =========================
      {
        Effect = "Allow"
        Action = [
          "sts:GetCallerIdentity"
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
          AWS = "arn:aws:iam::383704034225:root"
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