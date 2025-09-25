🎯 Descripción del Proyecto
Dashboard de CloudWatch creado con Terraform para monitorear costos y performance de servicios AWS en tiempo real, utilizando exclusivamente recursos gratuitos del Free Tier. Infrastructure as Code completamente funcional y optimizado para máxima visibilidad con costo $0.

Autor
Richard Chamorro
finopslatam@gmail.com
Especialista en Gestión de Finanzas en la Nube AWS
FinOps Latam

🚀 Lo que Logramos
Objetivos Cumplidos:
✅ Dashboard completo de CloudWatch con 15+ widgets integrados
✅ Costo $0 - Exclusivamente dentro de AWS Free Tier
✅ Infrastructure as Code con Terraform reutilizable
✅ Monitoreo en tiempo real de EC2, S3, Lambda y métricas custom
✅ Automatización completa con funciones Lambda
✅ Simulador integrado para generación de datos demo
✅ Código versionado en GitHub con estructura profesional
✅ Despliegue seguro con permisos mínimos IAM

Tecnologías Utilizadas:
Terraform: Infrastructure as Code
AWS CloudWatch: Dashboards y métricas
AWS EC2: Instancias t3.micro Free Tier
AWS S3: Almacenamiento objeto
AWS Lambda: Funciones serverless
Python 3.9: Scripts de simulación y automatización
Git/GitHub: Control de versiones
AWS IAM: Gestión de permisos segura

📁 Estructura del Proyecto

monitoring-dashboard/
├── main.tf          # Configuración principal del dashboard CloudWatch
├── iam.tf           # Políticas IAM para permisos de CloudWatch
├── providers.tf     # Configuración de proveedores AWS
├── variables.tf     # Variables de Terraform
├── outputs.tf       # URLs y outputs del deployment
├── terraform.tfvars # Valores específicos del ambiente
└── README.md        # Esta documentación

📊 Dashboard Incluye
🔍 Métricas EC2 (Gratuitas):
CPUUtilization - Uso de CPU en porcentaje
NetworkIn/NetworkOut - Tráfico de red entrante/saliente
DiskReadBytes/DiskWriteBytes - Actividad de disco
StatusCheckFailed - Chequeos de estado de instancia

💾 Métricas S3 (Gratuitas):
BucketSizeBytes - Tamaño de almacenamiento en buckets
NumberOfObjects - Número total de objetos almacenados
GetRequests/PutRequests - Operaciones de lectura/escritura

⚡ Métricas Lambda (Gratuitas):
Invocations - Número de ejecuciones de funciones
Duration - Tiempo de ejecución promedio
Errors - Tasas de error en funciones

📈 Métricas Personalizadas (Gratuitas):
FinOps/Demo namespace - Métricas custom para simulaciones
SimulatedCPULoad - Carga de CPU simulada para demo
InstancesStopped - Métricas de automatización Lambda

🎯 Paneles Informativos:
Resumen Free Tier - Uso actual vs límites mensuales
Recomendaciones de optimización - Mejores prácticas
Widgets Single Value - Métricas clave en tiempo real
Alertas visuales - Thresholds para toma de decisiones

🤝 Integración con Demo FinOps
Este dashboard se integra automáticamente con el proyecto demo-finops que incluye:
EC2 Instances: Genera métricas reales de performance
S3 Buckets: Proporciona datos de almacenamiento y operaciones
Lambda Functions: Ejecuciones automáticas y métricas
Simulador Python: Generación de datos demo en tiempo real

# Obtener URL del dashboard

terraform output dashboard_url
💰 Modelo de Costos: $0 USD
Servicios Incluidos en Free Tier:
CloudWatch Dashboard - Ilimitados dashboards
Métricas Estándar AWS - EC2, S3, Lambda (siempre gratuitas)
10 métricas custom/mes - Namespace FinOps/Demo
1 millón de solicitudes API - Consultas a CloudWatch
5GB S3 Standard Storage - Configuración Terraform
750 horas EC2 t3.micro - Instancia de demostración
1M invocaciones Lambda/mes - Funciones de automatización