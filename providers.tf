terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
  
  }
}

provider "aws" {
  region = var.region

  profile = var.aws_profile

  allowed_account_ids = [var.aws_account_id]

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/CloudWatchDashboardRole"
  }
}