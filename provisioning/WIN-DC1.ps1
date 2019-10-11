Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Controleren updates
Clear-host;
Write-host("Controleren op updates..Even geduld aub.")
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate

#instellen van toetsenbord,regio en taal.
Clear-host;
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

#naamgeving netwerkadapters aanpassen.
Clear-host;
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,WAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "WAN";
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";

#Ip address toewijzen
Clear-host;
Write-host("Ip address wordt toegewezen.")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.10 -PrefixLength 24

#Installeren van  AD DS.
Clear-host;
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#installeren en configuren van DHCP.
Clear-host;
Write-host("DHCP feature wordt geinstalleerd.");
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools;

#promoten server naar domeincontroller in nieuwe forest.
Clear-host;
Write-host("Server wordt gepromoveerd naar domaincontroller in een nieuwe forest.");
#Install-ADDSForest -DomainName "joeri.periode1" -InstallDns -DomainNetbiosName "JOERI" -NoRebootOnCompletion -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "" -Force ) -Force
Install-ADDSForest `
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "7" `
 -DomainName "joeri.periode1" `
 -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText -String "Joeri1311!" -Force) `
 -DomainNetbiosName "JOERI" `
 -ForestMode "7" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true

