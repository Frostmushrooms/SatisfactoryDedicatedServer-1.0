@echo off
echo You are starting the SatisfactoryDedicatedServer in daemon mode 
echo 您正在启动幸福工厂服务器 守护模式

taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe

setlocal
 
set PORT=7777
 
:check_port
set "found="
for /F "tokens=2 delims=:" %%a in ('netstat -a -n -o -p UDP ^| findstr :%PORT%') do set "found=%%a"
if not defined found (
    echo %date%%time% 幸福工厂服务器已离线. 正在重新启动服务器 请耐心等待
    echo %date%%time% The SatisfactoryDedicatedServer is offline. The server is restarting. Please wait patiently.
taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe & start C:\SatisfactoryDedicatedServer\GameServers\SatisfactoryServer\FactoryServer.exe -log -unattended -port=7777
)
 
echo %date%%time% SatisfactoryDedicatedServer is working 
echo %date%%time%  幸福工厂服务器正在工作. 冰霜蘑菇 QQ:1056484009 QQ群:264127585
timeout /T 30 >nul
goto check_port
