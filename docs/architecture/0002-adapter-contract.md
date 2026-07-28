# ADR 0002: Adapter compatibility contract

Status: accepted

## Decision

Every canonical diagram type registers a versioned adapter that can:

- detect and parse its grammar;
- expose contextual tools and inspector fields;
- map visual selections to source spans;
- apply typed, minimal source patches;
- validate mutations and render fixtures;
- describe supported create, edit, delete, reorder, relationship, and property
  operations.

Aliases are normalized before registry lookup. A parity test compares the 34
canonical adapters against Mermaid `11.16.0` metadata and blocks upgrades when
coverage changes.

## Parser policy

Use public `@mermaid-js/parser@1.2.0` ASTs where available. Remaining grammars may
use Mermaid's pinned internal diagram database only through one isolated gateway
with golden contract tests. No adapter imports Mermaid internals directly.

## Source policy

Adapters produce minimal text patches rather than regenerating entire documents.
Comments, YAML frontmatter, line endings, and unrelated formatting are preserved.
