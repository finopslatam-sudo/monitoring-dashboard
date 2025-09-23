resource "aws_cloudwatch_dashboard" "cost_dashboard" {
  dashboard_name = "cost-monitoring-dashboard-free"

  dashboard_body = jsonencode({
    widgets = [
      # ==================== PANEL INFORMATIVO ==================
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 3

        properties = {
          markdown = "# 📋 Dashboard de Monitoreo GRATIS\n## 🎯 Objetivo: Optimización de recursos\n### 💰 Métricas dentro del Free Tier de AWS"
        }
      },

      # ==================== CONSUMO S3 ==================
      {
        type   = "metric"
        x      = 0
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "NumberOfObjects", { "label" : "Total Objetos", "period" : 86400 }],
            ["AWS/S3", "BucketSizeBytes", { "label" : "Tamaño Bucket (MB)", "period" : 86400, "yAxis" : "right" }]
          ]
          period = 86400 # 1 día - menos datos, menos costo
          stat   = "Average"
          region = "us-east-1"
          title  = "📊 S3 - Consumo (Métricas Diarias)"
          view   = "timeSeries"
          yAxis = {
            left = {
              min   = 0,
              label = "Número Objetos"
            },
            right = {
              min   = 0,
              label = "Bytes"
            }
          }
        }
      },

      # ==================== OPERACIONES S3 ==================
      {
        type   = "metric"
        x      = 12
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "GetRequests", { "label" : "GET Requests" }],
            ["AWS/S3", "PutRequests", { "label" : "PUT Requests" }]
          ]
          period  = 3600 # 1 hora - balance entre detalle y costo
          stat    = "Sum"
          region  = "us-east-1"
          title   = "🔁 S3 - Operaciones Principales"
          view    = "timeSeries"
          stacked = false
        }
      },

      # ==================== UTILIZACIÓN EC2 ==================
      {
        type   = "metric"
        x      = 0
        y      = 9
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", { "label" : "CPU %" }],
            ["AWS/EC2", "NetworkIn", { "label" : "Network In", "yAxis" : "right" }],
            ["AWS/EC2", "NetworkOut", { "label" : "Network Out", "yAxis" : "right" }]
          ]
          period = 300 # 5 minutos - estándar
          stat   = "Average"
          region = "us-east-1"
          title  = "⚡ EC2 - Métricas de Performance"
          view   = "timeSeries"
          yAxis = {
            left = {
              min   = 0,
              max   = 100,
              label = "% CPU"
            },
            right = {
              min   = 0,
              label = "Bytes"
            }
          }
        }
      },

      # ==================== DISCO EC2 ====================
      {
        type   = "metric"
        x      = 12
        y      = 9
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "DiskReadBytes", { "label" : "Disk Read" }],
            ["AWS/EC2", "DiskWriteBytes", { "label" : "Disk Write" }]
          ]
          period  = 300 # 5 minutos
          stat    = "Average"
          region  = "us-east-1"
          title   = "💾 EC2 - Actividad de Disco"
          view    = "timeSeries"
          stacked = false
        }
      },

      # ==================== UTILIZACIÓN EMR ====================
      {
        type   = "metric"
        x      = 0
        y      = 15
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "RunningInstances", { "label" : "Instancias Activas" }],
            ["AWS/ElasticMapReduce", "MemoryUtilization", { "label" : "Memoria %", "yAxis" : "right" }]
          ]
          period = 300 # 5 minutos
          stat   = "Average"
          region = "us-east-1"
          title  = "🔍 EMR - Utilización"
          view   = "timeSeries"
          yAxis = {
            left = {
              min   = 0,
              label = "Instancias"
            },
            right = {
              min   = 0,
              max   = 100,
              label = "% Memoria"
            }
          }
        }
      },

      # ==================== ESTADO EMR ====================
      {
        type   = "metric"
        x      = 8
        y      = 15
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "AppsRunning", { "label" : "Apps Running" }],
            ["AWS/ElasticMapReduce", "AppsPending", { "label" : "Apps Pending" }]
          ]
          period  = 300
          stat    = "Sum"
          region  = "us-east-1"
          title   = "📊 EMR - Estado Apps"
          view    = "timeSeries"
          stacked = false
        }
      },

      # ==================== RESUMEN S3 ====================
      {
        type   = "metric"
        x      = 16
        y      = 15
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "BucketSizeBytes", { "label" : "Tamaño Actual", "period" : 86400 }]
          ]
          period = 86400
          stat   = "Average"
          region = "us-east-1"
          title  = "💽 S3 - Almacenamiento"
          view   = "singleValue"
          annotations = {
            horizontal = [
              {
                color = "#1f78b4"
                label = "Límite Free: 5GB"
                value = 5368709120 # 5GB en bytes
              }
            ]
          }
        }
      },

      # ==================== PANEL OPTIMIZACIÓN ====================
      {
        type   = "text"
        x      = 0
        y      = 21
        width  = 12
        height = 4

        properties = {
          markdown = "## 💡 Optimización Free Tier\n- ⏰ **Apagar instancias** cuando no se usen\n- 💾 **S3 Lifecycle** para archivos antiguos\n- 📊 **Métricas cada 5min** para ahorro\n- 🔄 **Periodos largos** en S3 (24h)\n- 🚫 **Evitar métricas premium**"
        }
      },

      # ==================== LÍMITES FREE TIER ====================
      {
        type   = "text"
        x      = 12
        y      = 21
        width  = 12
        height = 4

        properties = {
          markdown = "## 🎯 Límites Free Tier (Mensual)\n- 📊 **10 métricas custom**\n- ⏰ **1M solicitudes API**\n- 💾 **5GB S3 Standard**\n- 🖥️ **750h EC2 t2/t3.micro**\n- 📈 **Alarms básicos** incluidos"
        }
      },

      # ==================== SINGLE VALUE METRICS ====================
      {
        type   = "metric"
        x      = 0
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", { "label" : "CPU Avg %" }]
          ]
          period = 3600 # 1 hora para ahorrar
          stat   = "Average"
          region = "us-east-1"
          title  = "📈 CPU Promedio"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 4
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "NumberOfObjects", { "label" : "Total Objetos", "period" : 86400 }]
          ]
          period = 86400
          stat   = "Average"
          region = "us-east-1"
          title  = "📁 Objetos S3"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 8
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "RunningInstances", { "label" : "Instancias EMR" }]
          ]
          period = 3600
          stat   = "Maximum"
          region = "us-east-1"
          title  = "🖥️ EMR Activas"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "StatusCheckFailed", { "label" : "Checks Fallidos" }]
          ]
          period = 3600
          stat   = "Sum"
          region = "us-east-1"
          title  = "❌ EC2 Status"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 16
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/S3", "GetRequests", { "label" : "GET Requests/hora" }]
          ]
          period = 3600
          stat   = "Sum"
          region = "us-east-1"
          title  = "🔍 S3 GETs"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 20
        y      = 25
        width  = 4
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "NetworkOut", { "label" : "Network Out" }]
          ]
          period = 3600
          stat   = "Sum"
          region = "us-east-1"
          title  = "📤 Salida Red"
          view   = "singleValue"
        }
      }

    ]
  })
}