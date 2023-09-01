Param (
    [string]$FilePath,
    [string]$ResultSetName,
    [string]$ResultName,
    [int]$Status,
    [AllowNull()][string]$HelpText = $null
)

$a = Get-Content $FilePath -raw | ConvertFrom-Json
$a.ResultSets | % { if ($_.name -eq $ResultSetName) {
        $_.Results | % { if ($_.name -eq $ResultName) { 
            $_.Status = $Status 
            if ($HelpText -ne $null) {
                $_ | Add-Member -Type NoteProperty -Name 'HelpText' -Value $HelpText
            }
        } }
    } }
$a | ConvertTo-Json -depth 32 | set-content $FilePath