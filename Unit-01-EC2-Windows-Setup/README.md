# Unit 01 - EC2 Windows Server Setup

## Overview
Launched a Windows Server 2019 EC2 instance on AWS Free Tier,
connected to it via RDP, and performed initial server configuration
including renaming the server, creating a local user account, and
setting up a permission-restricted shared directory.

## What Was Asked
1. Enroll in AWS Educate and launch a Windows Server 2019 EC2 instance on the free tier
2. Save the server key pair to local workstation
3. Reset the server password
4. Connect via RDP
5. Rename the server to YourLastName-ITEC350
6. Create a local user account
7. Create a shared directory restricted to local administrators only

## What I Did

**Launched EC2 instance:**
- AMI: Windows Server 2019 Base
- Instance type: t2.micro
- Downloaded and saved the .pem key pair to local workstation

**Reset the password:**
- EC2 Console > Instances > Connect > Get Windows Password
- Uploaded .pem key to decrypt the administrator password

**Connected via RDP:**
- Downloaded the RDP file from the EC2 Console
- Logged in using the decrypted administrator password

**Renamed the server:**
```powershell
Rename-Computer -NewName "YourLastName-ITEC350" -Restart
```

**Created a local user account:**
```powershell
New-LocalUser -Name "labuser" `
  -Password (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
  -FullName "Lab User" `
  -Description "ITEC350 local account"
```

**Created shared directory restricted to local administrators:**
```powershell
New-Item -ItemType Directory -Path "C:\AdminShare"

$acl = Get-Acl "C:\AdminShare"
$acl.SetAccessRuleProtection($true, $false)

$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
  "Administrators","FullControl","ContainerInherit,ObjectInherit","None","Allow"
)

$acl.SetAccessRule($rule)
Set-Acl -Path "C:\AdminShare" -AclObject $acl

New-SmbShare -Name "AdminShare" -Path "C:\AdminShare" -FullAccess "Administrators"
```

## What I Learned
- How to launch and connect to a Windows Server EC2 instance on AWS
- The .pem key pair is only used to decrypt the initial password losing it means losing access
- RDP requires port 3389 open in the EC2 security group inbound rules
- NTFS permissions and SMB share permissions are two separate things 
  both need to be configured to properly restrict access
- PowerShell can handle folder creation, ACL changes, and share setup without 
  using the GUI

## Troubleshooting
- RDP would not connect until port 3389 was opened in the EC2
  security group inbound rules
- Password reset requires the exact .pem file used at launch

