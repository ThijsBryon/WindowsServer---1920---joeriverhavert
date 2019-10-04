Clear-Host;

#instellen van toetsenbord,regio en taal.
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

#naamgeving netwerkadapters aanpassen.
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";

#Computer toevoegen aan het domain
Write-host("Computer toevoegen aan het domain");
Add-Computer –DomainName mylab.local –Credential (Get-Credential)

#Controleren updates
Write-host("Controleren op updates..Even geduld aub.")
Install-Module PSWindowsUpdate;
Get-WindowsUpdate;
Install-WindowsUpdate;

#Systeem herstarten
Write-host("Het systeem zal herstart worden.")
Restart-Computer -Force
