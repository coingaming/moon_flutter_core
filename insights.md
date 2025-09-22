# Mix v2 Migration Insights

- Hand-written modifiers (`AnimatedOpacityModifier`, `AnimatedShapeDecorationModifier`, `DefaultTextStyleModifier`, `IconThemeModifier`) can extend `WidgetModifier` directly; pair them with `ModifierMix` + `MixUtility` to keep fluent `$with.*` APIs alive without relying on generated specs.
- `Prop.maybeMix`/`Prop.maybe` helpers smooth the transition from legacy DTOs—use `MoonBorderMix.maybeValue`-style factories whenever tapping into existing Moon abstractions.
- Optional animations fit neatly by keeping `Duration?` props nullable; resolve via `MixOps.resolve` and guard with explicit `*_shouldAnimate` checks to avoid redundant controllers.
- Examples still chained on `Style(... $box.chain ..)` migrate incrementally by swapping `$with.defaultTextStyle.style(...)` for the new utility calls, preserving variant logic while divorcing old `.chain` behaviour.
- `MoonBorder` no longer depends on `MixOutlinedBorder`; extending Flutter's `OutlinedBorder` keeps compatibility while exposing a `toMix()` shim for Mix v2 code paths.
