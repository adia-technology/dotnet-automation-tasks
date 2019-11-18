@{

# Script module or binary module file associated with this manifest.
RootModule = './DotNetAutomation.psm1'

# Version number of this module.
ModuleVersion = '0.0.3'

# ID used to uniquely identify this module
GUID = 'b098cffb-bb67-47c8-9578-71db144c7c78'

# Author of this module
Author = 'Michał Dudak'

# Company or vendor of this module
CompanyName = 'Adia'

# Copyright statement for this module
Copyright = '(c) Adia. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Powershell scripts that help automating building and deploying .NET applications.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '6.0'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Build-Project',
    'New-DeploymentPackage',
    'Publish-DeploymentPackage',
    'Restore-Packages'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        Prerelease = 'dev'

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('automation', 'build', 'deploy', '.NET')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/adia-technology/dotnet-automation-tasks/blob/master/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/adia-technology/dotnet-automation-tasks'

        # ReleaseNotes of this module
        ReleaseNotes = 'Verifying automatic publishing via GitHub actions. No functional changes.'

    } # End of PSData hashtable

} # End of PrivateData hashtable

}
