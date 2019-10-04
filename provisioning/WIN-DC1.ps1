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

#naamgeving netwerkadapters aanpassen.
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,WAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "WAN";
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";

#Installeren van  AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#installeren en configuren van DHCP.
Write-host("DHCP feature wordt geinstalleerd.");
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools;

#Configureren van DNS
#Write-host("Configuren van DNS settings.");
#Set-DnsClientServerAddress -InterfaceAlias 'WAN' -ServerAddresses 10.6.0.2

#promoten server naar domeincontroller in nieuwe forest.
Write-host("Server wordt gepromoveerd naar domaincontroller in een nieuwe forest.");
Install-ADDSForest -DomainName "joeri.periode1" -InstallDns -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Joeri1311!" -Force) -Force -Verbose;

#Systeem herstarten
Write-host("Installatie is compleet,het systeem zal eerst herstart worden.")


