#Requires -Version 7.4
[CmdletBinding(SupportsShouldProcess)]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$solutionPath = Join-Path $repositoryRoot 'MermaidStudio.slnx'
$moduleRoot = Join-Path $repositoryRoot '.tools\Modules'
$toolVersions = Import-PowerShellDataFile -LiteralPath (Join-Path $PSScriptRoot 'tool-versions.psd1')

Assert-RequiredTool -Name 'dotnet'
Assert-RequiredTool -Name 'node'
Assert-RequiredTool -Name 'npm.cmd'
Assert-RequiredTool -Name 'Save-Module'

if ($PSCmdlet.ShouldProcess($webRoot, 'Install exact npm dependencies from package-lock.json')) {
    Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('ci') -WorkingDirectory $webRoot
}

if ($PSCmdlet.ShouldProcess($solutionPath, 'Restore .NET dependencies')) {
    Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList @('restore', $solutionPath) -WorkingDirectory $repositoryRoot
}

foreach ($moduleName in @('Pester', 'PSScriptAnalyzer')) {
    $moduleVersion = $toolVersions[$moduleName]
    $moduleVersionPath = Join-Path $moduleRoot "$moduleName\$moduleVersion"
    if ((Test-Path -LiteralPath $moduleVersionPath) -or
        -not $PSCmdlet.ShouldProcess($moduleVersionPath, "Download $moduleName $moduleVersion")) {
        continue
    }

    New-Item -ItemType Directory -Path $moduleRoot -Force | Out-Null
    Save-Module -Name $moduleName -RequiredVersion $moduleVersion -Repository 'PSGallery' -Path $moduleRoot
}

[pscustomobject]@{
    DotNetVersion = (& dotnet --version)
    NodeVersion = (& node --version)
    NpmVersion = (& npm.cmd --version)
    Repository = $repositoryRoot
}
