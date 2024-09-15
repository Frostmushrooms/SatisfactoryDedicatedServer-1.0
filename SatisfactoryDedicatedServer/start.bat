@echo off
echo start server
taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe
C:
cd C:\SatisfactoryDedicatedServer\GameServers\SatisfactoryServer
start FactoryServer.exe -log -unattended

setlocal
 
set PORT=7777
set APP_PATH=C:\SatisfactoryDedicatedServer\启动代码.bat
 
:check_port
set "found="
for /F "tokens=2 delims=:" %%a in ('netstat -a -n -o -p UDP ^| findstr :%PORT%') do set "found=%%a"
if not defined found (
    echo Port %PORT% is not in use. Opening %APP_PATH%
    start "" "%APP_PATH%"
)
 
echo Port %PORT% is in use.
timeout /T 30 >nul
goto check_port
