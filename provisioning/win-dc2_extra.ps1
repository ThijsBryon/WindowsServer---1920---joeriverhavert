#installeren en configuren van DHCP.
Write-host("DHCP feature wordt geinstalleerd.");
Install-WindowsFeature -Name 'DHCP' -IncludeManagementTools;

#Hostname veranderen
Rename-Computer -NewName "WIN-DC1"

Restart-Computer
