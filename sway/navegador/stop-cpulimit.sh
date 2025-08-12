#!/bin/bash

# Detener limitcpu para librewolf
pkill limitcpu

# Dar un pequeño retraso para asegurar que el comando se ejecute
sleep 1

# Verificar si limitcpu sigue corriendo para librewolf
output=$(ps aux | grep '[l]imitcpu.*librewolf' 2>&1)

# Comprobar si el proceso limitcpu ya no está activo
if [ -z "$output" ]; then
    # Mostrar notificación durante 5 segundos
    notify-send -t 5000 "Limitación eliminada" "Se ha detenido correctamente limitcpu para LibreWolf"
else
    # Mostrar notificación de error
    notify-send -t 5000 "Error" "No se pudo detener limitcpu para LibreWolf"
    exit 1
fi

exit 0
