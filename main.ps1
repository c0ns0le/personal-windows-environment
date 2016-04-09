$desktopPath = [Environment]::GetFolderPath('Desktop')
Set-Location $desktopPath
New-Item -ItemType Directory -Force -Path Downloads
Set-Location Downloads
Write-Host Downloading script...
Invoke-WebRequest https://raw.githubusercontent.com/oledid/personal-windows-environment/master/run-as-elevated.ps1 -OutFile script.ps1
Write-Host Running script as administrator...
$scriptPath = Join-Path $pwd script.ps1
Start-Process powershell -verb runas $scriptPath