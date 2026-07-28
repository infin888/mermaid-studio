# ADR 0003: Local-content security model

Status: accepted

## Assets

- User-authored Mermaid source and local file paths.
- Clipboard and exported SVG/PNG content.
- Application integrity and the native/web trust boundary.

## Trust boundaries

- Local user files enter only through native pickers and the C# session.
- WebView2 content is untrusted relative to the native host even though it is
  bundled.
- Mermaid source is untrusted input and may contain hostile links, labels, CSS,
  directives, or malformed syntax.

## Controls

- Map only bundled files to a fixed HTTPS virtual hostname.
- Enforce a restrictive Content Security Policy.
- Initialize Mermaid with strict security.
- Block external navigation, new windows, downloads, permissions, and resource
  requests outside the fixed origin.
- Disable DevTools, browser context menus, accelerator keys, status bar, and
  default script dialogs in release builds.
- Exchange only `PostWebMessageAsJson` payloads with `protocolVersion`,
  `documentVersion`, discriminated `type`, and validated schemas.
- Reject unexpected origins, unknown message types, oversized payloads, and
  stale document versions.
- Sanitize exported SVG and render PNG from the sanitized result.
- Never log diagram source, file content, or direct personal data.

## Verification

Security fixtures cover scripts, event handlers, external URLs, CSS imports,
foreign objects, data URLs, stale messages, oversized payloads, malformed JSON,
navigation, popup, permission, and download attempts.

Official references:

- [WebView2 security best practices](https://learn.microsoft.com/microsoft-edge/webview2/concepts/security)
- [Working with local content](https://learn.microsoft.com/microsoft-edge/webview2/concepts/working-with-local-content)
