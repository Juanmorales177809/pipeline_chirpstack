# 📦 Manual de Uso - Scripts ChirpStack y Glances para Raspberry Pi

Este repositorio contiene un conjunto de scripts diseñados para facilitar la instalación, configuración y monitoreo de un servidor **ChirpStack** en una **Raspberry Pi**, junto con herramientas de supervisión como **Glances** para visualizar el estado del sistema en tiempo real.

---

## 🗂 Archivos incluidos

### `chirpstack_backup.sql`
📄 **Descripción**: Archivo de respaldo de la base de datos PostgreSQL utilizada por ChirpStack.  
🔧 **Uso**: Se puede restaurar para recuperar configuraciones anteriores del sistema ChirpStack.

### `chirpstack-LSCR/`
📁 **Descripción**: Carpeta que contiene los archivos de configuración del contenedor Docker de ChirpStack basado en imágenes de [lscr.io](https://lscr.io).  
📦 **Contenido**: `docker-compose.yml`, archivos `.env`, configuraciones y volúmenes.

### `detener_glaces.sh`
🛑 **Descripción**: Script para detener el servicio de Glances que se ejecuta en segundo plano como servidor web.  
⚙️ **Uso**:  
`./detener_glaces.sh`

### `glances-venv/`
🐍 **Descripción**: Entorno virtual de Python que contiene Glances y sus dependencias.  
⚙️ **Uso**: Se activa automáticamente durante la instalación o ejecución del servicio de Glances.

### `instalar-chirpstack.sh`
🛰 **Descripción**: Script para instalar ChirpStack Network Server y Application Server usando Docker.  
⚙️ **Uso**:  
`chmod +x instalar-chirpstack.sh`  
`./instalar-chirpstack.sh`

### `instalar_database.sh`
🗄 **Descripción**: Script para instalar y configurar PostgreSQL y Redis, requeridos por ChirpStack.  
⚙️ **Uso**:  
`chmod +x instalar_database.sh`  
`./instalar_database.sh`

### `instalar-docker.sh`
🐳 **Descripción**: Script para instalar Docker y Docker Compose en la Raspberry Pi.  
⚙️ **Uso**:  
`chmod +x instalar-docker.sh`  
`./instalar-docker.sh`

### `instalar_glances_autostart.sh`
📊 **Descripción**: Instala Glances en un entorno virtual de Python y configura su ejecución automática como servidor web accesible desde el puerto 61208.  
⚙️ **Uso**:  
`chmod +x instalar_glances_autostart.sh`  
`./instalar_glances_autostart.sh`

---

## 🚀 Instrucciones de ejecución recomendadas

1. Instalar Docker y Docker Compose:  
   `./instalar-docker.sh`

2. Instalar la base de datos (PostgreSQL y Redis):  
   `./instalar_database.sh`

3. Instalar ChirpStack (Network + Application Server en contenedores Docker):  
   `./instalar-chirpstack.sh`

4. Instalar Glances como servidor web para monitoreo del sistema:  
   `./instalar_glances_autostart.sh`

5. Acceder a la interfaz web de Glances:  
   - Desde la misma Raspberry Pi: `http://localhost:61208`  
   - Desde otra máquina en la red: `http://<IP_DE_LA_RASPBERRY>:61208`

6. Detener Glances si es necesario:  
   `./detener_glaces.sh`

---

## 📌 Notas importantes

- Asegúrate de tener permisos de ejecución en todos los scripts:  
  `chmod +x *.sh`

- Ejecuta los scripts con `sudo` si es necesario:  
  `sudo ./script.sh`

- Es recomendable realizar una copia de seguridad periódica de la base de datos (`chirpstack_backup.sql`).

---

## 👨‍💻 Autor

**Juan Carlos Morales Guerra**  
_Ingeniero de Telecomunicaciones - LSCR_
