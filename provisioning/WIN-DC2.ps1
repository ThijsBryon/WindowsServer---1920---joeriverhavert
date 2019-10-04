Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Controleren updates
Write-host("Controleren op updates..Even geduld aub.")
Install-Module PSWindowsUpdate;
Get-WindowsUpdate;
Install-WindowsUpdate;

#instellen van toetsenbord,regio en taal.
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

#aanpassen van ethernet adapter
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";
Write-host("Ip,subnet,default gateway, DNS van LAN adapter wordt aangepast. ")
New-NetIPAddress –IPAddress 192.168.100.20 -DefaultGateway 192.168.100.10 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex;
Set-DNSClientServerAddress -–ServerAddresses 192.168.100.10;

#install AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#Server wordt gepromoveerd naar domaincontroller in een bestaande forest.
Install-ADDSDomainController  -DomainName 'joeri.periode1' -SiteName 'joeri.periode1' -NoRebootOnCompletion -Force


#Systeem herstarten
Write-host("Het systeem zal herstart worden.")
Restart-Computer -Force
