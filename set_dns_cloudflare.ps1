$dns4 = @("1.1.1.1","1.0.0.1")
$dns6 = @("2606:4700:4700::1111","2606:4700:4700::1001")
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    $name = $_.Name
    Write-Host "Configuration DNS pour l'interface $name..."
    Set-DnsClientServerAddress -InterfaceAlias $name -ServerAddresses $dns4 -AddressFamily IPv4 -ErrorAction SilentlyContinue
    Set-DnsClientServerAddress -InterfaceAlias $name -ServerAddresses $dns6 -AddressFamily IPv6 -ErrorAction SilentlyContinue
}
Write-Host "DNS Cloudflare appliqués à toutes les interfaces actives."
