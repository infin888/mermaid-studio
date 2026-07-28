#Requires -Version 7.4
[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$appProject = Join-Path $repositoryRoot 'src\MermaidStudio\MermaidStudio.csproj'

& (Join-Path $PSScriptRoot 'bootstrap.ps1')
& (Join-Path $PSScriptRoot 'lint.ps1')
& (Join-Path $PSScriptRoot 'test.ps1')

Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'build') -WorkingDirectory $webRoot
Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList @('build', $appProject, '-c', 'Release', '-p:Platform=x64', '--no-restore') -WorkingDirectory $repositoryRoot
