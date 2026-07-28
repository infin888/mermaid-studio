# ADR 0004: Portable unpackaged release

Status: accepted

## Decision

Ship an unpackaged, self-contained `win-x64` folder as a compressed ZIP. The .NET
runtime and Windows App SDK runtime are included; the shared WebView2 Evergreen
runtime is not.

## Rationale

This enables direct launch without MSIX identity, Store infrastructure, or an
installer, while keeping the web runtime outside the artifact and within the
120 MiB compressed budget.

## Startup

The app checks WebView2 availability before constructing the workspace and gives
an actionable native error if the runtime is absent. Persistence uses
`%LocalAppData%\MermaidStudio` instead of package-identity APIs.

## Packaging

`eng/package.ps1` publishes the app project directly for `win-x64`, replaces only
the repository-owned artifact directory, and creates
`artifacts/MermaidStudio-win-x64.zip`.
