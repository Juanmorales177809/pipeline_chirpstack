#!/bin/bash
set -e

echo "🔄 Actualizando paquetes del sistema..."
sudo apt-get update && sudo apt-get upgrade -y

echo "📦 Instalando dependencias necesarias..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "🔐 Agregando la clave GPG oficial de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📝 Agregando el repositorio de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Actualizando el índice de paquetes..."
sudo apt-get update

echo "🐳 Instalando Docker Engine y Docker Compose plugin..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

echo "👤 Agregando el usuario actual al grupo 'docker'..."
sudo usermod -aG docker $USER

echo "✅ Instalación completada. Por favor, cierra sesión y vuelve a iniciarla para aplicar los cambios de grupo."
