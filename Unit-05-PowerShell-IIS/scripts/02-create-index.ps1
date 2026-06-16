# Create index.html with name and course number

$html = @"
<!DOCTYPE html>
<html>
  <head><title>ITEC 350</title></head>
  <body>
    <h1>Safia</h1>
    <p>Course: ITEC 350 | Franklin University</p>
  </body>
</html>
"@

$html | Out-File -FilePath "C:\index.html" -Encoding UTF8
Write-Host "index.html created at C:\index.html" -ForegroundColor Green