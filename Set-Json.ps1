Param (
    [string]$FilePath,
    [string]$ResultSetName,
    [string]$ResultName,
    [int]$Status,
    [AllowNull()][string]$HelpText = $null
)

$FilePath = "C:\code\other\src\HealthCheck\data.json"

$a = Get-Content $FilePath -raw | ConvertFrom-Json
$a.ResultSets | % { 
    if ($_.name -eq $ResultSetName) {
        $_.Results | % { 
            # Match Result in Json with the name parameter
            if ($_.name -eq $ResultName) { 
                $_.Status = $Status 

                # If the Help Text has a value
                if ($HelpText -ne $null -and $HelpText -ne '') {

                    # Determine if HelpText in the json already has a property
                    if (Get-Member -InputObject $_ -name "HelpText" -MemberType Properties) {
                        $_.HelpText += $HelpText
                    }
                    else {
                        $_ | Add-Member -Type NoteProperty -Name 'HelpText' -Value @()
                        $_.HelpText += $HelpText
                    }
                }
            } 
        }
    } 
}
$a | ConvertTo-Json -depth 32 | set-content $FilePath