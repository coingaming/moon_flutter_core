# Moon Flutter Core - Mix v2 Total Refactoring Guide

## Overview
This guide provides radical refactoring patterns to completely modernize Moon Flutter Core using Mix v2's full capabilities. No backwards compatibility - maximum Mix patterns.

## Table of Contents
1. [Core Philosophy](#core-philosophy)
2. [New Base Architecture](#new-base-architecture)
3. [Radical Widget Simplifications](#radical-widget-simplifications)
4. [Style System Architecture](#style-system-architecture)
5. [Implementation Strategy](#implementation-strategy)

---

## Core Philosophy

### 🚀 Radical Goals
- **Eliminate ALL AnimationControllers** - Zero manual animation management
- **Remove ALL StatefulWidgets** where possible - Use Mix's reactive system
- **Delete 60-80% of code** - Aggressive simplification
- **Style-First Architecture** - Everything is a styled Mix widget
- **No Custom Paint** - Use Mix's decoration system instead

### 🔥 Breaking Changes Welcome
1. **Delete backwards compatibility code**
2. **Remove all deprecated patterns**
3. **Eliminate widget controller classes**
4. **Replace inheritance with composition**
5. **Use Mix for EVERYTHING**

---

## New Base Architecture

### DELETE These Base Classes
```dart
// ❌ DELETE ALL OF THESE
class MoonBaseInteractiveWidget  // Delete - use Pressable directly
class MoonBaseOverlayWidget      // Delete - use Mix overlays
class MoonBaseSingleSelectWidget  // Delete - use variants
class MoonBaseMultiSelectWidget   // Delete - use variants
```

### REPLACE With Mix Primitives
```dart
// ✅ USE ONLY THESE
Box()           // All containers
FlexBox()       // Row/Column layouts
RowBox()        // Horizontal layouts
ColumnBox()     // Vertical layouts
ZBox()          // Stack layouts
StyledText()    // All text
StyledIcon()    // All icons
Pressable()     // All interactive elements
PressableBox()  // Interactive containers
```

---

## Radical Widget Simplifications

### 1. MoonSwitch - 20 Lines Total
```dart
// ENTIRE widget implementation
class MoonSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const MoonSwitch({required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onChanged != null ? () => onChanged!(!value) : null,
      style: $switch.track(value),
      child: Box(style: $switch.thumb(value)),
    );
  }
}
```

### 2. MoonCheckbox - 15 Lines Total
```dart
class MoonCheckbox extends StatelessWidget {
  final bool? value; // Supports tristate
  final ValueChanged<bool?>? onChanged;

  const MoonCheckbox({this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onChanged != null ? () => onChanged!(_nextValue) : null,
      style: $checkbox.container(value),
      child: StyledIcon(style: $checkbox.check(value)),
    );
  }

  bool? get _nextValue => value == null ? false : !value!;
}
```

### 3. MoonButton - 10 Lines Total
```dart
class MoonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const MoonButton({this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onPressed,
      style: $button.base,
      child: child,
    );
  }
}
```

### 4. MoonAccordion - 25 Lines Total
```dart
class MoonAccordion extends StatelessWidget {
  final bool isExpanded;
  final Widget header;
  final Widget content;
  final VoidCallback? onToggle;

  const MoonAccordion({
    required this.isExpanded,
    required this.header,
    required this.content,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ColumnBox(
      style: $accordion.container,
      children: [
        PressableBox(
          onPress: onToggle,
          style: $accordion.header,
          child: RowBox(
            style: $flex.spaceBetween,
            children: [
              header,
              StyledIcon(style: $accordion.icon(isExpanded)),
            ],
          ),
        ),
        AnimatedBox(
          style: $accordion.content(isExpanded),
          child: content,
        ),
      ],
    );
  }
}
```

### 5. MoonTooltip - 30 Lines with Phase Animation
```dart
enum TooltipPhase { hidden, showing, visible, hiding }

class MoonTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final ValueNotifier<TooltipPhase> phase;

  MoonTooltip({
    required this.child,
    required this.message,
  }) : phase = ValueNotifier(TooltipPhase.hidden);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => phase.value = TooltipPhase.visible,
      onExit: (_) => phase.value = TooltipPhase.hidden,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            top: -30,
            child: Box(
              style: $tooltip.bubble.phaseAnimation(
                trigger: phase,
                phases: TooltipPhase.values,
                styleBuilder: (p, s) => switch(p) {
                  TooltipPhase.hidden => s.scale(0.8).opacity(0),
                  TooltipPhase.showing => s.scale(1).opacity(1),
                  TooltipPhase.visible => s.scale(1).opacity(1),
                  TooltipPhase.hiding => s.scale(0.95).opacity(0),
                },
                configBuilder: (p) => switch(p) {
                  TooltipPhase.showing => AnimationConfig.spring(150.ms),
                  TooltipPhase.hiding => AnimationConfig.easeIn(100.ms),
                  _ => AnimationConfig.instant(),
                },
              ),
              child: StyledText(message, style: $tooltip.text),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 6. MoonChip - 12 Lines
```dart
class MoonChip extends StatelessWidget {
  final Widget label;
  final VoidCallback? onTap;
  final bool selected;

  const MoonChip({
    required this.label,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
      style: $chip.container(selected),
      child: label,
    );
  }
}
```

### 7. MoonRadio - 15 Lines
```dart
class MoonRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  const MoonRadio({
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return PressableBox(
      onPress: onChanged != null ? () => onChanged!(value) : null,
      style: $radio.outer(selected),
      child: Box(style: $radio.inner(selected)),
    );
  }
}
```

### 8. MoonDropdown - Using Keyframes
```dart
class MoonDropdown extends StatelessWidget {
  final List<Widget> items;
  final Widget child;
  final ValueNotifier<bool> isOpen;

  MoonDropdown({
    required this.items,
    required this.child,
  }) : isOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ColumnBox(
      style: $flex.start,
      children: [
        PressableBox(
          onPress: () => isOpen.value = !isOpen.value,
          style: $dropdown.trigger,
          child: RowBox(
            style: $flex.spaceBetween,
            children: [
              child,
              ValueListenableBuilder<bool>(
                valueListenable: isOpen,
                builder: (_, open, __) =>
                  StyledIcon(style: $dropdown.arrow(open)),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isOpen,
          builder: (_, open, __) => open
            ? Box(
                style: $dropdown.panel.keyframeAnimation(
                  trigger: isOpen,
                  timeline: [
                    KeyframeTrack<double>('scaleY', [
                      Keyframe.linear(0, 0.ms),
                      Keyframe.spring(1, 250.ms),
                    ]),
                    KeyframeTrack<double>('opacity', [
                      Keyframe.linear(0, 0.ms),
                      Keyframe.easeIn(1, 150.ms),
                    ]),
                  ],
                  styleBuilder: (v, s) => s
                    .scaleY(v.get('scaleY'))
                    .opacity(v.get('opacity')),
                ),
                child: ColumnBox(
                  style: $flex.start,
                  children: items,
                ),
              )
            : SizedBox.shrink(),
        ),
      ],
    );
  }
}
```

---

## Style System Architecture

### Central Style Definitions
```dart
// lib/src/styles/moon_styles.dart

// Button Styles
class ButtonStyles {
  BoxMix get base => BoxStyler()
    .padding(EdgeInsets.symmetric(horizontal: 16, vertical: 8))
    .borderRounded(8)
    .color(Colors.blue)
    .onHovered(
      $box.color(Colors.blue.shade600)
        .animate(AnimationConfig.easeInOut(150.ms))
    )
    .onPressed(
      $box.scale(0.95)
        .animate(AnimationConfig.easeOut(100.ms))
    )
    .onDisabled(
      $box.opacity(0.5).color(Colors.grey)
    );
}

// Switch Styles
class SwitchStyles {
  BoxMix track(bool isOn) => BoxStyler()
    .size(44, 24)
    .borderRounded(12)
    .color(isOn ? Colors.blue : Colors.grey.shade300)
    .animate(AnimationConfig.spring(200.ms));

  BoxMix thumb(bool isOn) => BoxStyler()
    .size(20, 20)
    .borderRounded(10)
    .color(Colors.white)
    .translate(isOn ? 22 : 2, 0)
    .shadowOnly(color: Colors.black12, blurRadius: 2)
    .animate(AnimationConfig.spring(200.ms, bounce: 0.15));
}

// Checkbox Styles
class CheckboxStyles {
  BoxMix container(bool? checked) => BoxStyler()
    .size(20, 20)
    .borderRounded(4)
    .borderAll(color: checked == true ? Colors.blue : Colors.grey)
    .color(checked == true ? Colors.blue : Colors.transparent)
    .animate(AnimationConfig.spring(200.ms))
    .onHovered($box.borderAll(color: Colors.blue.shade300))
    .onPressed($box.scale(0.9));

  IconMix check(bool? checked) => IconStyler()
    .icon(checked == null ? Icons.remove : Icons.check)
    .size(16)
    .color(Colors.white)
    .scale(checked != false ? 1 : 0)
    .animate(AnimationConfig.spring(250.ms, bounce: 0.3));
}

// Accordion Styles
class AccordionStyles {
  BoxMix get container => $box.borderRounded(8);

  BoxMix get header => $box
    .padding(EdgeInsets.all(16))
    .onHovered($box.color(Colors.grey.shade50));

  IconMix icon(bool expanded) => IconStyler()
    .icon(Icons.chevron_right)
    .rotate(expanded ? 90 : 0)
    .animate(AnimationConfig.spring(200.ms));

  BoxMix content(bool expanded) => BoxStyler()
    .clipBehavior(Clip.hardEdge)
    .maxHeight(expanded ? 1000 : 0)
    .opacity(expanded ? 1 : 0)
    .animate(AnimationConfig.easeInOut(300.ms));
}

// Chip Styles
class ChipStyles {
  BoxMix container(bool selected) => BoxStyler()
    .padding(EdgeInsets.symmetric(horizontal: 12, vertical: 6))
    .borderRounded(16)
    .borderAll(color: selected ? Colors.blue : Colors.grey.shade300)
    .color(selected ? Colors.blue.shade50 : Colors.white)
    .animate(AnimationConfig.spring(200.ms))
    .onHovered($box.color(Colors.grey.shade50))
    .onPressed($box.scale(0.95));
}

// Radio Styles
class RadioStyles {
  BoxMix outer(bool selected) => BoxStyler()
    .size(20, 20)
    .borderRounded(10)
    .borderAll(
      color: selected ? Colors.blue : Colors.grey,
      width: 2,
    )
    .animate(AnimationConfig.spring(200.ms));

  BoxMix inner(bool selected) => BoxStyler()
    .size(10, 10)
    .borderRounded(5)
    .color(Colors.blue)
    .scale(selected ? 1 : 0)
    .animate(AnimationConfig.spring(250.ms, bounce: 0.3));
}

// Dropdown Styles
class DropdownStyles {
  BoxMix get trigger => $box
    .padding(EdgeInsets.all(12))
    .borderRounded(8)
    .borderAll(color: Colors.grey.shade300)
    .onHovered($box.borderAll(color: Colors.blue.shade300));

  IconMix arrow(bool open) => IconStyler()
    .icon(Icons.arrow_drop_down)
    .rotate(open ? 180 : 0)
    .animate(AnimationConfig.spring(200.ms));

  BoxMix get panel => BoxStyler()
    .marginTop(4)
    .padding(EdgeInsets.symmetric(vertical: 8))
    .borderRounded(8)
    .color(Colors.white)
    .shadowOnly(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: Offset(0, 4),
    );
}

// Tooltip Styles
class TooltipStyles {
  BoxMix get bubble => BoxStyler()
    .padding(EdgeInsets.symmetric(horizontal: 8, vertical: 4))
    .borderRounded(4)
    .color(Colors.grey.shade800);

  TextMix get text => TextStyler()
    .fontSize(12)
    .color(Colors.white);
}

// Global style instances
final $button = ButtonStyles();
final $switch = SwitchStyles();
final $checkbox = CheckboxStyles();
final $accordion = AccordionStyles();
final $chip = ChipStyles();
final $radio = RadioStyles();
final $dropdown = DropdownStyles();
final $tooltip = TooltipStyles();

// Common flex styles
class FlexStyles {
  FlexBoxMix get spaceBetween => FlexBoxStyler()
    .mainAxisAlignment(MainAxisAlignment.spaceBetween)
    .crossAxisAlignment(CrossAxisAlignment.center);

  FlexBoxMix get start => FlexBoxStyler()
    .mainAxisAlignment(MainAxisAlignment.start)
    .crossAxisAlignment(CrossAxisAlignment.start);

  FlexBoxMix get center => FlexBoxStyler()
    .mainAxisAlignment(MainAxisAlignment.center)
    .crossAxisAlignment(CrossAxisAlignment.center);
}

final $flex = FlexStyles();

// Global box shorthand
final $box = BoxStyler();
```

### Animation Presets
```dart
// lib/src/styles/moon_animations.dart

class MoonAnimations {
  // Micro interactions
  static const hover = AnimationConfig.easeInOut(150.ms);
  static const press = AnimationConfig.easeOut(100.ms);
  static const focus = AnimationConfig.easeInOut(200.ms);

  // Standard transitions
  static const quick = AnimationConfig.easeInOut(150.ms);
  static const normal = AnimationConfig.easeInOut(250.ms);
  static const slow = AnimationConfig.easeInOut(350.ms);

  // Spring presets
  static const springSnappy = AnimationConfig.spring(200.ms, bounce: 0.15);
  static const springBouncy = AnimationConfig.spring(300.ms, bounce: 0.3);
  static const springSmooth = AnimationConfig.spring(250.ms, bounce: 0.1);

  // Overlay animations
  static const overlayIn = AnimationConfig.spring(200.ms, bounce: 0.1);
  static const overlayOut = AnimationConfig.easeIn(150.ms);

  // State changes
  static const stateChange = AnimationConfig.spring(200.ms, bounce: 0.15);
  static const selection = AnimationConfig.spring(250.ms, bounce: 0.2);
}
```

### Theme Integration
```dart
// lib/src/styles/moon_theme.dart

class MoonTheme extends InheritedWidget {
  final MoonThemeData data;

  static MoonThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MoonTheme>()?.data
      ?? MoonThemeData.light();
  }
}

class MoonThemeData {
  final ColorTokens colors;
  final SpaceTokens spaces;
  final RadiusTokens radii;

  // Use Mix tokens directly
  factory MoonThemeData.light() => MoonThemeData(
    colors: {
      $primary: Colors.blue,
      $secondary: Colors.grey,
      $error: Colors.red,
    },
    spaces: {
      $small: 4.0,
      $medium: 8.0,
      $large: 16.0,
    },
    radii: {
      $small: Radius.circular(4),
      $medium: Radius.circular(8),
      $large: Radius.circular(16),
    },
  );
}

// Design tokens
final $primary = ColorToken('primary');
final $secondary = ColorToken('secondary');
final $error = ColorToken('error');
final $small = SpaceToken('small');
final $medium = SpaceToken('medium');
final $large = SpaceToken('large');
```

---

## Implementation Strategy

### Phase 1: Core Setup (Day 1-2)
```bash
# 1. Delete all base classes
rm lib/src/widgets/common/base_*

# 2. Create new style system
mkdir lib/src/styles
touch lib/src/styles/moon_styles.dart
touch lib/src/styles/moon_animations.dart
touch lib/src/styles/moon_theme.dart

# 3. Update exports
echo "export 'src/styles/moon_styles.dart';" >> lib/moon_core.dart
```

### Phase 2: Widget Migration (Day 3-7)

#### Priority Order:
1. **MoonButton** - Simplest, good proof of concept
2. **MoonSwitch** - Biggest code reduction win
3. **MoonCheckbox/Radio** - Similar patterns
4. **MoonChip** - Simple interactive widget
5. **MoonAccordion** - Tests animation patterns
6. **MoonTooltip/Popover** - Tests overlay patterns
7. **MoonDropdown** - Complex with keyframes
8. **Everything else** - Apply learned patterns

### Phase 3: Delete Legacy Code (Day 8)
```bash
# Remove all StatefulWidget implementations
# Remove all AnimationController code
# Remove all manual paint code
# Remove all controller classes
```

### Migration Checklist

#### For Each Widget:
- [ ] Delete the old implementation completely
- [ ] Write new implementation (10-30 lines max)
- [ ] Move styles to centralized style file
- [ ] Use only Mix primitives
- [ ] Add reactive animations
- [ ] Test all interaction states
- [ ] Delete the test file (write new ones)

#### Global Tasks:
- [ ] Delete ALL base widget classes
- [ ] Delete ALL animation controllers
- [ ] Delete ALL custom painters
- [ ] Create centralized style system
- [ ] Create animation presets
- [ ] Setup theme integration
- [ ] Update all exports
- [ ] Rewrite all tests from scratch
- [ ] Update example app

---

## Code Style Rules

### 1. Widget Rules
- **MAX 30 lines per widget**
- **NO StatefulWidget** (except if absolutely necessary)
- **NO manual controllers**
- **NO inheritance** (composition only)
- **NO custom paint**

### 2. Style Rules
- **Centralized styles** in `/styles` folder
- **Reusable style functions**
- **Use style composition**
- **Leverage all Mix variants**
- **Animate everything**

### 3. State Management
- **ValueNotifier for local state**
- **Mix variants for UI state**
- **No setState if possible**
- **Reactive patterns only**

### Example of Final Widget:
```dart
// THIS IS THE ENTIRE FILE
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import '../styles/moon_styles.dart';

class MoonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;

  const MoonButton({
    this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onPressed,
      style: $button.style(variant),
      child: child,
    );
  }
}
```

---

## Expected Results

### Before vs After

| Metric | Before | After | Reduction |
|--------|--------|-------|-----------|
| **MoonSwitch** | 200+ lines | 20 lines | 90% |
| **MoonAccordion** | 150 lines | 25 lines | 83% |
| **MoonCheckbox** | 100 lines | 15 lines | 85% |
| **MoonButton** | 80 lines | 10 lines | 87% |
| **Base Classes** | 500+ lines | 0 lines | 100% |
| **Total Codebase** | ~5000 lines | ~1000 lines | 80% |

### Performance Gains
- **Zero AnimationController overhead**
- **Optimized Mix animation engine**
- **Fewer rebuilds with reactive patterns**
- **Better tree shaking**

### Developer Experience
- **10x faster to add new widgets**
- **Consistent patterns everywhere**
- **Trivial to modify animations**
- **Style changes in one place**

---

## Common Patterns Reference

### Pattern 1: Toggle Widget
```dart
class MoonToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onChanged != null ? () => onChanged!(!value) : null,
      style: $toggle.style(value),
      child: Box(style: $toggle.indicator(value)),
    );
  }
}
```

### Pattern 2: Selection Widget
```dart
class MoonSelect<T> extends StatelessWidget {
  final T value;
  final T? selected;
  final ValueChanged<T>? onSelect;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => onSelect?.call(value),
      style: $select.style(value == selected),
      child: child,
    );
  }
}
```

### Pattern 3: Overlay Widget
```dart
class MoonOverlay extends StatelessWidget {
  final Widget child;
  final Widget overlay;
  final ValueNotifier<bool> show;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ValueListenableBuilder<bool>(
          valueListenable: show,
          builder: (_, visible, __) => visible
            ? Box(
                style: $overlay.style
                  .animate(MoonAnimations.overlayIn),
                child: overlay,
              )
            : SizedBox.shrink(),
        ),
      ],
    );
  }
}
```

### Pattern 4: Animated List Item
```dart
class MoonListItem extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
      style: $list.item(selected)
        .animate(MoonAnimations.stateChange),
      child: child,
    );
  }
}
```

---

## Final Notes

This approach is **radical** but will result in:
1. **Massively simpler codebase**
2. **Better performance**
3. **Easier maintenance**
4. **Consistent patterns**
5. **Modern reactive architecture**

The key is to **fully embrace Mix v2** and delete anything that doesn't align with its patterns. No compromises.