#Requires -Version 7.4
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RepositoryRoot {
    [CmdletBinding()]
    [OutputType([string])]
    param()

    return (Split-Path -Parent $PSScriptRoot)
}

function Assert-RequiredTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name
    )

    if (-not (Get-Command -Name $Name -ErrorAction SilentlyContinue)) {
        throw "Required tool '$Name' was not found on PATH."
    }
}

function Add-RepositoryModulePath {
    [CmdletBinding()]
    param()

    $modulePath = Join-Path (Get-RepositoryRoot) '.tools\Modules'
    if (Test-Path -LiteralPath $modulePath) {
        $env:PSModulePath = "$modulePath$([IO.Path]::PathSeparator)$env:PSModulePath"
    }
}

function Invoke-ExternalCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $FilePath,

        [Parameter()]
        [string[]] $ArgumentList = @(),

        [Parameter(Mandatory)]
        [string] $WorkingDirectory
    )

    Push-Location -LiteralPath $WorkingDirectory
    try {
        & $FilePath @ArgumentList
        if ($LASTEXITCODE -ne 0) {
            throw "'$FilePath' exited with code $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
    }
}
