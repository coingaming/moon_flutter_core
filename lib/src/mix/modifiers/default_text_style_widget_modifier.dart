import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// A modifier that wraps a widget with the [DefaultTextStyle] widget.
final class DefaultTextStyleModifierSpec
    extends WidgetModifierSpec<DefaultTextStyleModifierSpec> {
  final TextStyle textStyle;

  const DefaultTextStyleModifierSpec(this.textStyle);

  @override
  DefaultTextStyleModifierSpec lerp(
    DefaultTextStyleModifierSpec? other,
    double t,
  ) {
    return DefaultTextStyleModifierSpec(
      TextStyle.lerp(textStyle, other?.textStyle, t) ?? textStyle,
    );
  }

  @override
  DefaultTextStyleModifierSpec copyWith({TextStyle? textStyle}) {
    return DefaultTextStyleModifierSpec(textStyle ?? this.textStyle);
  }

  @override
  List<TextStyle> get props => [textStyle];

  @override
  Widget build(Widget child) {
    return DefaultTextStyle(
      style: textStyle,
      child: child,
    );
  }
}

final class DefaultTextStyleModifierAttribute extends WidgetModifierAttribute<
    DefaultTextStyleModifierAttribute, DefaultTextStyleModifierSpec> {
  final TextStyleDto textStyle;

  const DefaultTextStyleModifierAttribute(this.textStyle);

  @override
  DefaultTextStyleModifierAttribute merge(
    DefaultTextStyleModifierAttribute? other,
  ) {
    return DefaultTextStyleModifierAttribute(other?.textStyle ?? textStyle);
  }

  @override
  DefaultTextStyleModifierSpec resolve(MixData mix) {
    return DefaultTextStyleModifierSpec(textStyle.resolve(mix));
  }

  @override
  List<TextStyleDto> get props => [textStyle];
}

final class DefaultTextStyleWidgetUtility<T extends Attribute>
    extends MixUtility<T, DefaultTextStyleModifierAttribute> {
  DefaultTextStyleWidgetUtility(super.builder);

  T call(TextStyleDto textStyle) =>
      builder(DefaultTextStyleModifierAttribute(textStyle));

  late final style = TextStyleUtility((textStyleDto) => call(textStyleDto));
}
