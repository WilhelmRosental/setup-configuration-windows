$profilePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}
$content = Get-Content $profilePath -Raw
$omp = 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\dracula.omp.json" | Invoke-Expression'
$icons = 'Import-Module Terminal-Icons'
if ($content -notmatch [regex]::Escape($omp)) {
    Add-Content $profilePath "`n$omp"
}
if ($content -notmatch [regex]::Escape($icons)) {
    Add-Content $profilePath "`n$icons"
}
Write-Host "Profil PowerShell configuré pour Oh My Posh et Terminal-Icons."
