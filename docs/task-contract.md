# Task contract

## Outcome

A private, native Windows 11 application named Mermaid Studio that visually
creates, edits, validates, renders, and exports every authorable diagram type in
Mermaid `11.16.0`, while keeping Mermaid source directly editable and synchronized.

## Current state

- Repository: `infin888/mermaid-studio` (private).
- Local checkout: `C:\Apps\apex\MermaidStudio`.
- Seed commit: the GitHub-created README that establishes `main`.
- Visual source of truth: `docs/design/canvas-first.png`.
- Toolchain: Windows 11, .NET 10, WinUI 3, Node 20, PowerShell 7.

## Evidence map

- Native startup and window chrome: `src/MermaidStudio/App.xaml*`,
  `src/MermaidStudio/MainWindow.xaml*`.
- Native editor shell: `src/MermaidStudio/MainPage.xaml*`.
- Platform-neutral contracts and persistence: `src/MermaidStudio.Core`.
- Mermaid rendering, CodeMirror, hit testing, and adapters:
  `src/MermaidStudio.Web`.
- Native and adapter tests: `tests`.
- Reproducible entry points: `eng`.
- CI and repository policy: `.github`.

## Constraints

- Windows 11 x64, native WinUI 3 shell, .NET 10, unpackaged deployment.
- One shared WebView2 surface and the installed Evergreen runtime; Chromium is
  not bundled.
- Mermaid is pinned to `11.16.0`; `@mermaid-js/parser` is pinned to `1.2.0`.
- All 34 canonical authorable types require type-appropriate visual mutations.
- Local-only and offline-first; no account, cloud service, telemetry, or external
  web content.
- Web content is bundled, served from a fixed HTTPS virtual host, and isolated by
  a versioned, schema-validated JSON bridge.
- Portable compressed artifact target: under 120 MiB, excluding WebView2.
- Typical idle working set target: under 250 MiB.

## Non-goals

- Cloud sync, real-time collaboration, AI generation, a plugin marketplace.
- PDF export, MSIX/Store packaging, an updater, analytics, or telemetry.
- Arbitrary free-positioning for grammars without coordinate semantics.
- Changes to files outside `C:\Apps\apex\MermaidStudio`.

## Allowed changes

- All files in the new Mermaid Studio checkout.
- Private GitHub repository settings, Actions, branch rules, branches, pull
  requests, and releases for `infin888/mermaid-studio`.
- Local package caches and build outputs created by the documented bootstrap.

## Acceptance criteria

1. The app directly launches an unpackaged, responsive top-level Windows window.
2. Native commands, tool rail, inspector, and responsive shell match the selected
   Canvas First mockup.
3. Design and Code modes remain synchronized with undo and redo.
4. Every canonical diagram type has a searchable template and tested visual
   create, edit, delete, reorder, relationship, and property operations where
   its grammar can encode them.
5. `.mmd` and `.mermaid` files load and save atomically as UTF-8 while retaining
   line endings, frontmatter, comments, and unrelated formatting.
6. The local workspace blocks external navigation, popups, remote fetches, and
   stale or malformed bridge messages.
7. SVG, PNG, and clipboard export work from the running app.
8. Light, dark, high-contrast, wide, medium, and narrow layouts remain usable by
   keyboard, mouse, touch, and pen; meaningful controls expose Narrator names.
9. Restore, lint, test, build, parity, render fixtures, security fixtures, and
   portable packaging pass in CI.
10. The portable ZIP launches on a clean Windows 11 test account and satisfies
    the documented size and performance budgets.

## Verification

- `pwsh -NoProfile -File .\eng\bootstrap.ps1`
- `pwsh -NoProfile -File .\eng\lint.ps1`
- `pwsh -NoProfile -File .\eng\test.ps1`
- `pwsh -NoProfile -File .\eng\verify.ps1`
- `pwsh -NoProfile -File .\eng\package.ps1`
- Direct executable launch with a confirmed non-zero window handle and expected
  title.
- UI automation and visual comparison against the selected mockup at wide,
  medium, and narrow sizes.
- Manual keyboard, accessibility, scaling, export, recovery, and hostile-input
  scenarios documented in the release checklist.

## Environment policy

- Network is allowed for NuGet, npm, PowerShell Gallery, GitHub, and official
  Microsoft documentation.
- The WinUI bootstrap may install required Visual Studio components and enable
  Developer Mode.
- No tenant, cloud, or user-data access is required.
- Destructive operations remain limited to generated build output, explicit
  feature branches, and repository-owned GitHub state.

## Deliverables

- Source, tests, build scripts, architecture decisions, security model, UI
  evidence, portable ZIP, release notes, and a design QA report.
- Eight populated pull requests with passing required checks and squash commits
  on `main`.

## Execution instruction

Implement the smallest complete change for each pull request, verify it locally,
review its diff against `C:\Users\tret\.codex\templates\review-criteria.md`, push
the branch, wait for required checks, and squash-merge before beginning the next
scope. Report exact evidence and do not mark an unrun check as passed.
