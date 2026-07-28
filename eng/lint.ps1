#Requires -Version 7.4
[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$solutionPath = Join-Path $repositoryRoot 'MermaidStudio.slnx'
$analyzerSettings = Join-Path $PSScriptRoot 'PSScriptAnalyzerSettings.psd1'

Add-RepositoryModulePath

Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'lint') -WorkingDirectory $webRoot
Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'typecheck') -WorkingDirectory $webRoot
Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList @('format', $solutionPath, '--verify-no-changes', '--no-restore') -WorkingDirectory $repositoryRoot

$findings = @(Invoke-ScriptAnalyzer -Path $PSScriptRoot -Recurse -Settings $analyzerSettings)
if ($findings.Count -gt 0) {
    $findings | Format-Table -AutoSize
    throw "$($findings.Count) PSScriptAnalyzer finding(s) must be resolved."
}
