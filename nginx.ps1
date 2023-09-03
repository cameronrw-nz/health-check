Param (
    [string]$Name,
    [switch]$Fail
)

docker pull nginx

& "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ImagePulled' -Status 1

docker run --name=test -d nginx

& "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ContainerRunning' -Status 1

if ($Fail -eq $false) {
    Start-Sleep -Seconds 2
    docker rm -f test
    & "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ContainerStopped' -Status 1
}
else {
    $helpText = "The container couldn't be stopped. This could be because the container failed to terminate gracefully. You may need to manually delete the container."
    & "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ContainerStopped' -Status 2 -HelpText $helpText
}

docker image rm nginx

if ($? -eq $true) {
    & "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ImageRemoved' -Status 1
}
else {
    $helpText = "The image couldn't be removed. This could be because the container is still running. You may need to manually delete the container."
    & "$PSScriptRoot\Set-Json.ps1" -ResultSetName $Name -ResultName 'ImageRemoved' -Status 3 -HelpText $helpText
}