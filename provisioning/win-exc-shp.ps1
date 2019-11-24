Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#instellen van toetsenbord,regio en taal.
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";

#Ip address toewijzen
Write-host("Ip address wordt toegewezen.")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.40 -PrefixLength 24 -DefaultGateway 192.168.100.10

Write-host("Dns adres wordt ingesteld")
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10
#Write-host("Nat interface wordt gedisabled.")
Disable-NetAdapter -Name "Ethernet" -Confirm:$false;
