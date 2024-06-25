import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/widget_modifiers.dart';
import 'package:moon_core/src/utils/extensions.dart';

final _wrapper = DefaultModifierUtility.self;

class IconThemeAndDefaultTextStyleWidget extends StatelessWidget {
  // Animation only works if inherit is true
  final bool inherit;
  final IconThemeData? iconThemeData;
  final TextStyle? defaultTextStyle;
  final Widget child;

  const IconThemeAndDefaultTextStyleWidget({
    this.inherit = true,
    this.iconThemeData,
    this.defaultTextStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final iconSpec = IconSpec.of(context);

    final inheritedIconTheme = IconThemeData(
      applyTextScaling: iconSpec.applyTextScaling,
      color: iconSpec.color,
      fill: iconSpec.fill,
      grade: iconSpec.grade,
      opticalSize: iconSpec.opticalSize,
      shadows: iconSpec.shadows,
      size: iconSpec.size,
      weight: iconSpec.weight,
    );

    final resolvedIconTheme = inheritedIconTheme.merge(iconThemeData);

    final textSpec = TextSpec.of(context);

    final inheritedTextStyle = TextStyle(
      background: textSpec.style?.background,
      backgroundColor: textSpec.style?.backgroundColor,
      color: textSpec.style?.color,
      debugLabel: textSpec.style?.debugLabel,
      decoration: textSpec.style?.decoration,
      decorationColor: textSpec.style?.decorationColor,
      decorationStyle: textSpec.style?.decorationStyle,
      decorationThickness: textSpec.style?.decorationThickness,
      fontFamily: textSpec.style?.fontFamily,
      fontFamilyFallback: textSpec.style?.fontFamilyFallback,
      fontFeatures: textSpec.style?.fontFeatures,
      fontSize: textSpec.style?.fontSize,
      fontStyle: textSpec.style?.fontStyle,
      fontVariations: textSpec.style?.fontVariations,
      fontWeight: textSpec.style?.fontWeight,
      foreground: textSpec.style?.foreground,
      height: textSpec.style?.height,
      leadingDistribution: textSpec.style?.leadingDistribution,
      letterSpacing: textSpec.style?.letterSpacing,
      locale: textSpec.style?.locale,
      overflow: textSpec.style?.overflow,
      shadows: textSpec.style?.shadows,
      textBaseline: textSpec.style?.textBaseline,
      wordSpacing: textSpec.style?.wordSpacing,
    );

    final resolvedTextStyle = inheritedTextStyle.merge(defaultTextStyle);

    return SpecBuilder(
      inherit: inherit,
      style: Style(
        resolvedIconTheme.hasAValue
            ? _wrapper.iconTheme(
                data: resolvedIconTheme,
              )
            : null,
        resolvedTextStyle.hasAValue
            ? _wrapper.defaultTextStyle(
                style: defaultTextStyle!,
                // FIXME: add missing properties
              )
            : null,
      ),
      builder: (context) {
        return child;
      },
    );
  }
}
