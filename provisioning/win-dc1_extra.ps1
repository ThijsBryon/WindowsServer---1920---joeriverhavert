#Nieuwe gebruiker aanmaken
Write-Host("Gebruiker Joeri Verhavert wordt aangemaakt.")
New-ADUser -Path "CN=Users,DC=joeri,DC=periode1" `
   -Name 'joerive' `
   -GivenName 'admin' `
   -Surname 'joeri' `
   -DisplayName 'admin joeri' `
   -AccountPassword (ConvertTo-SecureString -AsPlainText 'Verhavert1' -Force) `
   -Enabled $true `
   -PasswordNeverExpires $true

#Admin Joeri wordt toegevoegd aan juiste groepen
Write-Host("Gebruiker admin Joeri wordt toegevoegd aan de domain admins.")
Add-ADGroupMember `
-Identity 'Domain Admins' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
Add-ADGroupMember `
-Identity 'Administrators' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
Add-ADGroupMember `
-Identity 'Domain Users' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
Add-ADGroupMember `
-Identity 'Enterprise Admins' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
Add-ADGroupMember `
-Identity 'Group Policy Creator Owners' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"
Add-ADGroupMember `
-Identity 'Schema Admins' `
-Members "CN=admin.joeri,CN=Users,DC=joeri,DC=periode1"

#naamgeving netwerkadapters aanpassen.
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,WAN.");
Rename-NetAdapter -Name "Ethernet" -NewName "WAN";
Write-host("Netwerkadapter Ethernet heeft nieuwe naamgeving,LAN.");
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN";

#Ip address toewijzen
Write-host("Ip address wordt toegewezen.")
New-NetIPAddress -InterfaceAlias LAN -AddressFamily IPv4 -IPAddress 192.168.100.10 -PrefixLength 24

write-host "DHCP wordt geinstalleerd"
Install-WindowsFeature DHCP -IncludeManagementTools

# Makes the server able to do dhcp in the domain
write-host "DHCP feature wordt geconfigureerd"
Add-DhcpServerInDC
Get-DhcpServerInDC

# Add ip range for dhcp clients
Add-DhcpServerv4Scope -name "Clients" -StartRange 192.168.100.50 -EndRange 192.168.100.240 -SubnetMask 255.255.255.0
Get-DhcpServerv4Scope

# Set router and dns server for dhcp
Set-DhcpServerv4OptionValue -Router 192.168.100.10 -DnsServer 192.168.100.10
Get-DhcpServerv4OptionValue

# Restart the dhcpserver
write-host "Restarting the dhcp server"
Restart-Service dhcpserver
Get-Service dhcpserver

write-host "Routing feature wordt geinstalleerd"
Install-windowsFeature Routing -IncludeManagementTools -Restart

write-host "Routing feature wordt geinstalleerd"
Install-windowsFeature Routing -IncludeManagementTools -Restart

write-host "NAT wordt geconfigureerd"
Install-RemoteAccess -VpnType Vpn
netsh routing ip nat install
netsh routing ip nat add interface "WAN"
netsh routing ip nat set interface "WAN" mode=full
netsh routing ip nat add interface "LAN"

#Hostname veranderen
Rename-Computer -NewName "WIN-DC1"

Restart-Computer
