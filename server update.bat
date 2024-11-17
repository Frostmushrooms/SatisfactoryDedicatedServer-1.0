@echo off
mkdir "%~dp0steamcmd" >nul 2>nul
CD "%~dp0steamcmd"
curl -o "steamcmd.zip" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
tar -xf steamcmd.zip
CD ..

taskkill /IM FactoryServer-Win64-Shipping-Cmd.exe /F >nul 2>nul

"%~dp0steamcmd/steamcmd.exe" +force_install_dir "%~dp0ServerCore" +login anonymous +app_update 1690800 -beta public validate +quit

rmdir "%~dp0steamcmd" /s /q

set filesize=0
for /f "delims=" %%s in (
    'powershell -command "(Get-ChildItem -Path \"%~dp0ServerCore\" -Recurse -File -Force | Measure-Object -Property Length -Sum).Sum / 1GB"'
) do set filesizeGB=%%s

powershell -Command "& { [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $xml = New-Object Windows.Data.Xml.Dom.XmlDocument; $xml.LoadXml($template.GetXml()); $toastElements = $xml.GetElementsByTagName('text'); if ($toastElements.Count -ge 2) { $titleNode = $xml.CreateTextNode('Satisfactory Server Downloaded'); $toastElements.Item(0).AppendChild($titleNode) > $null; $contentNode = $xml.CreateTextNode('Server File size: %filesizeGB% GB'); $toastElements.Item(1).AppendChild($contentNode) > $null; $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Satisfactory Server Manager'); $notifier.Show($toast); } else { Write-Host 'Unable to create toast notification.' } }" >nul 2>nul