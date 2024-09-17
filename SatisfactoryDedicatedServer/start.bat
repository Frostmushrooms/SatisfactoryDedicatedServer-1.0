@echo off
echo You are starting the SatisfactoryDedicatedServer in daemon mode

taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe

setlocal
 
set PORT=7777
 
:check_port
set "found="
for /F "tokens=2 delims=:" %%a in ('netstat -a -n -o -p UDP ^| findstr :%PORT%') do set "found=%%a"
if not defined found (
    echo %date%%time% SatisfactoryDedicatedServer is offline. Restarting the server, please be patient
taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe & start C:\SatisfactoryDedicatedServer\GameServers\SatisfactoryServer\FactoryServer.exe -log -unattended -port=7777
)
 
echo %date%%time% SatisfactoryDe​​dicatedServer is working.  QQ:1056484009 QQgroup:264127585 
timeout /T 30 >nul
goto check_port
