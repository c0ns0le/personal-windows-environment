cd [Environment]::GetFolderPath("Desktop")
New-Item -ItemType Directory -Force -Path Downloads
cd Downloads
Write-Host Downloading script...
wget https://raw.githubusercontent.com/oledid/personal-windows-environment/master/run-as-elevated.ps1 -OutFile "script.ps1"
powershell -verb runas ./script.ps1
