# ADR 0001: Native and web boundary

Status: accepted

## Decision

Use one WinUI 3 window and one shared WebView2. WinUI owns window chrome,
commands, dialogs, file lifecycle, settings, and the property inspector. The local
workspace owns Mermaid rendering, CodeMirror, hit testing, selection overlays,
and diagram-adapter execution.

## Rationale

The split retains native Windows behavior while keeping Mermaid and its parser in
their supported JavaScript environment. A single workspace avoids multiple
Chromium processes and duplicated document state.

## Consequences

The C# session is the persistence authority. All cross-boundary state is explicit
and versioned. Web content cannot directly read or write user files.
