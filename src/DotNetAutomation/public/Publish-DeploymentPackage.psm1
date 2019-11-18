function Verify-AzCliPresent
{
    & az *> $null
    if (!$?)
    {
        ThrowError "Azure CLI was not found. Follow the installation instructions on https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest and try again."
    }
}

function Ensure-AzCliLoggedIn
{
    & az account show *> $null
    if (!$?)
    {
        az login
        Ensure-AzCliLoggedIn
    }
}

function Publish-DeploymentPackage
{
    param (
        [Parameter(position = 0, mandatory = $true)]
        [string]$package,
        [Parameter(mandatory = $true)]
        [string]$resourceGroup,
        [Parameter(mandatory = $true)]
        [string]$deploymentTarget,
        [string]$deploymentSlot = ''
    )

    Verify-AzCliPresent
    Ensure-AzCliLoggedIn

    $packagePath = Resolve-Path $package

    $slotParameter = if ($PSBoundParameters.ContainsKey('deploymentSlot')) { ("--slot", $deploymentSlot) } else { '' }

    Write-Host "Deploying $packagePath to $deploymentTarget in $resourceGroup group"

    & az webapp deployment source config-zip --resource-group $resourceGroup --name $deploymentTarget --src $packagePath $slotParameter
}

Export-ModuleMember -Function Publish-DeploymentPackage