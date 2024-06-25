import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// A modifier that wraps a widget with the [DefaultTextStyle] widget.
final class DefaultTextStyleModifierSpec
    extends WidgetModifierSpec<DefaultTextStyleModifierSpec> {
  final TextStyle style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;

  const DefaultTextStyleModifierSpec({
    required this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textHeightBehavior,
    this.textWidthBasis,
  });

  @override
  DefaultTextStyleModifierSpec lerp(
    DefaultTextStyleModifierSpec? other,
    double t,
  ) {
    return DefaultTextStyleModifierSpec(
      style: MixHelpers.lerpTextStyle(style, other?.style, t)!,
      softWrap: t < 0.5 ? softWrap : other?.softWrap,
      maxLines: t < 0.5 ? maxLines : other?.maxLines,
      textAlign: t < 0.5 ? textAlign : other?.textAlign,
      overflow: t < 0.5 ? overflow : other?.overflow,
      textHeightBehavior:
          t < 0.5 ? textHeightBehavior : other?.textHeightBehavior,
      textWidthBasis: t < 0.5 ? textWidthBasis : other?.textWidthBasis,
    );
  }

  @override
  DefaultTextStyleModifierSpec copyWith({
    TextStyle? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextHeightBehavior? textHeightBehavior,
    TextWidthBasis? textWidthBasis,
  }) {
    return DefaultTextStyleModifierSpec(
      style: style ?? this.style,
      softWrap: softWrap ?? this.softWrap,
      maxLines: maxLines ?? this.maxLines,
      textAlign: textAlign ?? this.textAlign,
      overflow: overflow ?? this.overflow,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
    );
  }

  @override
  List<Object?> get props => [
        style,
        softWrap,
        maxLines,
        textAlign,
        overflow,
        textHeightBehavior,
        textWidthBasis,
      ];

  @override
  Widget build(Widget child) {
    return DefaultTextStyle.merge(
      style: style,
      softWrap: softWrap,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}

final class DefaultTextStyleModifierAttribute extends WidgetModifierAttribute<
    DefaultTextStyleModifierAttribute, DefaultTextStyleModifierSpec> {
  final TextStyle style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;

  const DefaultTextStyleModifierAttribute({
    required this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textHeightBehavior,
    this.textWidthBasis,
  });

  @override
  DefaultTextStyleModifierAttribute merge(
    DefaultTextStyleModifierAttribute? other,
  ) {
    if (other == null) return this;

    return DefaultTextStyleModifierAttribute(
      style: style.merge(other.style),
      softWrap: other.softWrap ?? softWrap,
      maxLines: other.maxLines ?? maxLines,
      textAlign: other.textAlign ?? textAlign,
      overflow: other.overflow ?? overflow,
      textHeightBehavior: other.textHeightBehavior ?? textHeightBehavior,
      textWidthBasis: other.textWidthBasis ?? textWidthBasis,
    );
  }

  @override
  DefaultTextStyleModifierSpec resolve(MixData mix) {
    return DefaultTextStyleModifierSpec(
      style: style,
      softWrap: softWrap,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
    );
  }

  @override
  List<Object?> get props => [
        style,
        softWrap,
        maxLines,
        textAlign,
        overflow,
        textHeightBehavior,
        textWidthBasis,
      ];
}

final class DefaultTextStyleWidgetUtility<T extends Attribute>
    extends MixUtility<T, DefaultTextStyleModifierAttribute> {
  DefaultTextStyleWidgetUtility(super.builder);

  T call({
    required TextStyle style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextHeightBehavior? textHeightBehavior,
    TextWidthBasis? textWidthBasis,
  }) =>
      builder(
        DefaultTextStyleModifierAttribute(
          style: style,
          softWrap: softWrap,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
        ),
      );
}
