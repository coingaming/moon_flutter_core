import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/src/mix/attributes/icon_theme_data_dto.dart';

part 'icon_theme_modifier.g.dart';

/// A modifier that wraps a widget with the [IconTheme] widget.
@MixableSpec()
final class IconThemeModifierSpec
    extends WidgetModifierSpec<IconThemeModifierSpec>
    with _$IconThemeModifierSpec {
  final IconThemeData? data;

  const IconThemeModifierSpec({this.data});

  @override
  Widget build(Widget child) {
    return IconTheme(
      data: data ?? const IconThemeData(),
      child: child,
    );
  }
}
