# Architecture

Mermaid Studio uses a native document shell and one isolated local web workspace.

```mermaid
flowchart LR
  User["Keyboard, pointer, touch, pen"]
  Shell["WinUI 3 shell"]
  Session["C# document session"]
  Bridge["Versioned JSON bridge"]
  Workspace["Local WebView2 workspace"]
  Adapters["34 diagram adapters"]
  Mermaid["Mermaid 11.16.0"]
  Disk["Atomic local storage"]

  User --> Shell
  Shell --> Session
  Session <--> Bridge
  Bridge <--> Workspace
  Workspace --> Adapters
  Adapters --> Mermaid
  Session <--> Disk
```

Architecture decisions:

- [ADR 0001: native and web boundary](0001-native-web-boundary.md)
- [ADR 0002: adapter compatibility contract](0002-adapter-contract.md)
- [ADR 0003: local-content security model](0003-security-model.md)
- [ADR 0004: portable unpackaged release](0004-portable-release.md)
