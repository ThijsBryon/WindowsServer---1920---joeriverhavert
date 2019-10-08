Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

#Controleren updates
Write-host("Controleren op updates..Even geduld aub.")
Install-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate

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

#Ip address toewijzen
Write-host("Ip address wordt toegewezen.")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.10 -PrefixLength 24 -Verbose

#Installeren van  AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#installeren en configuren van DHCP.
Write-host("DHCP feature wordt geinstalleerd.");
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools;

#promoten server naar domeincontroller in nieuwe forest.
Write-host("Server wordt gepromoveerd naar domaincontroller in een nieuwe forest.");
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "joeri.periode1" -InstallDns -DomainNetbiosName "JOERI" -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Joeri1311!" -Force ) -Force -Verbose
Write-host("Systeem zal herstart worden,even geduld aub..");

#vagrant user wordt aan de admin groep toegevoegd.
Write-Host("Vagrant user wordt toegevoegd aan Admin groep") 
Add-ADGroupMember -Identity 'Domain Admins' -Members "CN=vagrant,CN=Users,DC=joeri,DC=periode1"

#Administrator wachwoord veranderen. 
Write-Host("Het administrator wachtwoord wordt aangepast.")
Set-ADAccountPassword -Identity "CN=Administrator,CN=Users,DC=joeri,DC=periode1" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText 'Joeri1311!' -Force)
Set-ADUser -Identity "CN=Administrator,CN=Users,DC=joeri,DC=periode1" -PasswordNeverExpires $true

#Nieuwe gebruiker aanmaken
Write-Host("Gebruiker Joeri Verhavert wordt aangemaakt.")
New-ADUser -Path "CN=Users,DC=joeri,DC=periode1" `
    -Name 'admin.joeri' `
    -GivenName 'admin' `
    -Surname 'joeri' `
    -DisplayName 'admin joeri' `
    -AccountPassword (ConvertTo-SecureString -AsPlainText 'Verhavert1' -Force) `
    -Enabled $true `
    -PasswordNeverExpires $true

#Admin Joeri wordt toegevoegd aan Domain admins
Write-Host("Gebruiker admin Joeri wordt toegevoegd aan de domain admins.")
Add-ADGroupMember `
    -Identity 'Domain Admins' `
    -Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
	
#Buiten gebruik stellen van alle gebruikers behalve Administrator,vagrant en admin.joeri user
Write-Host("Buiten gebruik stellen van alle gebruikers behalve Administrator,vagrant en admin.joeri user.")
$Accounts = @(
    'vagrant',
    'Administrator',
	'admin.joeri'
)
Get-ADUser -Filter {Enabled -eq $true} | Where-Object {$Accounts -notcontains $_.Name}  | Disable-ADAccount

