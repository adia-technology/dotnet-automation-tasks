Import-Module "$PSScriptRoot/../private/Find-NuGet.psm1"

function Restore-Packages
{
    param (
        [Parameter(position = 0, mandatory = $true)]
        [string]$solution
    )

    $nuget = Find-NuGet
    $solutionPath = Resolve-Path $solution
    
    Write-Host "Restoring packages: $nuget restore $solutionPath"
    & $nuget restore $solutionPath
}