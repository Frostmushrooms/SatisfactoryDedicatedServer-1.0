if not exist "%~dp0steamcmd" (
    mkdir "%~dp0steamcmd"
		CD "%~dp0steamcmd"
	powershell curl -o "steamcmd.zip" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
    tar -xf steamcmd.zip
)
taskkill /IM FactoryServer-Win64-Shipping-Cmd.exe /F
"%~dp0steamcmd/steamcmd.exe" +force_install_dir "%~dp0SatisfactoryServer" +login anonymous +app_update 1690800 -beta public validate +quit
