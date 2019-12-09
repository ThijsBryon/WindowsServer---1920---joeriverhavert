Clear-Host;
Import-Module ServerManager;
Import-Module PackageManagement;

Set-Location -Path "C:\SoftwarePackages\"

Invoke-WebRequest "https://download.microsoft.com/download/f/4/e/f4e4b3a0-925b-4eff-8cc7-8b5932d75b49/ExchangeServer2016-x64-cu14.iso" -OutFile ExhangeIsoFile.iso
Dism /Online /Enable-Feature /All /FeatureName:Server-Gui-Mgmt /Source:C:\TempTest

Mount-DiskImage -ImagePath "C:\SoftwarePackages\ExhangeIsoFile.iso"

Set-Location -Path "C:\"
sc stop WinDefend
#-- moet nog aangepast worden voor auto drive
Set-Location -Path "E:\"
.\Setup.exe /PrepareSchema /IAcceptExchangeServerLicenseTerms
.\Setup.exe /PrepareAD /IAcceptExchangeServerLicenseTerms
.\Setup.exe /M:Install /R:Mailbox, ManagementTools /IAcceptExchangeServerLicenseTerms
Set-Location -Path "C:\"
sc start WinDefend

#Gedownloade files verwijderen
Write-Host("Onnodige bestanden worden Verwijderd.")
Remove-Item –path c:\SoftwarePackages\* -include *.exe
#Remove-Item –path c:\SoftwarePackages\* -include *.iso
