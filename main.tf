resource "aws_cloudwatch_dashboard" "cost_dashboard" {
  dashboard_name = "cost-monitoring-dashboard-free"

  dashboard_body = jsonencode({
    widgets = [
      # ==================== PANEL INFORMATIVO ====================
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 3

        properties = {
          markdown = "# 📋 Dashboard de Monitoreo - EMR & EC2\n## 🎯 Objetivo: Optimización de recursos\n### 💰 Métricas de utilización (GRATIS)"
        }
      },

      # ==================== UTILIZACIÓN EMR ====================
      {
        type   = "metric"
        x      = 0
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "RunningInstances", { "label" : "Instancias EMR Activas" }],
            ["AWS/ElasticMapReduce", "MemoryUtilization", { "label" : "Memoria Utilizada %", "yAxis" : "right" }]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "🔍 EMR - Utilización de Recursos"
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

      # ==================== UTILIZACIÓN EC2 ====================
      {
        type   = "metric"
        x      = 12
        y      = 3
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", { "label" : "CPU %" }],
            ["AWS/EC2", "NetworkIn", { "label" : "Network In", "yAxis" : "right" }],
            ["AWS/EC2", "NetworkOut", { "label" : "Network Out", "yAxis" : "right" }]
          ]
          period = 300
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

      # ==================== ESTADO INSTANCIAS EMR ====================
      {
        type   = "metric"
        x      = 0
        y      = 9
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "AppsRunning", { "label" : "Apps Running" }],
            ["AWS/ElasticMapReduce", "AppsPending", { "label" : "Apps Pending" }],
            ["AWS/ElasticMapReduce", "AppsCompleted", { "label" : "Apps Completed" }]
          ]
          period  = 300
          stat    = "Sum"
          region  = "us-east-1"
          title   = "📊 EMR - Estado de Aplicaciones"
          view    = "timeSeries"
          stacked = false
        }
      },

      # ==================== DISCO EC2 ====================
      {
        type   = "metric"
        x      = 8
        y      = 9
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "DiskReadBytes", { "label" : "Disk Read" }],
            ["AWS/EC2", "DiskWriteBytes", { "label" : "Disk Write" }],
            ["AWS/EC2", "DiskReadOps", { "label" : "Read Ops", "yAxis" : "right" }],
            ["AWS/EC2", "DiskWriteOps", { "label" : "Write Ops", "yAxis" : "right" }]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "💾 EC2 - Actividad de Disco"
          view   = "timeSeries"
          yAxis = {
            left = {
              min   = 0,
              label = "Bytes"
            },
            right = {
              min   = 0,
              label = "Operaciones"
            }
          }
        }
      },

      # ==================== RESUMEN EMR ====================
      {
        type   = "metric"
        x      = 16
        y      = 9
        width  = 8
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "ContainerAllocated", { "label" : "Containers Alloc" }],
            ["AWS/ElasticMapReduce", "ContainerReserved", { "label" : "Containers Reserved" }],
            ["AWS/ElasticMapReduce", "ContainerPending", { "label" : "Containers Pending" }]
          ]
          period  = 300
          stat    = "Sum"
          region  = "us-east-1"
          title   = "📦 EMR - Utilización de Containers"
          view    = "timeSeries"
          stacked = false
        }
      },

      # ==================== PANEL DE RECOMENDACIONES ====================
      {
        type   = "text"
        x      = 0
        y      = 15
        width  = 12
        height = 4

        properties = {
          markdown = "## 💡 Recomendaciones de Optimización\n- ⏰ **Scale down EMR** en horarios no laborales\n- 💾 **Clean temporary files** weekly\n- 📊 **Monitor memory usage** para right-sizing\n- 🔄 **Use spot instances** para workloads flexibles"
        }
      },

      # ==================== MÉTRICAS CLAVE ====================
      {
        type   = "text"
        x      = 12
        y      = 15
        width  = 12
        height = 4

        properties = {
          markdown = "## 🎯 Métricas Clave a Monitorear\n- 🟢 **CPU < 70%** - Buen uso de recursos\n- 🟡 **CPU 70-85%** - Considerar scaling\n- 🔴 **CPU > 85%** - Necesita scaling urgente\n- 💾 **Memory > 90%** - Optimizar aplicaciones"
        }
      },

      # ==================== SINGLE VALUE METRICS ====================
      {
        type   = "metric"
        x      = 0
        y      = 19
        width  = 6
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", { "label" : "Avg CPU %" }]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "📈 CPU Promedio"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 6
        y      = 19
        width  = 6
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "MemoryUtilization", { "label" : "Avg Memory %" }]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "📊 Memoria Promedio"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 19
        width  = 6
        height = 6

        properties = {
          metrics = [
            ["AWS/ElasticMapReduce", "RunningInstances", { "label" : "Instancias Activas" }]
          ]
          period = 300
          stat   = "Maximum"
          region = "us-east-1"
          title  = "🖥️ Instancias EMR"
          view   = "singleValue"
        }
      },

      {
        type   = "metric"
        x      = 18
        y      = 19
        width  = 6
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "StatusCheckFailed", { "label" : "Failed Status Checks" }]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "❌ Checks Fallidos"
          view   = "singleValue"
        }
      }

    ]
  })
}