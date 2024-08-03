import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_modifier.dart';

extension WithModifierUtilityX on WithModifierUtility {
  DefaultTextStyleModifierSpecUtility get defaultTextStyle =>
      DefaultTextStyleModifierSpecUtility(MixUtility.selfBuilder);

  IconThemeModifierSpecUtility get iconTheme =>
      IconThemeModifierSpecUtility(MixUtility.selfBuilder);
}

extension SpecModifierUtilityX on SpecModifierUtility {
  DefaultTextStyleModifierSpecUtility get defaultTextStyle =>
      DefaultTextStyleModifierSpecUtility(MixUtility.selfBuilder);

  IconThemeModifierSpecUtility get iconTheme =>
      IconThemeModifierSpecUtility(MixUtility.selfBuilder);
}
