import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/animated_opacity_modifier.dart';
import 'package:moon_core/src/mix/modifiers/animated_shape_decoration_modifier.dart';
import 'package:moon_core/src/mix/modifiers/default_text_style_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_modifier.dart';

extension WithModifierUtilityX on WithModifierUtility {
  DefaultTextStyleModifierSpecUtility get defaultTextStyle =>
      DefaultTextStyleModifierSpecUtility(MixUtility.selfBuilder);

  IconThemeModifierSpecUtility get iconTheme =>
      IconThemeModifierSpecUtility(MixUtility.selfBuilder);

  AnimatedOpacityModifierSpecUtility get animatedOpacity =>
      const AnimatedOpacityModifierSpecUtility(MixUtility.selfBuilder);

  AnimatedShapeDecorationModifierSpecUtility get animatedShapeDecoration =>
      const AnimatedShapeDecorationModifierSpecUtility(MixUtility.selfBuilder);
}

extension SpecModifierUtilityX on SpecModifierUtility {
  DefaultTextStyleModifierSpecUtility get defaultTextStyle =>
      DefaultTextStyleModifierSpecUtility(MixUtility.selfBuilder);

  IconThemeModifierSpecUtility get iconTheme =>
      IconThemeModifierSpecUtility(MixUtility.selfBuilder);

  AnimatedOpacityModifierSpecUtility get animatedOpacity =>
      const AnimatedOpacityModifierSpecUtility(MixUtility.selfBuilder);

  AnimatedShapeDecorationModifierSpecUtility get animatedShapeDecoration =>
      const AnimatedShapeDecorationModifierSpecUtility(MixUtility.selfBuilder);
}
