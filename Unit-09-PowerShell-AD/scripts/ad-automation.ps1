
# 1. Create a new AD user account

Import-Module ActiveDirectory

New-ADUser `
  -Name "John Smith" `
  -GivenName "John" `
  -Surname "Smith" `
  -SamAccountName "jsmith" `
  -UserPrincipalName "jsmith@ITEC350.net" `
  -Path "OU=StandardUsers,DC=ITEC350,DC=net" `
  -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
  -Enabled $true

Write-Host "User jsmith created successfully." -ForegroundColor Green


# 2. Create new OU and move user into it

New-ADOrganizationalUnit `
  -Name "ITEC350-Students" `
  -Path "DC=ITEC350,DC=net" `
  -ProtectedFromAccidentalDeletion $false

Write-Host "OU created." -ForegroundColor Green

Move-ADObject `
  -Identity "CN=John Smith,OU=StandardUsers,DC=ITEC350,DC=net" `
  -TargetPath "OU=ITEC350-Students,DC=ITEC350,DC=net"

Write-Host "User moved to ITEC350-Students OU." -ForegroundColor Green


# 3. Reset passwords for 2 user accounts

$newPassword = ConvertTo-SecureString "NewP@ss2024!" -AsPlainText -Force

Set-ADAccountPassword -Identity "jsmith" -NewPassword $newPassword -Reset
Write-Host "Password reset for jsmith." -ForegroundColor Green

Set-ADAccountPassword -Identity "adminuser" -NewPassword $newPassword -Reset
Write-Host "Password reset for adminuser." -ForegroundColor Green


# 4. Remotely restart Server 2

$targetServer = "YourLastName02-ITEC350"

Restart-Computer -ComputerName $targetServer -Force -Wait
Write-Host "Restart command sent to $targetServer." -ForegroundColor Green
