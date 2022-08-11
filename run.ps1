function InstallChocolatey() {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function InstallPrograms()
{
    InstallChocolatey
    choco feature enable -n allowGlobalConfirmation
    choco install 7zip.install
    choco install bitwarden
    choco install calibre
    choco install f.lux
    choco install firefox
    choco install git
    choco install googlechrome
    choco install obsidian
    choco install nodejs.install
    choco install notepadplusplus
    choco install qbittorrent
    choco install sharex
    choco install spotify
    choco install steam
    choco install telegram.install
    choco install vscode
}

function RemoveBloatware()
{
    Get-AppxPackage *windowsalarms* | Remove-AppxPackage
    Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
    Get-AppxPackage *windowscamera* | Remove-AppxPackage
    Get-AppxPackage *zunemusic* | Remove-AppxPackage
    Get-AppxPackage *windowsmaps* | Remove-AppxPackage
    Get-AppxPackage *photos* | Remove-AppxPackage
    Get-AppxPackage *bingsports* | Remove-AppxPackage
    Get-AppxPackage *soundrecorder* | Remove-AppxPackage
    Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
    Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage
    Get-AppxPackage XboxApp | Remove-AppxPackage
    Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
}

function SetDarkMode()
{
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
}

function ShowFileExtensions() 
{
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . HideFileExt "0"
    Pop-Location
}

function ShowHiddenFilesAndFolders()
{
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . Hidden "1"
    Pop-Location
}

function RestartExplorer()
{
    Stop-Process -processName: Explorer -force # This will restart the Explorer service to apply the settings.
}

function ChangeSettings() 
{
    SetDarkMode
    ShowFileExtensions
    ShowHiddenFilesAndFolders
    RestartExplorer
}

InstallPrograms
RemoveBloatware
ChangeSettings