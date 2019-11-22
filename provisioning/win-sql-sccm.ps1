Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#instellen van toetsenbord,regio en taal.
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

#aanpassen van ethernet adapters settings
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";
Write-host("Ip,subnet,default gateway, DNS van LAN adapter wordt aangepast. ")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.30 -PrefixLength 24 -DefaultGateway 192.168.100.10
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10
#Write-host("Nat interface wordt gedisabled.")
Disable-NetAdapter -Name "Ethernet" -Confirm:$false;

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
