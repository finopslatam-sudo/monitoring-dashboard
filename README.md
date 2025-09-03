cat > README.md << 'EOF'
# 📊 Monitoring Dashboard - AWS CloudWatch

## 🎯 Descripción del Proyecto

Dashboard de CloudWatch creado con Terraform para monitorear **costos y performance de servicios EMR y EC2** en AWS, utilizando **exclusivamente métricas gratuitas** ($0 costo).

## ✨ Lo que Logramos

### ✅ **Objetivos Cumplidos:**
- 📊 Dashboard completo de CloudWatch con múltiples widgets
- 💰 **Costo $0** - Solo métricas gratuitas de AWS
- 🛠️ Infrastructure as Code con Terraform
- 📈 Monitoreo en tiempo real de EMR y EC2
- 🔄 Código versionado en GitHub
- 🚀 Configuración reproducible y mantenible

### ⚡ **Tecnologías Utilizadas:**
- **Terraform**: Infrastructure as Code
- **AWS CloudWatch**: Monitoreo y dashboards
- **AWS EMR**: Elastic MapReduce
- **AWS EC2**: Elastic Compute Cloud
- **Git/GitHub**: Control de versiones
- **Git Bash**: Terminal en Windows

## 📋 Estructura del Proyecto
monitoring/
├── main.tf # Configuración principal del dashboard
├── providers.tf # Configuración de proveedores AWS
├── variables.tf # Variables de Terraform
├── outputs.tf # URLs y outputs del deployment
├── .gitignore # Archivos excluidos de Git
└── README.md # Esta documentación

text

## 🎨 Dashboard Incluye

### 📊 **Métricas EMR (Gratuitas):**
- `RunningInstances` - Instancias EMR activas
- `MemoryUtilization` - Uso de memoria en %
- `AppsRunning/Pending/Completed` - Estado de aplicaciones
- `ContainerAllocated/Reserved/Pending` - Uso de containers

### ⚡ **Métricas EC2 (Gratuitas):**
- `CPUUtilization` - Uso de CPU en %
- `NetworkIn/NetworkOut` - Tráfico de red
- `DiskReadBytes/DiskWriteBytes` - Actividad de disco
- `DiskReadOps/DiskWriteOps` - Operaciones de disco
- `StatusCheckFailed` - Chequeos de estado fallidos

### 💡 **Paneles Informativos:**
- Recomendaciones de optimización
- Métricas clave a monitorear
- Guías de thresholds para scaling

## 💰 Modelo de Costos: $0 USD

### ✅ **Gratis:**
- Dashboard de CloudWatch
- Métricas estándar de AWS
- Almacenamiento de configuración

### ❌ **Excluido (Para mantener $0 costo):**
- Cost Explorer API calls
- Alarmas de CloudWatch
- Métricas personalizadas
- Logs almacenados

## 🚀 Como Usar

### **1. Prerrequisitos:**
```bash
# Terraform instalado
terraform --version

# AWS CLI configurado
aws configure

# Credenciales AWS con permisos:
# - cloudwatch:PutDashboard
# - cloudwatch:GetDashboard