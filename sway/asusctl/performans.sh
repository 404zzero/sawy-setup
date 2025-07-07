#!/bin/bash

# Cambiar al perfil de rendimiento
asusctl profile -P Performance

# Verificar el perfil activo
output=$(asusctl profile -p 2>&1)

# Comprobar si el perfil activo es Performance
if echo "$output" | grep -q "Active profile is Performance"; then
    # Mostrar notificación durante 5 segundos
    notify-send -t 5000 "Perfil cambiado" "Se ha cambiado correctamente al modo Performance"
else
    # Mostrar notificación de error
    notify-send -t 5000 "Error" "No se pudo cambiar al modo Performance"
    exit 1
fi

exit 0
