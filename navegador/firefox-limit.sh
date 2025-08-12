#!/bin/bash

# Nombre del slice temporal
SLICE_NAME="firefox-limited.slice"

# Crear un slice temporal con límite de CPU al 45%
echo -e "[Slice]\nCPUQuota=45%" >~/.config/systemd/user/$SLICE_NAME
systemctl --user daemon-reload

# Obtener los PIDs de las sesiones activas de Firefox
PIDS=$(pgrep firefox)

# Comprobar si hay procesos de Firefox activos
if [ -z "$PIDS" ]; then
  notify-send -t 5000 "Error" "No se encontraron sesiones activas de Firefox"
  exit 1
fi

# Mover cada PID al slice
for PID in $PIDS; do
  systemctl --user set-property --runtime $SLICE_NAME PID=$PID
done

# Verificar si los procesos están en el slice con el límite aplicado
sleep 1
CHECK=$(systemctl --user status $SLICE_NAME | grep "CPUQuota=45%" 2>&1)

if [ -n "$CHECK" ]; then
  notify-send -t 5000 "Limitación aplicada" "Se ha aplicado correctamente el límite de CPU al 45% para la sesión activa de Firefox"
else
  notify-send -t 5000 "Error" "No se pudo aplicar el límite de CPU a la sesión activa de Firefox"
  exit 1
fi

exit 0
