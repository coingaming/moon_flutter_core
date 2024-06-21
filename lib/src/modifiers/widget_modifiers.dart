import 'package:mix/mix.dart';
import 'package:moon_core/src/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/modifiers/icon_theme_widget_modifier.dart';

class DefaultModifierUtility {
  late final text = DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);
  late final icon = IconThemeWidgetUtility(MixUtility.selfBuilder);

  static final self = DefaultModifierUtility._();

  DefaultModifierUtility._();
}
