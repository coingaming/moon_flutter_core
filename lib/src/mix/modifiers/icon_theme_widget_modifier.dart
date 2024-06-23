import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/attributes/icon_theme_data/icon_theme_data_dto.dart';

/// A modifier that wraps a widget with the [IconTheme] widget.
final class IconThemeModifierSpec
    extends WidgetModifierSpec<IconThemeModifierSpec> {
  final IconThemeData iconThemeData;

  const IconThemeModifierSpec(this.iconThemeData);

  @override
  IconThemeModifierSpec lerp(IconThemeModifierSpec? other, double t) {
    return IconThemeModifierSpec(
      IconThemeData.lerp(iconThemeData, other?.iconThemeData, t),
    );
  }

  @override
  IconThemeModifierSpec copyWith({IconThemeData? iconThemeData}) {
    return IconThemeModifierSpec(iconThemeData ?? this.iconThemeData);
  }

  @override
  List<IconThemeData> get props => [iconThemeData];

  @override
  Widget build(Widget child) {
    return IconTheme(data: iconThemeData, child: child);
  }
}

final class IconThemeModifierAttribute extends WidgetModifierAttribute<
    IconThemeModifierAttribute, IconThemeModifierSpec> {
  final IconThemeDataDto iconThemeData;

  const IconThemeModifierAttribute(this.iconThemeData);

  @override
  IconThemeModifierAttribute merge(IconThemeModifierAttribute? other) {
    return IconThemeModifierAttribute(
      other?.iconThemeData ?? iconThemeData,
    );
  }

  @override
  IconThemeModifierSpec resolve(MixData mix) {
    return IconThemeModifierSpec(iconThemeData.resolve(mix));
  }

  @override
  List<IconThemeDataDto> get props => [iconThemeData];
}

final class IconThemeWidgetUtility<T extends Attribute>
    extends MixUtility<T, IconThemeModifierAttribute> {
  IconThemeWidgetUtility(super.builder);

  T call(IconThemeDataDto iconThemeData) =>
      builder(IconThemeModifierAttribute(iconThemeData));

  late final themeData =
      IconThemeDataUtility((iconThemeDataDto) => call(iconThemeDataDto));
}
