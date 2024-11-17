@echo off
setlocal enabledelayedexpansion
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
color AF
echo You are starting the SatisfactoryDedicatedServer in daemon mode
echo Please do not close this window
echo QQ:1056484009 QQgroup:264127585

taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe >nul 2>nul
explorer "%~dp0demotion.bat"


set PORT=7777

mkdir "%~dp0logs" >nul 2>nul

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%

set log_file=%~dp0logs\%date:~0,4%%date:~5,2%%date:~8,2%_%hour%%time:~3,2%%time:~6,2%.log
echo %date:~0,11%%time% Satisfactory Server Daemon Started >> %log_file%
echo %date:~0,11%%time% Satisfactory Server Daemon Started
set tempFile="%~dp0netstat.tmp"

:check_port
timeout /T 30 >nul

set processLine=0
set found=0

echo [netstat UDP] %date:~0,11%%time%> "%tempFile%"
netstat -a -b -n -o -p UDP >> "%tempFile%"

for /f "usebackq tokens=*" %%i in (%tempFile%) do (
    echo %%i | findstr /i "FactoryServer-Win64-Shipping-Cmd.exe" >nul
    if !errorlevel! equ 0 (
        set processLine=1
    ) else (
        if !processLine! equ 1 (
            echo %%i | findstr /i "0.0.0.0:%PORT%" >nul
            if !errorlevel! equ 0 (
                set found=1
                goto :break
            )
        )
        set processLine=0
    )
)

:break
if !found! == 0 (
    taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe >nul
    echo %date:~0,11%%time% Satisfactory Server Error, restarting >> %log_file%
    echo %date:~0,11%%time% Satisfactory Server Error, restarting
    powershell -Command "& { [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $xml = New-Object Windows.Data.Xml.Dom.XmlDocument; $xml.LoadXml($template.GetXml()); $toastElements = $xml.GetElementsByTagName('text'); if ($toastElements.Count -ge 2) { $titleNode = $xml.CreateTextNode('Satisfactory Server Error'); $toastElements.Item(0).AppendChild($titleNode) > $null; $contentNode = $xml.CreateTextNode('Detected UDP port %port% closed, restarting server.'); $toastElements.Item(1).AppendChild($contentNode) > $null; $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Satisfactory Dedicated Server'); $notifier.Show($toast); } else { Write-Host 'Unable to create toast notification.' } }" >nul 2>nul
    timeout /T 5 >nul
    explorer "%~dp0demotion.bat"
) else (
    echo %date:~0,11%%time% Satisfactory Server is working.
    echo %date:~0,11%%time% Satisfactory Server is working.>> %log_file%
)
goto check_port

pause