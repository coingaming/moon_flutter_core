import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Moon Design dot indicator - supports both simple props and Mix styling
class MoonDotIndicator extends StatelessWidget {
  /// The index of the currently selected dot.
  final int selectedIndex;

  /// The total number of dots to display.
  final int count;

  /// The color of the selected dot (simple API).
  final Color? selectedColor;

  /// The color of unselected dots (simple API).
  final Color? unselectedColor;

  /// The size of the dots (simple API).
  final double? dotSize;

  /// The spacing between dots (simple API).
  final double? spacing;

  /// The duration of the dot transition animation (simple API).
  final Duration? transitionDuration;

  /// The curve of the dot transition animation (simple API).
  final Curve? transitionCurve;

  /// Callback when a dot is tapped (makes dots interactive).
  final ValueChanged<int>? onDotTap;

  /// Custom style for selected dots (advanced Mix API).
  final BoxMix? selectedDotStyle;

  /// Custom style for unselected dots (advanced Mix API).
  final BoxMix? unselectedDotStyle;

  /// Custom style for the container (advanced Mix API).
  final FlexBoxMix? containerStyle;

  const MoonDotIndicator({
    super.key,
    required this.selectedIndex,
    required this.count,
    this.selectedColor,
    this.unselectedColor,
    this.dotSize,
    this.spacing,
    this.transitionDuration,
    this.transitionCurve,
    this.onDotTap,
    this.selectedDotStyle,
    this.unselectedDotStyle,
    this.containerStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RowBox(
      style: containerStyle ?? _getContainerStyle(),
      children: List.generate(
        count,
        (index) => onDotTap != null
            ? PressableBox(
                onPress: () => onDotTap!(index),
                style: _getDotStyle(index == selectedIndex),
                child: const SizedBox.shrink(),
              )
            : Box(
                style: _getDotStyle(index == selectedIndex),
              ),
      ),
    );
  }

  FlexBoxMix _getContainerStyle() {
    return FlexBoxStyler()
        .spacing(spacing ?? 8)
        .mainAxisAlignment(MainAxisAlignment.center)
        .crossAxisAlignment(CrossAxisAlignment.center);
  }

  BoxMix _getDotStyle(bool isSelected) {
    // If custom Mix styles provided, use them
    if (isSelected && selectedDotStyle != null) {
      return selectedDotStyle!;
    }
    if (!isSelected && unselectedDotStyle != null) {
      return unselectedDotStyle!;
    }

    // Otherwise build from simple props
    final size = dotSize ?? 8;
    final duration = transitionDuration ?? const Duration(milliseconds: 200);
    final curve = transitionCurve ?? Curves.easeInOut;

    var style = BoxStyler()
        .size(size, size)
        .borderRounded(size / 2)
        .animate(AnimationConfig.curve(duration: duration, curve: curve));

    if (isSelected) {
      style = style.color(selectedColor ?? Colors.blue);
    } else {
      style = style.color(unselectedColor ?? Colors.grey.shade400);
    }

    // Add interaction states if interactive
    if (onDotTap != null) {
      style = style
          .onHovered(
            BoxStyler()
                .scale(1.2)
                .animate(AnimationConfig.easeInOut(150.ms)),
          )
          .onPressed(
            BoxStyler()
                .scale(0.8)
                .animate(AnimationConfig.easeOut(100.ms)),
          );
    }

    return style;
  }
}

/// Builder type for custom dot widgets
typedef MoonDotBuilder = Widget Function(int index, bool isSelected);

/// Raw dot indicator for maximum customization
class MoonRawDotIndicator extends StatelessWidget {
  /// The index of the currently selected dot.
  final int selectedIndex;

  /// The total number of dots.
  final int count;

  /// Builder for custom dot widgets.
  final MoonDotBuilder dotBuilder;

  /// Spacing between dots.
  final double spacing;

  /// Container alignment.
  final MainAxisAlignment mainAxisAlignment;

  /// Custom container style (overrides other container props).
  final FlexBoxMix? containerStyle;

  const MoonRawDotIndicator({
    super.key,
    required this.selectedIndex,
    required this.count,
    required this.dotBuilder,
    this.spacing = 8,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.containerStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RowBox(
      style: containerStyle ??
          FlexBoxStyler()
              .spacing(spacing)
              .mainAxisAlignment(mainAxisAlignment)
              .crossAxisAlignment(CrossAxisAlignment.center),
      children: List.generate(
        count,
        (index) => dotBuilder(index, index == selectedIndex),
      ),
    );
  }
}

/// Advanced animated dot indicator with distance effects
class MoonAnimatedDotIndicator extends StatelessWidget {
  final int selectedIndex;
  final int count;

  // Simple API props
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? nearbyColor;
  final double? selectedSize;
  final double? unselectedSize;
  final double? nearbySize;
  final double? spacing;
  final Duration? transitionDuration;

  // Advanced features
  final ValueChanged<int>? onDotTap;
  final bool showScale;
  final bool showColorTransition;

  // Mix API overrides
  final BoxMix? customDotStyle;
  final FlexBoxMix? containerStyle;

  const MoonAnimatedDotIndicator({
    super.key,
    required this.selectedIndex,
    required this.count,
    this.selectedColor,
    this.unselectedColor,
    this.nearbyColor,
    this.selectedSize,
    this.unselectedSize,
    this.nearbySize,
    this.spacing,
    this.transitionDuration,
    this.onDotTap,
    this.showScale = true,
    this.showColorTransition = true,
    this.customDotStyle,
    this.containerStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RowBox(
      style: containerStyle ??
          FlexBoxStyler()
              .spacing(spacing ?? 8)
              .mainAxisAlignment(MainAxisAlignment.center)
              .crossAxisAlignment(CrossAxisAlignment.center),
      children: List.generate(
        count,
        (index) {
          final isSelected = index == selectedIndex;
          final distance = (index - selectedIndex).abs();

          return PressableBox(
            onPress: onDotTap != null ? () => onDotTap!(index) : null,
            style: customDotStyle ?? _getAnimatedDotStyle(isSelected, distance),
            child: const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  BoxMix _getAnimatedDotStyle(bool isSelected, int distance) {
    final duration = transitionDuration ?? const Duration(milliseconds: 250);

    // Base style
    var style = BoxStyler()
        .borderRounded(5)
        .animate(AnimationConfig.spring(duration, bounce: 0.2));

    // Size based on selection and distance
    if (isSelected) {
      style = style.size(selectedSize ?? 10, selectedSize ?? 10);
    } else if (distance == 1) {
      style = style.size(nearbySize ?? 8, nearbySize ?? 8);
    } else {
      style = style.size(unselectedSize ?? 6, unselectedSize ?? 6);
    }

    // Color based on selection and distance
    if (showColorTransition) {
      if (isSelected) {
        style = style.color(selectedColor ?? Colors.blue);
      } else if (distance == 1) {
        style = style.color(nearbyColor ?? Colors.blue.shade300);
      } else {
        style = style.color(unselectedColor ?? Colors.grey.shade400);
      }
    } else {
      style = style.color(
        isSelected
            ? (selectedColor ?? Colors.blue)
            : (unselectedColor ?? Colors.grey.shade400),
      );
    }

    // Scale animation for selection
    if (showScale && isSelected) {
      style = style.scale(1.1);
    }

    // Interactive states if clickable
    if (onDotTap != null) {
      style = style
          .onHovered(
            BoxStyler()
                .scale(1.2)
                .animate(AnimationConfig.easeInOut(150.ms)),
          )
          .onPressed(
            BoxStyler()
                .scale(0.8)
                .animate(AnimationConfig.easeOut(100.ms)),
          );
    }

    return style;
  }
}

/// Page indicator variant with elongated selected dot
class MoonPageIndicator extends StatelessWidget {
  final int selectedIndex;
  final int count;

  // Simple API props
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? selectedWidth;
  final double? dotSize;
  final double? spacing;
  final Duration? transitionDuration;

  // Interaction
  final ValueChanged<int>? onPageTap;

  // Mix API overrides
  final BoxMix? selectedStyle;
  final BoxMix? unselectedStyle;
  final FlexBoxMix? containerStyle;

  const MoonPageIndicator({
    super.key,
    required this.selectedIndex,
    required this.count,
    this.selectedColor,
    this.unselectedColor,
    this.selectedWidth,
    this.dotSize,
    this.spacing,
    this.transitionDuration,
    this.onPageTap,
    this.selectedStyle,
    this.unselectedStyle,
    this.containerStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RowBox(
      style: containerStyle ??
          FlexBoxStyler()
              .spacing(spacing ?? 8)
              .mainAxisAlignment(MainAxisAlignment.center)
              .crossAxisAlignment(CrossAxisAlignment.center),
      children: List.generate(
        count,
        (index) {
          final isSelected = index == selectedIndex;

          return PressableBox(
            onPress: onPageTap != null ? () => onPageTap!(index) : null,
            style: isSelected
                ? (selectedStyle ?? _getSelectedStyle())
                : (unselectedStyle ?? _getUnselectedStyle()),
            child: const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  BoxMix _getSelectedStyle() {
    final size = dotSize ?? 8;
    final width = selectedWidth ?? 24;
    final duration = transitionDuration ?? const Duration(milliseconds: 300);

    return BoxStyler()
        .width(width)
        .height(size)
        .borderRounded(size / 2)
        .color(selectedColor ?? Colors.blue)
        .animate(AnimationConfig.spring(duration, bounce: 0.15));
  }

  BoxMix _getUnselectedStyle() {
    final size = dotSize ?? 8;
    final duration = transitionDuration ?? const Duration(milliseconds: 300);

    return BoxStyler()
        .size(size, size)
        .borderRounded(size / 2)
        .color(unselectedColor ?? Colors.grey.shade400)
        .animate(AnimationConfig.spring(duration, bounce: 0.15));
  }
}

// Default dot indicator styles for advanced users
class DotIndicatorStyles {
  FlexBoxMix get container => FlexBoxStyler()
      .spacing(8)
      .mainAxisAlignment(MainAxisAlignment.center)
      .crossAxisAlignment(CrossAxisAlignment.center);

  BoxMix get unselectedDot => BoxStyler()
      .size(8, 8)
      .borderRounded(4)
      .color(Colors.grey.shade400)
      .animate(AnimationConfig.spring(200.ms, bounce: 0.2));

  BoxMix get selectedDot => BoxStyler()
      .size(8, 8)
      .borderRounded(4)
      .color(Colors.blue)
      .animate(AnimationConfig.spring(200.ms, bounce: 0.2));

  BoxMix interactiveDot(bool isSelected) => BoxStyler()
      .size(8, 8)
      .borderRounded(4)
      .color(isSelected ? Colors.blue : Colors.grey.shade400)
      .onHovered(
        BoxStyler()
            .scale(1.2)
            .animate(AnimationConfig.easeInOut(150.ms)),
      )
      .onPressed(
        BoxStyler()
            .scale(0.8)
            .animate(AnimationConfig.easeOut(100.ms)),
      )
      .animate(AnimationConfig.spring(200.ms, bounce: 0.2));
}

final $dotIndicator = DotIndicatorStyles();

// Page indicator specific styles for advanced users
class PageIndicatorStyles {
  BoxMix get unselected => BoxStyler()
      .size(8, 8)
      .borderRounded(4)
      .color(Colors.grey.shade400)
      .animate(AnimationConfig.spring(300.ms, bounce: 0.15));

  BoxMix get selected => BoxStyler()
      .width(24)
      .height(8)
      .borderRounded(4)
      .color(Colors.blue)
      .animate(AnimationConfig.spring(300.ms, bounce: 0.15));
}

final $pageIndicator = PageIndicatorStyles();