function Find-NuGet
{
    try
    {
        $nugetCommand = Get-Command nuget 2> $null
        if ($?)
        {
            return $nugetCommand.Source
        }
    }
    catch
    {
        Write-Debug "Nuget not found on PATH. Trying elsewhere."
    }

    $nugetDirectory = Join-Path ([System.IO.Path]::GetTempPath()) -ChildPath ('dotnet-build-nuget')
    $nugetPath = Join-Path $nugetDirectory -ChildPath nuget.exe
    $nugetUrl = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'

    if (!(Test-Path $nugetPath))
    {
        Write-Host "Couldn't find nuget CLI client. Downloading from $nugetUrl to $nugetPath"

        if (!(Test-Path $nugetDirectory))
        {
            New-Item $nugetDirectory -ItemType Directory > $null
        }

        Invoke-WebRequest -Uri $nugetUrl -OutFile $nugetPath
    }

    return $nugetPath
}

Export-ModuleMember -Function Find-NuGet