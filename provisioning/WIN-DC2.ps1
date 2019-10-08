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

#install AD DS.
Write-host("AD DS feature wordt gëinstalleerd.");
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools;

#promoveren naar domain controller in joeri.periode1
Write-host("Server wordt gepromoveerd in het domein joeri.periode1 als 2de domeincontroller.");
$username = "JOERI\admin.joeri"
$password = "Verhavert1"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
Install-addsdomaincontroller -installdns -domainname "joeri.periode1" -Credential $cred -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Joeri1311" -Force) -Force

#aanpassen van ethernet adapters settings
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";
Write-host("Ip,subnet,default gateway, DNS van LAN adapter wordt aangepast. ")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.20 -PrefixLength 24 -DefaultGateway 192.168.100.10
Set-DnsClientServerAddress -InterfaceAlias LAN -ServerAddresses 192.168.100.10
Write-host("Nat interface wordt gedisabled.")
Disable-NetAdapter -Name "Ethernet" -Confirm:$false;