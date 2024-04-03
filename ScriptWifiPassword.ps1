# Listar todos los perfiles de red Wi-Fi
$profiles = netsh wlan show profiles | Select-String -Pattern "All User Profile" | ForEach-Object {
    $_ -replace "^.*:\s*", ""
}

foreach ($profile in $profiles) {
    # Mostrar el nombre del perfil
    Write-Output "Nombre de la red (SSID): $profile"
    
    # Intentar mostrar la contraseña del perfil. Si no está disponible, captura el error y muestra un mensaje.
    try {
        $key = (netsh wlan show profile name="$profile" key=clear | Select-String -Pattern "Key Content" | ForEach-Object {
            $_ -replace "^.*:\s*", ""
        })
        if ($key -eq $null) {
            Write-Output "Contraseña: No disponible o red abierta"
        } else {
            Write-Output "Contraseña: $key"
        }
    } catch {
        Write-Output "No se pudo obtener la información de la contraseña para $profile"
    }
    
    # Espaciado entre perfiles
    Write-Output ""
}
