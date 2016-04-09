Import-Module PackageManagement

# run as admin:
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# ignore errors
$ErrorActionPreference = "Continue"

# turn developer mode on
cd C:\WINDOWS\system32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# set folder options to sane values
# (show hidden files, show file extensions)
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Stop-Process -processname explorer # starts automatically

# Remove preinstalled Windows Store apps (except windows store itself):
Get-AppxPackage -AllUsers | where-object {$_.name –NotLike "*windowsstore*"} | Remove-AppxPackage
Get-AppxProvisionedPackage –Online | where-object {$_.packagename –NotLike "*windowsstore*"} | Remove-AppxProvisionedPackage -Online

# install chocolatey packages
$chocolateyPackages = @(
    "GoogleChrome",
    "VLC",
    "SublimeText3",
    "Atom",
    "VisualStudioCode",
    "VisualStudio2015Community",
    "audacity",
    "musescore",
    "Pencil",
    "InkScape",
    "autohotkey",
    "avidemux",
    "blender",
    "youtube-dl",
    "steam",
    "ConEmu",
    "Cmder",
    "openvpn",
    "nodejs",
    "python2",
    "python3",
    "spotify"
)
foreach ($packageName in $chocolateyPackages) {
    Write-Host Installing $packageName ...
    Install-Package -provider chocolatey $packageName -Force
    Write-Host Installed $packageName
}

# download stuff to install manually:
$desktopPath = [Environment]::GetFolderPath("Desktop")
cd $desktopPath
New-Item -ItemType Directory -Force -Path Downloads
cd Downloads
Write-Host Downloading stuff to install manually...
wget https://www.sparklabs.com/downloads/Viscosity%20Installer.exe -OutFile "Viscosity Installer.exe"

Write-Host All done.
