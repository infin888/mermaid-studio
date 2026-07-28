#Requires -Version 7.4
[CmdletBinding(SupportsShouldProcess)]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$repositoryRoot = Get-RepositoryRoot
$webRoot = Join-Path $repositoryRoot 'src\MermaidStudio.Web'
$appProject = Join-Path $repositoryRoot 'src\MermaidStudio\MermaidStudio.csproj'
$artifactRoot = Join-Path $repositoryRoot 'artifacts'
$publishRoot = Join-Path $artifactRoot 'win-x64'
$archivePath = Join-Path $artifactRoot 'MermaidStudio-win-x64.zip'

$resolvedRepositoryRoot = [IO.Path]::GetFullPath($repositoryRoot)
$resolvedPublishRoot = [IO.Path]::GetFullPath($publishRoot)
if (-not $resolvedPublishRoot.StartsWith(
        "$resolvedRepositoryRoot$([IO.Path]::DirectorySeparatorChar)artifacts$([IO.Path]::DirectorySeparatorChar)",
        [StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to package outside the repository artifact directory: '$resolvedPublishRoot'."
}

if (-not $PSCmdlet.ShouldProcess($archivePath, 'Build and package the portable win-x64 application')) {
    return [pscustomobject]@{
        Archive = $archivePath
        Planned = $true
    }
}

Invoke-ExternalCommand -FilePath 'npm.cmd' -ArgumentList @('run', 'build') -WorkingDirectory $webRoot

if ((Test-Path -LiteralPath $publishRoot) -and
    $PSCmdlet.ShouldProcess($publishRoot, 'Remove previous portable publish output')) {
    Remove-Item -LiteralPath $publishRoot -Recurse -Force
}

New-Item -ItemType Directory -Path $artifactRoot -Force | Out-Null

$publishArguments = @(
    'publish',
    $appProject,
    '-c', 'Release',
    '-r', 'win-x64',
    '--self-contained', 'true',
    '-p:Platform=x64',
    '-p:WindowsPackageType=None',
    '-p:WindowsAppSDKSelfContained=true',
    '-p:PublishSingleFile=false',
    '-p:PublishTrimmed=false',
    '-p:PublishReadyToRun=true',
    '-o', $publishRoot
)
Invoke-ExternalCommand -FilePath 'dotnet' -ArgumentList $publishArguments -WorkingDirectory $repositoryRoot

if ((Test-Path -LiteralPath $archivePath) -and
    $PSCmdlet.ShouldProcess($archivePath, 'Replace previous portable ZIP')) {
    Remove-Item -LiteralPath $archivePath -Force
}

if ($PSCmdlet.ShouldProcess($archivePath, 'Create portable win-x64 ZIP')) {
    Compress-Archive -Path (Join-Path $publishRoot '*') -DestinationPath $archivePath -CompressionLevel Optimal
}

$archive = Get-Item -LiteralPath $archivePath
[pscustomobject]@{
    Archive = $archive.FullName
    SizeBytes = $archive.Length
    SizeMiB = [Math]::Round($archive.Length / 1MB, 2)
}
