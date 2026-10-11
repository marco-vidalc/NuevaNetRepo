#!/bin/bash

LOG_DIR="/var/log/nuevanet"
HISTORIAL_LOG="/var/log/nuevanet/ejecucion_rutinas.log"

registrar_evento() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$HISTORIAL_LOG"
}

if [ "$EUID" -ne 0 ]; then
  echo "Error: Debe ejecutar este script como superusuario (sudo)." >&2
  exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
fi

registrar_evento "Iniciando compresión de logs antiguos..."
find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; 2>/dev/null
registrar_evento "Rutina finalizada con éxito."
