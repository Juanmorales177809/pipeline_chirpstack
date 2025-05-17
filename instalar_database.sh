#!/bin/bash

set -e

REPO_NAME="backend-LSCR"
REPO_URL="https://github.com/Juanmorales177809/backend-LSCR.git"
ENV_FILE=".env"


# 1. Solicita la IP o el host del broker MQTT
if [ ! -f "$REPO_NAME/$ENV_FILE" ]; then
  read -p "🔌 Ingresa la IP o el host del broker MQTT: " mqtt_host
  echo "MQTT_BROKER=$mqtt_host" > "$ENV_FILE"
  echo "✅ Archivo .env creado con MQTT_BROKER=$mqtt_host"
fi

# 2. Clonar el repositorio solo si no existe
if [ ! -d "$REPO_NAME" ]; then
  echo "📁 Clonando el repositorio $REPO_NAME..."
  git clone "$REPO_URL"
else
  echo "📂 El repositorio '$REPO_NAME' ya existe. Omitiendo clonación."
fi

# 3. Copiar el archivo .env al directorio del repositorio si no existe allí
if [ ! -f "$REPO_NAME/$ENV_FILE" ]; then
  cp "$ENV_FILE" "$REPO_NAME/"
  echo "📎 Archivo .env copiado al directorio del repositorio."
fi

# 4. Iniciar contenedores
cd "$REPO_NAME"
echo "🐳 Iniciando contenedores con Docker Compose..."
sudo docker compose up -d

# 5. Mostrar contenedores activos
echo "📦 Contenedores activos:"
sudo docker ps -a
