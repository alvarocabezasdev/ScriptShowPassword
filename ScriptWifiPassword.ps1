$wifiProfiles = netsh wlan show profiles | Select-String -Pattern "All User Profile" | ForEach-Object {
    $_.ToString().Split(":")[1].Trim()
}

Write-Host $wifiProfiles