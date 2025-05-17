#!/bin/bash

echo "🔻 Buscando proceso de Glances..."
PID=$(ps aux | grep '[g]lances -w' | awk '{print $2}')

if [ -z "$PID" ]; then
    echo "⚠️  No se encontró ningún proceso Glances en modo web ejecutándose."
else
    echo "🛑 Deteniendo Glances (PID: $PID)..."
    kill "$PID"
    echo "✅ Glances detenido."
fi
