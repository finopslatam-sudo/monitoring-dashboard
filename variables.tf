# variables.tf - Variables expandidas
variable "aws_access_key" {
  description = "AWS Access Key (opcional si se usa profile o IAM Role)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key (opcional si se usa profile o IAM Role)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "dashboard_name" {
  description = "Nombre del dashboard CloudWatch"
  type        = string
  default     = "cost-monitoring-dashboard-free"
}

variable "aws_profile" {
  description = "Perfil de AWS CLI a usar"
  type        = string
  default     = "default"
}

variable "aws_account_id" {
  description = "AWS Account ID para validación de seguridad"
  type        = string
  sensitive   = true
}

variable "finops_external_id" {
  description = "External ID usado por FinOpsLatam SaaS"
  type        = string
}
