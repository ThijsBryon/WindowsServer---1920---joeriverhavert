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

#install AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#Server wordt gepromoveerd naar domaincontroller in een bestaande forest.
Install-ADDSDomainController -CreateDnsDelegation:$false -DatabasePath 'C:\Windows\NTDS' -DomainName 'joeri.periode1' 
	-InstallDns:$false -LogPath 'C:\Windows\NTDS' -NoGlobalCatalog:$false -SiteName 'joeri.periode1' -SysvolPath 'C:\Windows\SYSVOL' -NoRebootOnCompletion -Force

#Controleren updates
Write-host("Controleren op updates..Even geduld aub.")
Install-Module PSWindowsUpdate;
Get-WindowsUpdate;
Install-WindowsUpdate;

#Systeem herstarten
Write-host("Het systeem zal herstart worden.")
Restart-Computer -Force
