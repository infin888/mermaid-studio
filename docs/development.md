# Development

## Execution contract

- Host: Windows 11 x64.
- Shell: PowerShell 7.4 or newer, always with `-NoProfile`.
- SDKs: .NET 10, Node.js 20.19 or newer, npm 10 or newer.
- Native prerequisites: Visual Studio Community with Managed Desktop, Universal,
  and Windows App SDK C# components; Developer Mode enabled.
- Services: NuGet, npm, PowerShell Gallery, and GitHub during bootstrap and CI.
- Elevation: not required after the machine bootstrap.

The machine bootstrap is the WinUI skill-owned WinGet configuration:

```powershell
Set-Location C:\Users\tret\.codex\skills\winui-app
winget configure -f config.yaml --accept-configuration-agreements --disable-interactivity
dotnet new list winui
```

The current Microsoft template exposes the .NET and MVVM choices directly but
does not expose the older unpackaged switch. Mermaid Studio therefore starts from
the current `winui-mvvm` scaffold and explicitly declares
`WindowsPackageType=None` in the app project, following Microsoft deployment
guidance.

## Deterministic entry points

All scripts resolve paths from `$PSScriptRoot`, use full command names, run
without an interactive profile, and surface external tool failures.

```powershell
pwsh -NoProfile -File .\eng\bootstrap.ps1
pwsh -NoProfile -File .\eng\test.ps1
pwsh -NoProfile -File .\eng\lint.ps1
pwsh -NoProfile -File .\eng\verify.ps1
pwsh -NoProfile -File .\eng\run.ps1
pwsh -NoProfile -File .\eng\package.ps1
```

`bootstrap.ps1` restores exact npm and NuGet graphs and caches pinned Pester and
PSScriptAnalyzer modules under `.tools`. State-changing bootstrap and package
operations support `-WhatIf`.

## Deployment model

Local debug runs are unpackaged and framework-dependent on the Windows App SDK
runtime. Portable release output is unpackaged and self-contained for both .NET
and the Windows App SDK. The artifact deliberately remains a folder ZIP; WebView2
Evergreen is checked at startup and is not bundled.

Official references:

- [Distribute an unpackaged WinUI 3 app](https://learn.microsoft.com/windows/apps/package-and-deploy/unpackage-winui-app)
- [Windows App SDK deployment overview](https://learn.microsoft.com/windows/apps/package-and-deploy/deploy-overview)
- [WebView2 in WinUI 2 and WinUI 3](https://learn.microsoft.com/windows/apps/develop/ui/controls/webview2)
