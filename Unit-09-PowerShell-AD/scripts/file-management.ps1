
# 5. Create a txt file named after yourself

$filePath = "C:\Safia.txt"
$content  = "ITEC 350 - Windows Server Administration"

$content | Out-File -FilePath $filePath -Encoding UTF8
Write-Host "File created at $filePath" -ForegroundColor Green


# 6. Edit the file to append the current year

$filePath = "C:\Safia.txt"
$year     = "Year: $(Get-Date -Format 'yyyy')"

Add-Content -Path $filePath -Value $year
Write-Host "Year appended to $filePath" -ForegroundColor Green