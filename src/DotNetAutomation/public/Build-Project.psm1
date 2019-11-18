Import-Module "$PSScriptRoot/../private/Find-MsBuild.psm1" -Force

function Build-Project
{
    param (
        [Parameter(position = 0, mandatory = $true)]
        [string]$project
    )

    $msbuildPath = Find-MsBuild
    $projectPath = Resolve-Path $project
    Write-Host "Building $projectPath using $msbuildPath"

    & $msbuildPath $projectPath /t:Build /p:Configuration=Release
}