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

Write-host("Dns adres wordt ingesteld")
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10
#Write-host("Nat interface wordt gedisabled.")
Disable-NetAdapter -Name "Ethernet" -Confirm:$false;

#server toevoegen aan domain
Write-Host("Server wordt gevoegd aan het joeri.periode1 domain.")
Add-Computer -DomainName "joeri.periode1" -Credential (Get-Credential JOERI\Administrator)

Write-Host("Server wordt hernoemd naar WIN-SQL-SCCM")
Rename-Computer -NewName "WIN-SQL-SCCM"
Start-Sleep -s 30

#Restarting
Write-Host("Server wordt herstart.")
Restart-computer
