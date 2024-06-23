import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_widget_modifier.dart';

extension WithModifierUtilityX on WithModifierUtility {
  static final $defaultTextStyle =
      DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);
  static final $iconTheme = IconThemeWidgetUtility(MixUtility.selfBuilder);
}
