$desktopPath = [Environment]::GetFolderPath('Desktop')
cd $desktopPath
New-Item -ItemType Directory -Force -Path Downloads
cd Downloads
Write-Host Downloading script...
Invoke-WebRequest https://raw.githubusercontent.com/oledid/personal-windows-environment/master/run-as-elevated.ps1 -OutFile script.ps1
Start-Process powershell -verb runas ./script.ps1
