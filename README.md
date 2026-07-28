# Mermaid Studio

Mermaid Studio is an offline-first, native Windows 11 editor for visually creating,
editing, validating, and exporting Mermaid diagrams without hiding their source.

The app combines a WinUI 3 shell with one secured WebView2 workspace. Mermaid is
pinned to `11.16.0`; the adapter registry treats its 34 authorable diagram types as
a tested compatibility boundary.

## Status

Active development. The repository is private and changes land through required,
squash-merged pull requests.

## Prerequisites

- Windows 11 x64
- PowerShell 7.4 or later
- .NET SDK 10
- Node.js 20 and npm 10
- Microsoft Edge WebView2 Evergreen Runtime

The WinUI bootstrap used for this repository is documented in
[`docs/development.md`](docs/development.md).

## Build

```powershell
pwsh -NoProfile -File .\eng\bootstrap.ps1
pwsh -NoProfile -File .\eng\verify.ps1
```

Launch the unpackaged development build:

```powershell
pwsh -NoProfile -File .\eng\run.ps1
```

Create the portable `win-x64` ZIP:

```powershell
pwsh -NoProfile -File .\eng\package.ps1
```

## Repository map

- `src/MermaidStudio` — native WinUI 3 shell and OS integration
- `src/MermaidStudio.Core` — platform-neutral document and adapter contracts
- `src/MermaidStudio.Web` — bundled Mermaid renderer/editor workspace
- `tests` — native and contract tests
- `eng` — deterministic PowerShell entry points
- `docs` — product, architecture, security, and design decisions

See [`docs/task-contract.md`](docs/task-contract.md) for the delivery contract and
[`docs/architecture/README.md`](docs/architecture/README.md) for the system design.
