# =====================================================
# DATA SOURCE - AMI AMAZON LINUX 2
# =====================================================

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# =====================================================
# SECURITY GROUP (SIN PUERTOS ABIERTOS)
# =====================================================

resource "aws_security_group" "demo_sg" {
  name        = "finops-demo-sg"
  description = "Security group minimal sin puertos abiertos"

  ingress = []

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# =====================================================
# EC2 1 - ENCENDIDA
# =====================================================

resource "aws_instance" "demo_instance_running" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  security_groups = [aws_security_group.demo_sg.name]

  tags = {
    Name        = "finops-demo-running"
    Environment = "finops-demo"
  }
}

# =====================================================
# EC2 2 - DETENIDA (CASO FINOPS)
# =====================================================

resource "aws_instance" "demo_instance_stopped" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  security_groups = [aws_security_group.demo_sg.name]

  tags = {
    Name        = "finops-demo-stopped"
    Environment = "finops-demo"
  }
}

# Auto stop después de crear
resource "null_resource" "stop_instance" {
  provisioner "local-exec" {
    command = "aws ec2 stop-instances --instance-ids ${aws_instance.demo_instance_stopped.id} --region ${var.region}"
  }

  depends_on = [aws_instance.demo_instance_stopped]
}

# =====================================================
# EBS VOLUME NO ADJUNTO (HUÉRFANO)
# =====================================================

resource "aws_ebs_volume" "orphan_volume" {
  availability_zone = aws_instance.demo_instance_running.availability_zone
  size              = 5
  type              = "gp2"

  tags = {
    Name        = "finops-orphan-volume"
    Environment = "finops-demo"
  }
}

# =====================================================
# S3 BUCKET DEMO
# =====================================================

resource "aws_s3_bucket" "finops_bucket" {
  bucket = "finops-demo-${random_id.bucket_id.hex}"

  tags = {
    Name        = "finops-demo-bucket"
    Environment = "finops-demo"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

# =====================================================
# CLOUDWATCH DASHBOARD
# =====================================================

resource "aws_cloudwatch_dashboard" "cost_dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = [

      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 3

        properties = {
          markdown = "# 🚀 FinOps Demo Environment\nEC2 + EBS + S3 controlados dentro Free Tier"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization"]
          ]
          period = 900
          stat   = "Average"
          region = var.region
          title  = "EC2 CPU"
          view   = "timeSeries"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EBS", "VolumeReadBytes"],
            ["AWS/EBS", "VolumeWriteBytes"]
          ]
          period = 900
          stat   = "Sum"
          region = var.region
          title  = "EBS Activity"
          view   = "timeSeries"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 9
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "BucketSizeBytes", { "period" : 86400 }]
          ]
          period = 86400
          stat   = "Average"
          region = var.region
          title  = "S3 Storage"
          view   = "singleValue"
        }
      }

    ]
  })
}
