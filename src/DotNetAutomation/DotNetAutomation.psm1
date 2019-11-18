$publicModules  = @(Get-ChildItem -Path $PSScriptRoot\public\*.psm1 -ErrorAction SilentlyContinue)
$privateModules = @(Get-ChildItem -Path $PSScriptRoot\private\*.psm1 -ErrorAction SilentlyContinue)

foreach($import in @($publicModules + $privateModules))
{
    try
    {
        Import-Module $import.fullname
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $publicModules.Basename