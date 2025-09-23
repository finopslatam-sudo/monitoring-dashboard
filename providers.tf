# providers.tf - Configuración segura
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Backend opcional para guardar state de forma segura
  backend "s3" {
    # Configurar después del primer deploy
  }
}

provider "aws" {
  region = var.region

  # Usar perfil de AWS CLI o variables de entorno
  profile = var.aws_profile

  # Seguridad adicional
  allowed_account_ids = [var.aws_account_id]

  # Opcional: Asumir role con permisos mínimos
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/CloudWatchDashboardRole"
  }
}