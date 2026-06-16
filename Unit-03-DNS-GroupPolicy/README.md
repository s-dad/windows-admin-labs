# Unit 03 - DNS and Group Policy

## Overview
Created a DNS entry for the second server, configured Group Policy
for the default domain including IE homepage, audit policy settings,
and password policy.

## What Was Asked
1. Create a DNS entry for Server 2 as server2.ITEC350.net
2. Create a Group Policy to set the IE homepage to Franklin.edu
3. Configure audit policy settings via Group Policy
4. Create a Group Policy to change the default password policy

## What I Did

**Created DNS entry for Server 2:**
```powershell
Add-DnsServerResourceRecordA `
  -Name "server2" `
  -ZoneName "ITEC350.net" `
  -IPv4Address "<Server2-Private-IP>"
```

**Verified DNS entry:**
```powershell
Resolve-DnsName -Name "server2.ITEC350.net"
```

**Created GPO for IE homepage:**
```powershell
New-GPO -Name "IE Homepage Policy" | `
New-GPLink -Target "DC=ITEC350,DC=net"
```
## What I Learned
- DNS A records are how hostnames resolve to IP addresses —
  without this Server 2 could only be reached by IP
- Group Policy applies at the domain level meaning every machine
  and user in the domain inherits the policy automatically
- Audit policies and password policies are separate GPOs —
  keeping them separate makes them easier to manage and troubleshoot
- auditpol is faster than navigating the GUI for audit settings

## Troubleshooting
No issues encountered. Everything completed successfully on the first attempt.
