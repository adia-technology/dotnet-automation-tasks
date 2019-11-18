function Find-MsBuild
{
    try 
    {
        $msbuildCommand = Get-Command msbuild 2> $null
        if ($?)
        {
            return $msbuildCommand.Source
        }
    }
    catch
    {
        Write-Debug "MSBuild not found on PATH. Trying elsewhere."
    }

    Install-Module VSSetup -Scope CurrentUser -Force
    $instance = Get-VSSetupInstance -All -Prerelease | Select-VSSetupInstance -Require 'Microsoft.Component.MSBuild' -Latest
    $installDir = $instance.installationPath
    $msBuild = $installDir + '\MSBuild\Current\Bin\MSBuild.exe' # VS2019
    if (![System.IO.File]::Exists($msBuild))
    {
        $msBuild = $installDir + '\MSBuild\15.0\Bin\MSBuild.exe' # VS2017
        if (![System.IO.File]::Exists($msBuild))
        {
            ThrowError "MSBuild doesn't exist. Exit."
        }
    }

    return $msBuild
}

Export-ModuleMember -Function Find-MsBuild
