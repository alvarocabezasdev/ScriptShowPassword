$wifiProfiles = netsh wlan show profiles | Select-String -Pattern "All User Profile" | ForEach-Object { $_ -replace "^.*:\s*", "" }

foreach ($profile in $wifiProfiles) {
    Write-Host "Nombre de la Red (SSID):" $profile
    $wifiDetails = netsh wlan show profile name="$profile" key=clear
    $wifiKey = ($wifiDetails | Select-String "Contenido de la clave").ToString().Split(":")[1].Trim()
    if ($wifiKey -ne $null) {
        Write-Host "Contraseña:" $wifiKey
    } else {
        Write-Host "Contraseña: No Disponible"
    }
    Write-Host "--------------------------------"
}
