#Requires -Version 7.4
[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$testProject = Join-Path $repositoryRoot 'tests\MermaidStudio.Core.Tests\MermaidStudio.Core.Tests.csproj'

Add-RepositoryModulePath

Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'test') -WorkingDirectory $webRoot
Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList @('test', $testProject, '-c', 'Release', '--no-restore') -WorkingDirectory $repositoryRoot

$pesterConfiguration = New-PesterConfiguration
$pesterConfiguration.Run.Path = Join-Path $PSScriptRoot 'tests'
$pesterConfiguration.Run.PassThru = $true
$pesterConfiguration.Output.Verbosity = 'Detailed'
$pesterResult = Invoke-Pester -Configuration $pesterConfiguration
if ($pesterResult.FailedCount -gt 0) {
    throw "$($pesterResult.FailedCount) PowerShell contract test(s) failed."
}
