import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// A modifier that wraps a widget with the [IconTheme] widget.
final class IconThemeModifierSpec
    extends WidgetModifierSpec<IconThemeModifierSpec> {
  final IconThemeData data;

  const IconThemeModifierSpec({required this.data});

  @override
  IconThemeModifierSpec lerp(IconThemeModifierSpec? other, double t) {
    return IconThemeModifierSpec(
      data: IconThemeData.lerp(data, other?.data, t),
    );
  }

  @override
  IconThemeModifierSpec copyWith({IconThemeData? data}) {
    return IconThemeModifierSpec(data: data ?? this.data);
  }

  @override
  List<IconThemeData> get props => [data];

  @override
  Widget build(Widget child) {
    return IconTheme(data: data, child: child);
  }
}

final class IconThemeModifierAttribute extends WidgetModifierAttribute<
    IconThemeModifierAttribute, IconThemeModifierSpec> {
  final IconThemeData data;

  const IconThemeModifierAttribute({required this.data});

  @override
  IconThemeModifierAttribute merge(IconThemeModifierAttribute? other) {
    return IconThemeModifierAttribute(
      data: other?.data ?? data,
    );
  }

  @override
  IconThemeModifierSpec resolve(MixData mix) {
    return IconThemeModifierSpec(data: data);
  }

  @override
  List<IconThemeData> get props => [data];
}

final class IconThemeWidgetUtility<T extends Attribute>
    extends MixUtility<T, IconThemeModifierAttribute> {
  IconThemeWidgetUtility(super.builder);

  T call({required IconThemeData data}) =>
      builder(IconThemeModifierAttribute(data: data));
}
