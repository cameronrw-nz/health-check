Param (
    [switch]$Fail
)

$filePath = "C:\code\other\src\HealthCheck\data.json"

$a = (ConvertFrom-Json -InputObject '{"ResultSets": [{"Name":"nginx", "Results":[]}]}')
$a.ResultSets | % { if ($_.Name -eq 'nginx') {
        Write-Output $_
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImagePulled", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerRunning", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ContainerStopped", "Status":0}')
        $_.Results += (ConvertFrom-Json -InputObject '{"Name":"ImageRemoved", "Status":0}')
    } }
$a | ConvertTo-Json -depth 32 | set-content $filePath
    
docker pull nginx

.\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ImagePulled' -Status 1

docker run --name=test -d nginx

.\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ContainerRunning' -Status 1

if ($Fail -eq $false) {
    Start-Sleep -Seconds 5
    docker rm -f test
    .\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ContainerStopped' -Status 1
}
else {
    $helpText = "The container couldn't be stopped. This could be because the container failed to terminate gracefully. You may need to manually delete the container."
    .\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ContainerStopped' -Status 2 -HelpText $helpText
}

docker image rm nginx

if ($? -eq $true) {
    .\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ImageRemoved' -Status 1
}
else {
    $helpText = "The image couldn't be removed. This could be because the container is still running. You may need to manually delete the container."
    .\Set-Json.ps1 -FilePath $filePath -ResultSetName 'nginx' -ResultName 'ImageRemoved' -Status 3 -HelpText $helpText
}