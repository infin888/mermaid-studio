# Canvas First UI specification

The selected mockup in `canvas-first.png` is the visual source of truth.

## Hierarchy

1. A Mica-backed custom title bar with app identity and normal Windows caption
   behavior.
2. A native `CommandBar` for document actions, history, theme, and Design/Code
   mode.
3. A narrow native tool rail for contextual visual operations.
4. A dominant dotted canvas rendered in the single WebView2 workspace.
5. A native property inspector aligned to the right.
6. A collapsible Mermaid source drawer at the bottom of the workspace.

## Responsive behavior

- Wide (`>= 1180` effective px): persistent rail, canvas, inspector, and source
  drawer.
- Medium (`760–1179`): inspector becomes a command-triggered flyout.
- Narrow (`< 760`): Design and Code are mutually exclusive, secondary commands
  move to overflow, and the rail becomes compact.

## Visual tokens

- Platform type: Segoe UI Variable Display/Text.
- Base material: Mica; standard WinUI layer and card brushes.
- Default Mermaid palette: Spectrum.
- Spectrum accent range: violet, indigo, cyan, mint, amber.
- Alternatives: Aurora, Coastal, and Graphite.
- Focus: native visible focus visuals, never color-only selection.
- Icons: Fluent system icons only unless a supplied asset is explicitly used.

## Interaction baseline

Every visible control in the core editing flow must perform its labeled action.
Icon-only controls require a tooltip and accessible name. Pointer, keyboard,
touch, and pen share the same operations. Validation and save state remain visible
without stealing focus.
