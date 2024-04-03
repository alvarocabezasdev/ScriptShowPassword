$profilesOutput = Invoke-Expression "netsh wlan show profile"

$profiles = $profilesOutput -split "`n"
foreach ($profile in $profiles) {
    if (-not [string]::IsNullOrWhiteSpace($profile)) {
        $profileName = $profile -replace "Perfil\s+:\s+", ""
        
        Write-Output "Procesando perfil: $profileName"
        
        $profileDetails = Invoke-Expression "netsh wlan show profile name=\"$profileName\" key=clear" 

        Write-Output $profileDetails
        
    }
}
