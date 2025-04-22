@echo off
REM ============================
REM Vérification des privilèges administrateur
REM ============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Ce script doit etre execute en tant qu'administrateur.
    pause
    exit /b
)

REM ============================
REM Vérification de la version de Windows (11 ou plus)
REM ============================
ver | findstr /i "10.0.22" >nul && (
    echo Windows 11 ou version plus recente detectee.
) || (
    echo Ce script est concu pour Windows 11 ou une version plus recente.
    pause
    exit /b
)

REM ============================
REM Désactivation du démarrage rapide
REM ============================
echo.
echo [1/7] Désactivation du démarrage rapide...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel%==0 (
    echo Le démarrage rapide est maintenant désactivé.
) else (
    echo Erreur lors de la désactivation du démarrage rapide.
)

REM ============================
REM Désactivation de la veille, veille prolongée et veille hybride
REM ============================
echo [2/7] Désactivation de la veille, veille prolongée et veille hybride...
powercfg /hibernate off
if %errorlevel%==0 (
    echo Veille prolongée désactivée.
) else (
    echo Erreur lors de la désactivation de la veille prolongée.
)
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0
powercfg /setactive SCHEME_CURRENT
echo Veille, veille prolongée et veille hybride désactivées.

REM ============================
REM Désactivation de l'amélioration de la précision du pointeur (accélération souris)
REM ============================
echo [3/7] Désactivation de l'amélioration de la précision du pointeur...
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
if %errorlevel%==0 (
    echo MouseSpeed désactivé.
) else (
    echo Erreur lors de la désactivation de MouseSpeed.
)
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
if %errorlevel%==0 (
    echo MouseThreshold1 désactivé.
) else (
    echo Erreur lors de la désactivation de MouseThreshold1.
)
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
if %errorlevel%==0 (
    echo MouseThreshold2 désactivé.
) else (
    echo Erreur lors de la désactivation de MouseThreshold2.
)
REM Désactivation de l'amélioration du pointeur (affichage)
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseEnhancePointer /t REG_SZ /d 0 /f
if %errorlevel%==0 (
    echo MouseEnhancePointer désactivé.
) else (
    echo Erreur lors de la désactivation de MouseEnhancePointer.
)
echo L'amélioration de la précision du pointeur est désactivée.

REM ============================
REM Configuration DNS Cloudflare sur toutes les interfaces actives
REM ============================
echo [4/7] Configuration des serveurs DNS Cloudflare...
powershell -ExecutionPolicy Bypass -File "%~dp0\set_dns_cloudflare.ps1"
if %errorlevel%==0 (
    echo DNS Cloudflare configures.
) else (
    echo Erreur lors de la configuration DNS.
)

REM ============================
REM Installation de Oh My Posh via winget
REM ============================
echo [5/7] Installation de Oh My Posh via winget...
where winget >nul 2>&1
if %errorlevel%==0 (
    winget install JanDeDobbeleer.OhMyPosh -e --accept-package-agreements --accept-source-agreements
    echo Installation terminee.
) else (
    echo winget n'est pas disponible sur ce systeme.
)

REM ============================
REM Installation des icônes du terminal et configuration du profil PowerShell
REM ============================
echo [6/7] Installation de Terminal-Icons et configuration du profil PowerShell...
powershell -ExecutionPolicy Bypass -File "%~dp0\install_terminal_icons.ps1"

REM ============================
REM Configuration du profil PowerShell pour Oh My Posh et Terminal-Icons
REM ============================
echo [7/7] Configuration du profil PowerShell...
powershell -ExecutionPolicy Bypass -File "%~dp0\set_powershell_profile.ps1"

echo.
echo Configuration terminee ! Redemarrez votre terminal pour appliquer les changements.
pause