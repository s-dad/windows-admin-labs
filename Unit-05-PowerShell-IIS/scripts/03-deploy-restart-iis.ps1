# Copy index.html to IIS root and restart IIS

Copy-Item -Path "C:\index.html" `
  -Destination "C:\inetpub\wwwroot\index.html" -Force

Restart-Service -Name W3SVC
Write-Host "index.html deployed and IIS restarted." -ForegroundColor Green