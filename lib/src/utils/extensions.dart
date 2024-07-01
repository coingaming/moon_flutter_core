import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_widget_modifier.dart';

extension IconThemeDataX on IconThemeData {
  bool get hasAValue =>
      color != null ||
      size != null ||
      shadows != null ||
      fill != null ||
      weight != null ||
      grade != null ||
      opticalSize != null ||
      applyTextScaling != null;
}

extension TextStyleX on TextStyle {
  bool get hasAValue =>
      background != null ||
      backgroundColor != null ||
      color != null ||
      debugLabel != null ||
      decoration != null ||
      decorationColor != null ||
      decorationStyle != null ||
      decorationThickness != null ||
      fontFamily != null ||
      fontFamilyFallback != null ||
      fontFeatures != null ||
      fontSize != null ||
      fontStyle != null ||
      fontVariations != null ||
      fontWeight != null ||
      foreground != null ||
      height != null ||
      leadingDistribution != null ||
      letterSpacing != null ||
      locale != null ||
      overflow != null ||
      shadows != null ||
      textBaseline != null ||
      wordSpacing != null;
}

extension WithModifierUtilityX on WithModifierUtility {
  static final _textExpando = Expando<DefaultTextStyleWidgetUtility>();
  static final _iconExpando = Expando<IconThemeWidgetUtility>();

  DefaultTextStyleWidgetUtility get defaultTextStyle => _textExpando[this] ??=
      DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);

  IconThemeWidgetUtility get iconTheme =>
      _iconExpando[this] ??= IconThemeWidgetUtility(MixUtility.selfBuilder);
}
