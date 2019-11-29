Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Aanmaken nieuwe folder + changing dir
New-Item -ItemType directory -Path C:\SoftwarePackages
Set-Location -Path "C:\SoftwarePackages\"

Invoke-WebRequest "https://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe" -OutFile ucma.exe
Invoke-WebRequest "https://download.visualstudio.microsoft.com/download/pr/c76aa823-bbc7-4b21-9e29-ab24ceb14b2d/9de2e14be600ef7d5067c09ab8af5063/dotnet-sdk-2.2.401-win-x64.exe" -OutFile dotnet.exe
Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=2088631" -OutFile dotnet48.exe
Invoke-WebRequest "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe" -OutFile vcredist_x64.exe

Install-WindowsFeature RSAT-ADDS
Install-WindowsFeature NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-Mgmt, RSAT-ADDS, RSAT-Clustering-PowerShell, Web-Mgmt-Console, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation

#Installs
.\dotnet.exe /passive /norestart
.\dotnet48.exe /passive /norestart
Start-Sleep -s 540
.\ucma.exe -q
.\vcredist_x64.exe /passive /norestart
