Start-Sleep -Seconds 30

#Wachten tot wanneer we aan de AD kunnen.
Write-host("Wachten tot wanneer AD beschikbaar is..")
while ($true) {
try {
     Get-ADDomain | Out-Null
     break
} catch {
     Start-Sleep -Seconds 10
 }
}

#vagrant user wordt aan de admin groep toegevoegd.
Write-Host("Vagrant user wordt toegevoegd aan Admin groep") 
Add-ADGroupMember -Identity 'Domain Admins' -Members "CN=vagrant,CN=Users,DC=joeri,DC=periode1"

#Administrator wachwoord veranderen. 
Write-Host("Het administrator wachtwoord wordt aangepast.")
Set-ADAccountPassword -Identity "CN=Administrator,CN=Users,DC=joeri,DC=periode1" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText '!Admin1311' -Force)
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

#Group policy refresh 
Write-Host("Group policy wordt gerefreshed.")
Invoke-GPUpdate
Start-Sleep -Seconds 15