# Unit 09 - PowerShell Active Directory Automation

## Overview
Used PowerShell to automate Active Directory tasks including user
creation, OU management, password resets, remote server restart,
and file creation and editing.

## What Was Asked
1. Create a new AD user account using PowerShell
2. Create a new OU and move the user to it in the same script
3. Reset passwords for 2 user accounts in one script
4. Remotely restart the second server using PowerShell
5. Create a script that makes a txt file named after yourself
   with the class name in the file
6. Create a separate script that edits the file to add the year

## What I Did

**Created a new AD user account** using `New-ADUser` with all
required attributes including name, UPN, password, and enabled state.

**Created a new OU and moved the user into it** in a single script
using `New-ADOrganizationalUnit` followed by `Move-ADObject` with
the user's full distinguished name as the target.

**Reset passwords for 2 user accounts** in one script using
`Set-ADAccountPassword` with the `-Reset` flag to bypass the
old password requirement.

**Remotely restarted Server 2** using `Restart-Computer` with
the `-Wait` flag to hold the script until the server came back online.

**Created a txt file named after myself** using `Out-File` with
the class name as the file contents.

**Edited the file to append the current year** using `Add-Content`
to avoid overwriting the existing content.

## Scripts

| Script | Description |
|--------|-------------|
| [ad-automation.ps1](scripts/ad-automation.ps1) | AD user creation, OU management, password resets, remote restart |
| [file-management.ps1](scripts/file-management.ps1) | Creates and edits a txt file with class name and year |


## What I Learned
- Import-Module ActiveDirectory must be run before any AD cmdlets
  or they will not be recognized
- Move-ADObject requires the full distinguished name of the user
  not just the username
- Set-ADAccountPassword with -Reset bypasses the old password
  requirement which is useful for admin resets
- Restart-Computer with -Wait blocks the script until the remote
  server comes back online
- Add-Content appends to an existing file without overwriting it 
  Out-File would replace the contents entirely
