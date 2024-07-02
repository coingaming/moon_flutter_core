import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_widget_modifier.dart';

extension WithModifierUtilityX on WithModifierUtility {
  DefaultTextStyleWidgetUtility get defaultTextStyle =>
      DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);

  IconThemeWidgetUtility get iconTheme =>
      IconThemeWidgetUtility(MixUtility.selfBuilder);
}
