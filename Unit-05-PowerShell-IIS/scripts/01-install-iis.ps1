# Install IIS web server role

Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Write-Host "IIS installed successfully." -ForegroundColor Green