# Vérifie si le script est exécuté en tant qu'administrateur
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Veuillez exécuter ce script en tant qu'administrateur."
    exit 1
}

# Vérifie si le module Terminal-Icons est déjà installé
if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Write-Host "Le module Terminal-Icons est déjà installé."
} else {
    Write-Host "Installation du module Terminal-Icons depuis PSGallery..."
    Install-Module -Force -Name Terminal-Icons -Repository PSGallery
    Write-Host "Installation terminée."
}

# Ajoute l'import dans le profil PowerShell si absent
$profilePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}
$content = Get-Content $profilePath -Raw
if ($content -notmatch 'Import-Module Terminal-Icons') {
    Add-Content $profilePath "`nImport-Module Terminal-Icons"
    Write-Host "Import-Module Terminal-Icons ajouté au profil PowerShell."
} else {
    Write-Host "Import-Module Terminal-Icons déjà présent dans le profil PowerShell."
}