# Unit 02 - Active Directory Domain Setup

## Overview
Created a second Windows Server EC2 instance, promoted the first
server to a domain controller, joined the second server to the domain,
configured Active Directory users, groups, and organizational units.

## What Was Asked
1. Create a second Windows Server (YourLastName02-ITEC350)
2. Promote the original server to domain controller (ITEC350.net)
3. Join YourLastName02-ITEC350 to the ITEC350.net domain
4. Adjust firewall rules so both servers can communicate
5. Create a standard user account in Active Directory
6. Create an administrator account with domain admin rights
7. Create an OU for standard users and an OU for administrators
8. Move accounts to their appropriate OUs

## What I Did

**Launched second EC2 instance:**
- AMI: Windows Server 2019 Base
- Instance type: t2.micro 
- Placed in the same VPC and availability zone as Server 1

**Promoted Server 1 to domain controller:**
```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest `
  -DomainName "ITEC350.net" `
  -DomainNetbiosName "ITEC350" `
  -InstallDns `
  -Force
```

**Joined Server 2 to the domain:**
```powershell
Add-Computer `
  -DomainName "ITEC350.net" `
  -Credential (Get-Credential) `
  -Restart
```

**Opened firewall rules for domain communication:**
```powershell
# Run on both servers
New-NetFirewallRule -DisplayName "Allow Domain Traffic" `
  -Direction Inbound `
  -Protocol Any `
  -Action Allow `
  -RemoteAddress <Server1-Private-IP>
```

**Created standard user account:**
```powershell
New-ADUser `
  -Name "Standard User" `
  -SamAccountName "stduser" `
  -UserPrincipalName "stduser@ITEC350.net" `
  -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
  -Enabled $true
```

**Created administrator account with domain admin rights:**
```powershell
New-ADUser `
  -Name "Admin User" `
  -SamAccountName "adminuser" `
  -UserPrincipalName "adminuser@ITEC350.net" `
  -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
  -Enabled $true

Add-ADGroupMember -Identity "Domain Admins" -Members "adminuser"
```

**Created OUs and moved accounts:**
```powershell
New-ADOrganizationalUnit -Name "Standard Users" -Path "DC=ITEC350,DC=net"
New-ADOrganizationalUnit -Name "Administrators" -Path "DC=ITEC350,DC=net"

Move-ADObject `
  -Identity "CN=Standard User,CN=Users,DC=ITEC350,DC=net" `
  -TargetPath "OU=Standard Users,DC=ITEC350,DC=net"

Move-ADObject `
  -Identity "CN=Admin User,CN=Users,DC=ITEC350,DC=net" `
  -TargetPath "OU=Administrators,DC=ITEC350,DC=net"
```

## What I Learned
- Both EC2 instances must be in the same VPC and availability zone
  to communicate over private IPs
- AD DS promotion requires a DNS server — the `-InstallDns` flag
  handles that automatically
- There are two layers of firewall to manage: Windows Firewall on
  the OS and the EC2 security group in AWS — both need to allow
  the right traffic
- Domain join fails if the DNS on Server 2 is not pointing at
  Server 1's private IP first

## Troubleshooting
- First attempt: completed the full domain controller setup on Server 1
  but could not join Server 2 to the domain. After extensive troubleshooting
  discovered both servers were in different availability zones and could not
  communicate over private IPs.
- Had to delete both instances and start over from scratch.
- Second attempt: launched both instances in the same availability zone
  before doing any configuration. Domain join worked as expected after that.

## If I Did This Again
- First thing before any configuration: confirm both instances are in
  the same availability zone and subnet
- Losing a fully configured domain controller because of an AZ mismatch
  should had verify placement at launch, not after the fact.
