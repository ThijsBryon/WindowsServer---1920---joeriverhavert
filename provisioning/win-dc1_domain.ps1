Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#instellen van toetsenbord,regio en taal.
Write-host("Het toetsenbord wordt in gesteld op AZERTY");
Set-WinUserLanguageList -LanguageList NL-BE -Force;
Write-host("De tijdzone wordt ingesteld op Brussel(Roman Standard Time)");
Set-TimeZone "Romance Standard Time";

#Installeren van  AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#promoten server naar domeincontroller in nieuwe forest.
Write-host("Server wordt gepromoveerd naar domaincontroller in een nieuwe forest.");
Install-ADDSForest -DomainName joeri.periode1 -InstallDns -DomainNetbiosName "JOERI" -SafeModeAdministratorPassword (ConvertTo-SecureString -String "Sloeri1997!" -AsPlainText -Force) -Force
