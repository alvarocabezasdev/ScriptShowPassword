$wifiProfiles = netsh wlan show profiles | ForEach-Object {
    $_.ToString().Split(":")[1].Trim()
}

Write-Host $wifiProfiles