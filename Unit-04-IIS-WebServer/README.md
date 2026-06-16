# Unit 04 - IIS Web Server Setup

## Overview
Installed the IIS web server role on Server 1, opened ports 80 and 443
in the AWS security group, and customized the default webpage to include
my name and course number.

## What Was Asked
1. Install the web server role on Server 1
2. Open ports 80 and 443 in the AWS security group
3. RDP into the server and verify running services
4. Check Task Manager while connected
5. Customize the webpage to include name and course number

## What I Did

**Installed IIS web server role:**
```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
```

**Verified IIS was running:**
```powershell
Get-Service -Name W3SVC
```
## What I Learned
- IIS is a Windows Server role — it has to be explicitly installed,
  it does not run by default
- There are two firewall layers to manage: the Windows Firewall on
  the OS and the AWS security group — both need the ports open
- The default IIS page lives at C:\inetpub\wwwroot\index.html —
  replacing it is all that is needed to change what the site displays
- Task Manager and Get-Service both show running services but
  Get-Service is faster and scriptable

