@echo off
echo Activation du démarrage rapide...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
echo Le démarrage rapide est maintenant désactivé.

@echo off
echo Désactivation de l'amélioration de la précision du pointeur...
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
echo L'amélioration de la précision du pointeur est désactivée.

@REM @echo off
@REM echo Modification des serveurs DNS vers ceux de Cloudflare...
@REM netsh interface ip set dns "Nom_de_votre_connexion" static 1.1.1.1
@REM netsh interface ip add dns "Nom_de_votre_connexion" 1.0.0.1 index=2
@REM echo Serveurs DNS modifiés vers ceux de Cloudflare (1.1.1.1 et 1.0.0.1).

@REM @echo off
@REM echo Modification des serveurs DNS IPv6 vers ceux de Cloudflare...
@REM netsh interface ipv6 set dns "Nom_de_votre_connexion" static 2606:4700:4700::1111
@REM netsh interface ipv6 add dns "Nom_de_votre_connexion" 2606:4700:4700::1001 index=2
@REM echo Serveurs DNS IPv6 modifiés vers ceux de Cloudflare (2606:4700:4700::1111 et 2606:4700:4700::1001).
@REM pause

@echo off
echo Installation de Google Chrome via winget...
winget install Google.Chrome -e
echo Installation terminée.
pause