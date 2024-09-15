@echo off
echo start server
taskkill /IM FactoryServer-Win64-Shipping-Cmd.exe /F
setlocal
 
set PORT=7777
set APP_PATH=C:\SatisfactoryDedicatedServer\start.bat
 
:check_port
set "found="
for /F "tokens=2 delims=:" %%a in ('netstat -a -n -o -p UDP ^| findstr :%PORT%') do set "found=%%a"
if not defined found (
    echo Port %PORT% is not in use. Opening %APP_PATH%
    start C:\SatisfactoryDedicatedServer\GameServers\SatisfactoryServer\FactoryServer.exe -log -unattended
)
 
echo Port %PORT% is in use.
timeout /T 30 >nul
goto check_port
