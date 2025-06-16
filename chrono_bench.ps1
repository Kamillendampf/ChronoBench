


# Save all running processes at script start
$initialProcs = Get-Process | Select-Object -Property Id, ProcessName
Write-Host "Processes at script start:"
$initialProcs | Format-Table
$initialProcIds = $initialProcs.Id

# Configuration
$batFile =""
$url = ""
$username = ""
$password = ""
$outputFile = ".\response-times.txt" #configure your path to the output file

$payload = @'
{
  #Payload
}
'@

Write-Host ""  #Name your test run here
$logLine = ""  #Name your test run here
$logLine | Add-Content -Path $outputFile

for ($i = 1; $i -le 85; $i++) {
    # Start the BAT file
    $process = Start-Process -FilePath $batFile -PassThru
    Start-Sleep -Seconds 30 #Confidure the wait time for systemstart

    # Prepare auth header
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$username`:$password"))
    $headers = @{
        Authorization = "Basic $base64AuthInfo"
        "Content-Type" = "application/json"
    }

    # Measure response time
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        $response = Invoke-WebRequest -Uri $url -Headers $headers -Method POST -Body $payload -TimeoutSec 30
    } catch {
        $response = $_.Exception.Message
    }
    $stopwatch.Stop()
    $elapsedMs = $stopwatch.ElapsedMilliseconds

    Write-Host "Run $i Response time = $elapsedMs ms"
$logLine = "$elapsedMs ms"
$logLine | Add-Content -Path $outputFile
    Write-Host "ProcessId $($process.Id)"


$finalProcs = Get-Process
$newProcs = $finalProcs | Where-Object { $initialProcIds -notcontains $_.Id }
foreach ($proc in $newProcs) {
    try {
        Stop-Process -Id $proc.Id -Force
        #Write-Host "Stopped process $($proc.ProcessName) (Id: $($proc.Id))"
    } catch {
        # Ignore errors if process already exited
    }
    Start-Sleep -Seconds 5 #configure time that your system needs to shut down
}
}
