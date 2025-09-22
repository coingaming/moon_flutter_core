import 'package:mix/mix.dart'
    hide DefaultTextStyleModifierUtility, IconThemeModifierUtility;

import 'package:moon_core/src/mix/modifiers/animated_opacity_modifier.dart';
import 'package:moon_core/src/mix/modifiers/animated_shape_decoration_modifier.dart';
import 'package:moon_core/src/mix/modifiers/default_text_style_modifier.dart'
    as moon;
import 'package:moon_core/src/mix/modifiers/icon_theme_modifier.dart' as moon;

extension MoonWidgetModifierUtilityX<T extends Style<Object?>>
    on WidgetModifierUtility<T> {
  AnimatedOpacityModifierUtility<T> get animatedOpacity =>
      AnimatedOpacityModifierUtility<T>(utilityBuilder);

  AnimatedShapeDecorationModifierUtility<T> get animatedShapeDecoration =>
      AnimatedShapeDecorationModifierUtility<T>(utilityBuilder);

  moon.DefaultTextStyleModifierUtility<T> get defaultTextStyle =>
      moon.DefaultTextStyleModifierUtility<T>(utilityBuilder);

  moon.IconThemeModifierUtility<T> get iconTheme =>
      moon.IconThemeModifierUtility<T>(utilityBuilder);
}
