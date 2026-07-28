Describe 'Engineering script contracts' {
    It '<Name> parses without errors' -ForEach (
        Get-ChildItem -LiteralPath (Split-Path -Parent $PSScriptRoot) -Filter '*.ps1' -File |
            ForEach-Object { @{ Name = $_.Name; FullName = $_.FullName } }
    ) {
        $tokens = $null
        $errors = $null
        [void][Management.Automation.Language.Parser]::ParseFile(
            $FullName,
            [ref] $tokens,
            [ref] $errors)

        $errors | Should -BeNullOrEmpty
    }

    It '<Name> declares PowerShell 7.4' -ForEach (
        Get-ChildItem -LiteralPath (Split-Path -Parent $PSScriptRoot) -Filter '*.ps1' -File |
            ForEach-Object { @{ Name = $_.Name; FullName = $_.FullName } }
    ) {
        (Get-Content -LiteralPath $FullName -TotalCount 1) | Should -Be '#Requires -Version 7.4'
    }
}
