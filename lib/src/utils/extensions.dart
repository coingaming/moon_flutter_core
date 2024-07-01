import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/modifiers/default_text_style_widget_modifier.dart';
import 'package:moon_core/src/mix/modifiers/icon_theme_widget_modifier.dart';

extension WithModifierUtilityX on WithModifierUtility {
  static final _textExpando = Expando<DefaultTextStyleWidgetUtility>();
  static final _iconExpando = Expando<IconThemeWidgetUtility>();

  DefaultTextStyleWidgetUtility get defaultTextStyle => _textExpando[this] ??=
      DefaultTextStyleWidgetUtility(MixUtility.selfBuilder);

  IconThemeWidgetUtility get iconTheme =>
      _iconExpando[this] ??= IconThemeWidgetUtility(MixUtility.selfBuilder);
}
