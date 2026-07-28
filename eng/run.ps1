#Requires -Version 7.4
[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$appProject = Join-Path $repositoryRoot 'src\MermaidStudio\MermaidStudio.csproj'
$executable = Join-Path $repositoryRoot 'src\MermaidStudio\bin\x64\Debug\net10.0-windows10.0.26100.0\win-x64\MermaidStudio.exe'

Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'build') -WorkingDirectory $webRoot
Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList @('build', $appProject, '-c', 'Debug', '-p:Platform=x64') -WorkingDirectory $repositoryRoot

if (-not (Test-Path -LiteralPath $executable)) {
    throw "Expected executable was not produced at '$executable'."
}

Start-Process -FilePath $executable -PassThru
