#!/bin/bash

# Aplicar limitación de CPU a LibreWolf
limitcpu --exe librewolf --limit 45 -b &

# Dar un pequeño retraso para asegurar que el comando se ejecute
sleep 1

# Verificar si limitcpu está corriendo para librewolf
output=$(ps aux | grep '[l]imitcpu.*librewolf' 2>&1)

# Comprobar si el proceso limitcpu está activo para librewolf
if [ -n "$output" ]; then
    # Mostrar notificación durante 5 segundos
    notify-send -t 5000 "Limitación aplicada" "Se ha aplicado correctamente el límite de CPU al 45% para LibreWolf"
else
    # Mostrar notificación de error
    notify-send -t 5000 "Error" "No se pudo aplicar el límite de CPU a LibreWolf"
    exit 1
fi

exit 0
