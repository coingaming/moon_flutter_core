import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_widget_modifier.dart';

class DefaultModifierUtility {
  late final defaultTextStyle =
      DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);
  late final iconTheme = IconThemeWidgetUtility(MixUtility.selfBuilder);

  static final self = DefaultModifierUtility._();

  DefaultModifierUtility._();
}
