Function Test-UserGroupMemberOf {

    $whoamiOutput = whoami /all

    $whoamiOutput | Select-String "User Name" -Context (0, 3)

    [array]$g = GetGroupMatches $whoamiOutput "Domain Admins"

    if ($g.Count -gt 0) {
        $g | ForEach-Object { Write-Host "User is a member of $($_.GroupName)   $($_.SID)" }
    } else {
        Write-Warning "User is not a member of Domain Admins."
    }

    [array]$g = GetGroupMatches $whoamiOutput "Schema Admins"

    if ($g.Count -gt 0) {
        $g | ForEach-Object { Write-Host "User is a member of $($_.GroupName)   $($_.SID)" }
    } else {
        Write-Warning "User is not a member of Schema Admins. - Only required if doing a Schema Update"
        $Script:NotSchemaAdmin = $true
    }

    [array]$g = GetGroupMatches $whoamiOutput "Enterprise Admins"

    if ($g.Count -gt 0) {
        $g | ForEach-Object { Write-Host "User is a member of $($_.GroupName)   $($_.SID)" }
    } else {
        Write-Warning "User is not a member of Enterprise Admins. - Only required if doing a Schema Update or PrepareAD or PrepareDomain"
        $Script:NotEnterpriseAdmin = $true
    }

    [array]$g = GetGroupMatches $whoamiOutput "Organization Management"

    if ($g.Count -gt 0) {
        $g | ForEach-Object { Write-Host "User is a member of $($_.GroupName)   $($_.SID)" }
    } else {
        Write-Warning "User is not a member of Organization Management."
    }

    $p = Get-ExecutionPolicy
    if ($p -ne "Unrestricted" -and $p -ne "Bypass") {
        Write-Warning "ExecutionPolicy is $p"
    } else {
        Write-Host "ExecutionPolicy is $p"
    }
}

function GetGroupMatches($whoamiOutput, $groupName) {
    $m = @($whoamiOutput | Select-String "(^\w+\\$($groupName))\W+Group")
    if ($m.Count -eq 0) { return $m }
    return $m | ForEach-Object {
        [PSCustomObject]@{
            GroupName = ($_.Matches.Groups[1].Value)
            SID       = (GetSidFromLine $_.Line)
        }
    }
}

Function GetSidFromLine ([string]$Line) {
    $startIndex = $Line.IndexOf("S-")
    return $Line.Substring($startIndex,
        $Line.IndexOf(" ", $startIndex) - $startIndex)
}

