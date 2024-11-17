@echo off

:: BatchGotAdmin
title checking for admin rights
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
title waiting for admin rights
mode con cols=20 lines=1
goto UACPrompt
) else ( goto start )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:start

title FactoryServerDaemon
echo You are starting the SatisfactoryDedicatedServer in daemon mode

echo QQ:1056484009 QQgroup:264127585

taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe >nul

setlocal

set PORT=7777

:check_port
set found=0
for /f "tokens=*" %%i in ('netstat -a -b -n -o -p UDP ^| findstr "FactoryServer-Win64-Shipping-Cmd.exe"') do (
    set "line=%%i"
    for /f "tokens=2,3" %%a in ("!line!") do (
        if %%b==0.0.0.0:%port% (
            set found=1
            goto :break
        )
    )
)

:break
if !found! == 0 (
    echo %date:~0,11%%time% Satisfactory Server Error
    taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe
    explorer "%~dp0demotion.bat"
)

echo %date:~0,11%%time% SatisfactoryDedicatedServer is working.
timeout /T 30 >nul
goto check_port
