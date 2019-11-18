Import-Module "$PSScriptRoot/../private/Find-MsBuild.psm1"

function New-DeploymentPackage
{
    param (
        [Parameter(position = 0, mandatory = $true)]
        [string]$project,
        [Parameter()]
        [string]$destinationPath = (Join-Path $pwd -ChildPath 'deploymentPackage.zip')
    )

    $tempDirectory = Join-Path ([system.io.path]::GetTempPath()) -ChildPath ('dotnet-build-' + [guid]::NewGuid())
    New-Item $tempDirectory -ItemType Directory > $null
    Write-Host "Using temporary directory for build: $tempDirectory"
    
    try
    {
        $msbuildPath = Find-MsBuild
        & $msbuildPath (Resolve-Path $project) "/p:DeployOnBuild=True;Configuration=Release;DeployTarget=PipelinePreDeployCopyAllFilesToOneFolder;PackageTempRootDir=$tempDirectory"

        $resolvedDestinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($destinationPath)
        Write-Host "Compressing contents of $tempDirectory to $resolvedDestinationPath..."
        Compress-Archive -Path "$tempDirectory\PackageTmp\*" -DestinationPath $resolvedDestinationPath -Force
        Write-Host "Done. Applicaton package saved in $resolvedDestinationPath."
    }
    catch
    {
        Write-Host "Something went wrong: $_"
    }
    finally
    {
        Remove-Item -Recurse -Force $tempDirectory > $null
    }
}