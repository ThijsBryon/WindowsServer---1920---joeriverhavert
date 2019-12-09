Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#installatie van choclatey
Write-Host("Chocolatey wordt gëinstalleerd. Even geduldt aub.");
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
choco feature enable -n allowGlobalConfirmation;

#installatie SQLServer
Write-Host("SQLServer  wordt momenteel gëinstalleerd, even geduldt aub.");
choco install sql-server-management-studio
choco install sql-server-express
choco install webdeploy;
choco update sql-server-management-studio
choco update sql-server-express
choco update webdeploy;

Start-Sleep -s 30

#Restarting
Write-Host("Server wordt herstart.")
Restart-computer
