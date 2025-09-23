# Mix v2 Migration Notes

## Source Material
- `.llms/mix-scope-and-theming.md` – MixScope setup, token provisioning, modifier order.
- `.llms/token-migration-guide.md` – Token APIs, resolver changes, supported token types.
- `.llms/examples.xml` – Canonical usage of fluent stylers (`BoxStyler`, `TextStyler`, `Pressable`, `RowBox`, etc.).
- `.llms/tests.xml` – Behavioural expectations and advanced styling patterns.

## Core Architectural Changes
- **Scope Provisioning**: `MixScope` replaces `MixScopeData`. Consumers are expected to provide their own tokens (if any) when integrating Moon widgets. `MixScope.withMaterial` can still bridge Material Theme tokens within host apps.
- **Style Resolution**: `Style<S extends Spec<S>>` is now abstract. Concrete stylers (e.g., `BoxStyler`, `FlexStyler`, `TextStyler`) expose fluent APIs. No direct `Style()` constructor.<br>  - Mutable utilities via globals such as `$box`, `$flex`, `$text` wrap `*MutableStyler` classes.
  - Style resolution returns `StyleSpec<S>`, consumed via widgets (`Box`, `RowBox`, `StyleSpecBuilder`).
- **Variants**: `$on.*` helper is deprecated. Use styler instance methods `.onHovered(BoxStyler())`, `.onFocused(...)`, `.onDark(...)`, etc., provided by `VariantStyleMixin` / `UtilityVariantMixin`.
- **Widget Modifiers**: `WidgetModifierUtility` exposes fluent `wrap*` helpers; custom modifiers must extend `WidgetModifier<T>` and expose `ModifierMix` + `MixUtility` wrappers. Legacy `$with.*` helpers are obsolete.
- **Layout Widgets**: Replace `StyledRow` / `StyledColumn` with `RowBox` / `ColumnBox` (or `FlexBox`). Spacing between children uses `FlexSpec.spacing` / `.spacing()` instead of `.gap()`.
- **Animation**: Apply `AnimationConfig` via `.animate(AnimationConfig.easeInOut(…)`); keyframe/phase APIs available on stylers.

## Migration Tasks Checklist
1. **Headless Core**: Audit components to ensure no default styling or token coupling lives under `lib/`. Keep tokens and opinionated design decisions in the example app or downstream packages.
2. **Custom Attributes/Modifiers**: Update `MoonBorderMix`, animated modifiers, and extension utilities to use `Prop.maybeMix`, `MixOps.resolve/merge`, and return typed stylers/modifiers.
3. **Base Primitives**: Refactor `MoonBaseInteractiveWidget`, selection & overlay bases to accept `BoxStyler`/`FlexBoxStyler` instead of loose `Style` and switch to `Pressable` + `WidgetStatesController`.
4. **Components**: For every widget in `lib/src/widgets/`, rewrite style builders with fluent stylers, use layout stylers for structure only (direction, alignment), and avoid hard-coded visual tokens.
5. **Example App**: Showcase styling patterns in `example/` using Mix v2 semantics, including token provisioning if desired.
6. **Deprecated APIs Cleanup**: Eliminate `.gap`, `.withOpacity`, `.shadeXYZ`, raw `Color.alpha/red/…` access, `$with` helpers, and `StyledRow` references.
7. **Testing**: Align existing tests with new stylers (`BoxStyler`, `RowBox`). Add modifier coverage referencing `.llms/tests.xml` patterns.

## Breakage Expectations
- API surface will change (e.g., style getters returning `BoxStyler`). Breaking changes acceptable; update barrel exports & docs accordingly.
- Expect heavy touch across `example/` and tests to align with new Mix semantics.

## Open Questions / To Validate
- Define Moon token taxonomy (color, space, radius, typography, shadow) before component rewrites.
- Decide default modifier order (if any) via `MixScope(orderOfModifiers: …)` once components audited.
- Confirm replacement for legacy `Interactable` helper—likely direct `Pressable` usage with state controllers.
