#!/bin/bash

echo "🔧 Instalando dependencias para Glances..."
sudo apt update
sudo apt install -y python3-pip python3-venv lm-sensors

echo "📁 Creando entorno virtual..."
python3 -m venv ~/glances-venv

echo "📦 Activando entorno e instalando Glances, FastAPI y Uvicorn..."
source ~/glances-venv/bin/activate
pip install --upgrade pip
pip install glances fastapi uvicorn jinja2

echo "📝 Creando servicio systemd para Glances..."
SERVICE_FILE="/etc/systemd/system/glances-web.service"

sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Glances en modo web
After=network.target

[Service]
ExecStart=/home/chirpstack/glances-venv/bin/glances -w
WorkingDirectory=/home/chirpstack
User=chirpstack
Restart=always
RestartSec=5
Environment="PATH=/home/chirpstack/glances-venv/bin"

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Habilitando e iniciando servicio..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable glances-web.service
sudo systemctl start glances-web.service

echo "✅ Servicio Glances iniciado. Puedes verificarlo con:"
echo "   sudo systemctl status glances-web.service"
echo "🌐 Accede desde tu navegador en: http://$(hostname -I | awk '{print $1}'):61208"
