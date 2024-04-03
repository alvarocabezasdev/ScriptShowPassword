# Guardar la salida del comando 'netsh wlan show network' en una variable
$wifiNetworksRaw = netsh wlan show network mode=bssid

# Procesar la salida para obtener solo los nombres de las redes
$wifiNetworksList = $wifiNetworksRaw -split "`r`n" | Where-Object { $_ -match 'SSID \d+ : (.+)' } | ForEach-Object {
    $matches[1].Trim()
}

# Aquí comienza la modificación para iterar sobre las redes visibles
# Sin embargo, el comando 'netsh wlan show network' no se usa con 'name=' para mostrar detalles específicos como 'netsh wlan show profile'
# Por lo tanto, este bucle simplemente mostrará el nombre de cada red visible en lugar de intentar mostrar detalles adicionales
foreach ($networkName in $wifiNetworksList) {
    # Mostrar el nombre de la red
    Write-Output "Network Name: $networkName"
    
    # Opcional: mostrar comando que se utilizaría si 'netsh wlan show network' aceptara un parámetro de nombre específico
    # Esto es solo ilustrativo y no funcionará para 'netsh wlan show network'
    $command = "netsh wlan show network name=`"$networkName`" key=clear"
    
    # Opcional: intentar ejecutar el comando - solo ilustrativo, este comando no es válido
    # Invoke-Expression $command
    
    # Agregar una separación entre las redes para mejorar la legibilidad
    Write-Output "======================================================"
}