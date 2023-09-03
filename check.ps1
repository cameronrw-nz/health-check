$filePath = "C:\code\other\src\HealthCheck\data.json"


$a = (ConvertFrom-Json -InputObject '{"ResultSets": [{"Name":"hosts", "Results":[]},{"Name":"nginx", "Results":[]},{"Name":"rabbitmq", "Results":[]},{"Name":"istio", "Results":[]},{"Name":"application", "Results":[]}]}')
$a.ResultSets | % { if ($_.Name -eq 'nginx') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a.ResultSets | % { if ($_.Name -eq 'rabbitmq') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a.ResultSets | % { if ($_.Name -eq 'istio') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a.ResultSets | % { if ($_.Name -eq 'application') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a.ResultSets | % { if ($_.Name -eq 'hosts') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a | ConvertTo-Json -depth 32 | set-content $filePath

& "$PSScriptRoot\nginx.ps1" -Name 'hosts'
& "$PSScriptRoot\nginx.ps1" -Name 'nginx' -Fail
& "$PSScriptRoot\nginx.ps1" -Name 'rabbitmq'
& "$PSScriptRoot\nginx.ps1" -Name 'istio' -Fail
& "$PSScriptRoot\nginx.ps1" -Name 'application'