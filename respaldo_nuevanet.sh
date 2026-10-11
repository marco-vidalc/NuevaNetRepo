#!/bin/bash

ORIGEN="/var/www/nuevanet/data"
DESTINO="/var/backups/nuevanet"
FECHA=$(date +%Y%m%d_%H%M%S)
NOMBRE_RESPALDO="backup_nuevanet_$FECHA.tar.gz"

mkdir -p "$DESTINO"
mkdir -p "$ORIGEN"

tar -czf "$DESTINO/$NOMBRE_RESPALDO" "$ORIGEN" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Respaldo exitoso: $NOMBRE_RESPALDO" >> /var/log/nuevanet/respaldos.log
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error al crear respaldo." >> /var/log/nuevanet/respaldos_error.log
fi

find "$DESTINO" -name "backup_nuevanet_*.tar.gz" -mtime +30 -exec rm {} \;
