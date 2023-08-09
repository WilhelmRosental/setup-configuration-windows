@REM On désactive le démarrage rapide

@echo off
echo Désactivation du démarrage rapide...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
echo Le démarrage rapide est maintenant désactivé.

@REM On l'amélioration de la précision du pointeur (pour les jeux type fps)

@echo off
echo Désactivation de l'amélioration de la précision du pointeur...
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
echo L'amélioration de la précision du pointeur est désactivée.

@REM configuration du dns cloudflare

@echo off

set EthernetName="Ethernet"

echo Configuration des serveurs DNS Cloudflare en IPv4 et IPv6 pour %EthernetName%...
netsh interface ipv4 set dns name="%EthernetName%" static 1.1.1.1
netsh interface ipv4 add dns name="%EthernetName%" 1.0.0.1 index=2

netsh interface ipv6 set dns name="%EthernetName%" static 2606:4700:4700::1111
netsh interface ipv6 add dns name="%EthernetName%" 2606:4700:4700::1001 index=2

echo Serveurs DNS Cloudflare configurés en IPv4 et IPv6 pour %EthernetName%.

@REM configuration du dns cloudflare

@echo off

FOR /F "tokens=2 delims==" %%A in ('wmic cpu get NumberOfCores /value ^| findstr /r "[0-9]"') do set "MaxProcessors=%%A"

echo Le nombre maximal de processeurs est %MaxProcessors%.
pause

@REM @echo off

@REM bcdedit /set numproc 0
@REM bcdedit /set useplatformclock true

@REM echo Options avancées du démarrage modifiées pour utiliser le nombre maximum de processeurs.
@REM pause

@REM @echo off
@REM echo Installation de Google Chrome via winget...
@REM winget install Google.Chrome -e
@REM echo Installation terminée.
@REM pause

@echo off
echo Installation de Oh My Posh via winget...
winget install XP8K0HKJFRXGCK
echo Installation terminée.


@echo off
REM Détermination du chemin d'accès du dossier parent
set "ParentFolder=%~dp0"
REM Exécution du script PowerShell depuis le dossier parent
powershell -ExecutionPolicy Bypass -File "%ParentFolder%\script.ps1"
pause