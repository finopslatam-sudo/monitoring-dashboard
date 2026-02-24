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

# =====================================================
# ATTACH AWS MANAGED READ ONLY (GLOBAL)
# =====================================================

resource "aws_iam_role_policy_attachment" "finops_readonly_attach" {
  role       = aws_iam_role.finops_saas_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# =====================================================
# CUSTOM FINOPS BILLING POLICY
# =====================================================

resource "aws_iam_policy" "finops_billing_policy" {
  name        = "FinOpsLatamBillingPolicy"
  description = "Permisos adicionales para Cost Explorer y Savings Plans"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      {
        Effect = "Allow"
        Action = [
          "ce:GetCostAndUsage",
          "ce:GetCostForecast",
          "ce:GetDimensionValues",
          "ce:GetReservationCoverage",
          "ce:GetSavingsPlansCoverage",
          "ce:GetSavingsPlansUtilization",
          "ce:GetReservationUtilization"
        ]
        Resource = "*"
      },

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

resource "aws_iam_role_policy_attachment" "finops_billing_attach" {
  role       = aws_iam_role.finops_saas_role.name
  policy_arn = aws_iam_policy.finops_billing_policy.arn
}