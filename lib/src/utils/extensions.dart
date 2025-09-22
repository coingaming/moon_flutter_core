import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/animated_opacity_modifier.dart';
import 'package:moon_core/src/mix/modifiers/animated_shape_decoration_modifier.dart';
import 'package:moon_core/src/mix/modifiers/default_text_style_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_modifier.dart';

extension MoonWidgetModifierUtilityX<T extends Style<Object?>>
    on WidgetModifierUtility<T> {
  AnimatedOpacityModifierUtility<T> get animatedOpacity =>
      AnimatedOpacityModifierUtility<T>(utilityBuilder);

  AnimatedShapeDecorationModifierUtility<T> get animatedShapeDecoration =>
      AnimatedShapeDecorationModifierUtility<T>(utilityBuilder);

  DefaultTextStyleModifierUtility<T> get defaultTextStyle =>
      DefaultTextStyleModifierUtility<T>(utilityBuilder);

  IconThemeModifierUtility<T> get iconTheme =>
      IconThemeModifierUtility<T>(utilityBuilder);
}
