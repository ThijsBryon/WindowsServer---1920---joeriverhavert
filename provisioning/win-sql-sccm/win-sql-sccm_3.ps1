#installeren van Windows Deployment Service
Write-Host("Installeren van Windows Deployment Service")
Install-WindowsFeature WDS -IncludeManagementTools
wdsutil /initialize-server /remInst:"C:\remInstall"

#Impoteren WdsBootImage
Write-Host("Boot image wordt geimporteerd.")
Import-WdsBootImage -Path "C:\sources\boot.wim"

#Moving iso to another distination
Write-Host("ISO file wordt gemoved naar een andere locatie.")
Move-Item -Path "\\VBOXSVR\WindowsServer---1920---joeriverhavert\files\WIN10.iso" -Destination "C:\ISO"

#Mount iso
Write-Host("ISO file wordt gemount")
Set-Location -Path "C:\"
Mount-DiskImage -ImagePath "C:\ISO\WIN10.iso"

#Configuratie Wds
Write-Host("WDS wordt geconfigureerd.")
Import-WdsBootImage -Path "E:\sources\boot.wim"
New-WdsInstallImageGroup -Name "desktops"
Import-WdsInstallImage -ImageGroup "desktops" -Path "E:\sources\install.wim" -ImageName "Windows 10 Home"
