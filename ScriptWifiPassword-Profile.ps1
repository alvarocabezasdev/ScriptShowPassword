# Guardar la salida del comando 'netsh wlan show profiles' en una variable
$wifiProfilesRaw = netsh wlan show profiles

# Procesar la salida para obtener solo los nombres de los perfiles
$wifiProfilesList = $wifiProfilesRaw -split "`r`n" | Where-Object { $_ -match 'Perfil de todos los usuarios\s*:\s*(.+)' } | ForEach-Object {
    $matches[1].Trim()
}

# Iterar sobre la lista de perfiles Wi-Fi
foreach ($profileName in $wifiProfilesList) {
    # Construir el comando para mostrar detalles del perfil, incluida la clave en claro
    $command = "netsh wlan show profile name=`"$profileName`" key=clear"
    
    # Ejecutar el comando
    Invoke-Expression $command
    
    # Opcional: agregar una separación entre los perfiles para mejorar la legibilidad
    Write-Output "======================================================"
}
