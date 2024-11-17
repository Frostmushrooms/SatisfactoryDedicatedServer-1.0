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
echo Please do not close this window
echo QQ:1056484009 QQgroup:264127585

taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe >nul 2>nul

setlocal

set PORT=7777

mkdir "%~dp0logs" >nul 2>nul

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%

set log_file=%~dp0logs\%date:~0,4%%date:~5,2%%date:~8,2%_%hour%%time:~3,2%%time:~6,2%.log
echo %date:~0,11%%time% Satisfactory Server Daemon Started >> %log_file%
echo %date:~0,11%%time% Satisfactory Server Daemon Started

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
    taskkill /f /t /im FactoryServer-Win64-Shipping-Cmd.exe >nul
    echo %date:~0,11%%time% Satisfactory Server Error, restarting >> %log_file%
    echo %date:~0,11%%time% Satisfactory Server Error, restarting
    powershell -Command "& { [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $xml = New-Object Windows.Data.Xml.Dom.XmlDocument; $xml.LoadXml($template.GetXml()); $toastElements = $xml.GetElementsByTagName('text'); if ($toastElements.Count -ge 2) { $titleNode = $xml.CreateTextNode('Satisfactory Server Error'); $toastElements.Item(0).AppendChild($titleNode) > $null; $contentNode = $xml.CreateTextNode('Detected UDP port %port% closed, restarting server.'); $toastElements.Item(1).AppendChild($contentNode) > $null; $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Satisfactory Dedicated Server'); $notifier.Show($toast); } else { Write-Host 'Unable to create toast notification.' } }" >nul 2>nul
    explorer "%~dp0demotion.bat"
)

echo %date:~0,11%%time% SatisfactoryDedicatedServer is working.
echo %date:~0,11%%time% SatisfactoryDedicatedServer is working.>> %log_file%
timeout /T 30 >nul
goto check_port
