📊 Monitoring Dashboard - AWS CloudWatch
🎯 Descripción del Proyecto
Dashboard de CloudWatch creado con Terraform para monitorear costos y performance de servicios EMR, EC2 y S3 en AWS, utilizando exclusivamente métricas gratuitas ($0 costo).

👨‍💻 Autor
Richard Chamorro
📧 finopslatam@gmail.com
💼 Especialista en Gestión de Finanzas en la Nube AWS
🏢 FinOps Latam

✨ Lo que Logramos
✅ Objetivos Cumplidos:
📊 Dashboard completo de CloudWatch con múltiples widgets

💰 Costo $0 - Solo métricas gratuitas de AWS

🛠️ Infrastructure as Code con Terraform

📈 Monitoreo en tiempo real de EMR, EC2 y S3

🔄 Código versionado en GitHub

🚀 Configuración reproducible y mantenible

⚡ Tecnologías Utilizadas:
Terraform: Infrastructure as Code

AWS CloudWatch: Monitoreo y dashboards

AWS EMR: Elastic MapReduce

AWS EC2: Elastic Compute Cloud

AWS S3: Simple Storage Service

Git/GitHub: Control de versiones

Git Bash: Terminal en Windows

📋 Estructura del Proyecto
text
monitoring-dashboard/
├── main.tf          # Configuración principal del dashboard
├── providers.tf     # Configuración de proveedores AWS
├── variables.tf     # Variables de Terraform
├── outputs.tf       # URLs y outputs del deployment
├── .gitignore       # Archivos excluidos de Git
└── README.md        # Esta documentación
🎨 Dashboard Incluye
📊 Métricas EMR (Gratuitas):
RunningInstances - Instancias EMR activas

MemoryUtilization - Uso de memoria en %

AppsRunning/Pending/Completed - Estado de aplicaciones

ContainerAllocated/Reserved/Pending - Uso de containers

⚡ Métricas EC2 (Gratuitas):
CPUUtilization - Uso de CPU en %

NetworkIn/NetworkOut - Tráfico de red

DiskReadBytes/DiskWriteBytes - Actividad de disco

StatusCheckFailed - Chequeos de estado fallidos

💾 Métricas S3 (Gratuitas):
BucketSizeBytes - Tamaño de almacenamiento en buckets

NumberOfObjects - Número total de objetos

GetRequests/PutRequests - Operaciones de lectura/escritura

BytesDownloaded/BytesUploaded - Transferencia de datos

💡 Paneles Informativos:
Recomendaciones de optimización para Free Tier

Límites mensuales del Free Tier

Métricas clave a monitorear

Guías de thresholds para scaling

Widgets Single Value para métricas principales

💰 Modelo de Costos: $0 USD
✅ Gratis:
Dashboard de CloudWatch

Métricas estándar de AWS (EMR, EC2, S3)

Almacenamiento de configuración

10 métricas custom por mes

1 millón de solicitudes API

5GB S3 Standard Storage

750 horas EC2 t2/t3.micro

❌ Excluido (Para mantener $0 costo):
Cost Explorer API calls

Alarmas premium de CloudWatch

Métricas personalizadas avanzadas

Logs almacenados prolongadamente

Períodos de métricas menores a 5 minutos

🚀 Como Usar
1. Prerrequisitos:
bash
# Terraform instalado
terraform --version

# AWS CLI configurado
aws configure

# Credenciales AWS con permisos:
# - cloudwatch:PutDashboard
# - cloudwatch:GetDashboard
# - cloudwatch:ListMetrics
# - s3:GetBucketPolicy
# - ec2:DescribeInstances
# - emr:ListClusters
2. Configuración:
bash
# Clonar repositorio
git clone https://github.com/finopslatam-sudo/monitoring-dashboard.git
cd monitoring-dashboard

# Configurar variables (opcional)
export AWS_ACCESS_KEY_ID="tu-access-key"
export AWS_SECRET_ACCESS_KEY="tu-secret-key"
export AWS_REGION="us-east-1"
3. Despliegue:
bash
# Inicializar Terraform
terraform init

# Verificar plan de despliegue
terraform plan

# Aplicar configuración
terraform apply

# Confirmar con 'yes'
4. Acceso al Dashboard:
bash
# Obtener URL del dashboard
terraform output dashboard_url
🔧 Personalización
Variables Modificables:
hcl
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
📊 Métricas Clave por Servicio
EMR - Puntos de Atención:
🟢 CPU < 70% - Optimo

🟡 CPU 70-85% - Considerar scaling

🔴 CPU > 85% - Scaling urgente

💾 Memory > 90% - Optimizar aplicaciones

EC2 - Recomendaciones:
⏰ Apagar instancias en horarios no laborales

📊 Right-sizing basado en uso real

🔄 Usar Spot Instances para workloads flexibles

S3 - Optimización:
💾 Implementar S3 Lifecycle Policies

📊 Usar S3 Intelligent-Tiering

🗑️ Limpiar archivos temporales semanalmente

📉 Monitorizar transferencia de datos

🛠️ Comandos Útiles
Actualizar Dashboard:
bash
# Modificar main.tf y aplicar cambios
terraform plan
terraform apply
Destruir Recursos:
bash
# Eliminar dashboard (no elimina métricas AWS)
terraform destroy
Ver Estado:
bash
# Estado actual de Terraform
terraform show

# Listar recursos desplegados
terraform state list
🔒 Seguridad
Credenciales:
Usar variables de entorno para credenciales AWS

Nunca commitear archivos .tfvars con secrets

Utilizar AWS IAM Roles cuando sea posible

Permisos Mínimos:
json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutDashboard",
                "cloudwatch:GetDashboard",
                "cloudwatch:ListDashboards"
            ],
            "Resource": "*"
        }
    ]
}
🤝 Contribución
Flujo de Trabajo:
Fork del repositorio

Crear feature branch (git checkout -b feature/mejora)

Commit de cambios (git commit -am 'Agregar mejora')

Push al branch (git push origin feature/mejora)

Crear Pull Request

Convenciones:
Commits en español o inglés

Documentar nuevas métricas agregadas

Mantener compatibilidad con Free Tier

Testear cambios con terraform plan

📞 Soporte
Problemas Comunes:
Error de permisos: Verificar IAM Policies

Métricas no aparecen: Esperar 5-15 minutos

Dashboard vacío: Verificar región y nombres

Contacto del Autor:
Email: finopslatam@gmail.com

Especialidad: FinOps - Gestión de Finanzas en la Nube AWS

Servicios: Optimización de costos, arquitectura cloud eficiente

Recursos:
Documentación AWS CloudWatch

Terraform AWS Provider

AWS Free Tier Details