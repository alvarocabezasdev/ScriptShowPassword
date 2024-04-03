$profilesOutput = Invoke-Expression "netsh wlan show profiles"

# Filtrar y extraer solo los nombres de los perfiles
$profiles = $profilesOutput -split "`n" | Where-Object { $_ -match "Todos los perfiles de usuario\s+:\s+(.+)" }

foreach ($profile in $profiles) {
    # Extraer el nombre del perfil utilizando la captura de grupo en -match
    if ($profile -match "Todos los perfiles de usuario\s+:\s+(.+)") {
        $profileName = $matches[1]
        
        Write-Output "Procesando perfil: $profileName"
        
        # Utilizar correctamente las comillas para envolver el nombre del perfil en el comando
        $profileDetailsCmd = "netsh wlan show profile name=`"$profileName`" key=clear"
        $profileDetails = Invoke-Expression $profileDetailsCmd
        
        Write-Output $profileDetails
    }
}
