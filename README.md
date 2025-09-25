📊 Monitoring Dashboard - AWS CloudWatch
🎯 Descripción del Proyecto
Dashboard de CloudWatch creado con Terraform para monitorear costos y performance de servicios EMR, EC2 y S3 en AWS, utilizando exclusivamente métricas gratuitas ($0 costo). Infrastructure as Code completamente funcional y optimizado para Free Tier.

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
🔒 Despliegue seguro con permisos mínimos

⚡ Tecnologías Utilizadas:
Terraform: Infrastructure as Code
AWS CloudWatch: Monitoreo y dashboards
AWS EMR: Elastic MapReduce
AWS EC2: Elastic Compute Cloud
AWS S3: Simple Storage Service
Git/GitHub: Control de versiones
Git Bash: Terminal en Windows

📋 Estructura del Proyecto

monitoring-dashboard/
├── main.tf          # Configuración principal del dashboard CloudWatch
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

