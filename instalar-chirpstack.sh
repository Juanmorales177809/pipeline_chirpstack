#!/bin/bash

set -e

echo "🔧 Instalando Git..."
sudo apt update
sudo apt install -y git

REPO_DIR="chirpstack-LSCR"

if [ -d "$REPO_DIR" ]; then
    echo "📁 El repositorio '$REPO_DIR' ya existe. Usando el existente..."
    cd "$REPO_DIR"
else
    echo "📁 Clonando el repositorio de ChirpStack..."
    git clone https://github.com/Juanmorales177809/chirpstack-LSCR.git
    cd "$REPO_DIR"
fi

echo "🐳 Iniciando los contenedores de ChirpStack con Docker Compose..."
sudo docker compose up -d

echo "📦 Contenedores actualmente activos:"
sudo docker ps -a

echo "✅ ChirpStack ha sido desplegado exitosamente."

