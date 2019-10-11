Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#instellen van toetsenbord 
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;

#installatie van choclatey
Clear-host;
Write-Host("Chocolatey wordt gëinstalleerd. Even geduldt aub.");
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
choco feature enable -n allowGlobalConfirmation;

#controleren op windows updates
Clear-Host;
Write-Host("Uw windowsmachine wordt gecontroleerd op update. Even geduldt aub.");
choco install pswindowsupdate;
Import-Module PSWindowsUpdate;
Get-WUInstall -WindowsUpdate ;
$kbID = Get-WUList -KBArticleID
Get-WUInstall -Type "Software" -KBArticleID $kbID -AcceptAll;

#installatie SQLServer
clear-host;
Write-Host("SQLServer  wordt momenteel gëinstalleerd, even geduldt aub.");
choco install sql-server-management-studio 
choco install sql-server-express 
choco install webdeploy;
choco update sql-server-management-studio 
choco update sql-server-express 
choco update webdeploy;

#installaties compleet
clear-host;
Write-Host("Installatie is voltooid!");