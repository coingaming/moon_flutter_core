import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'default_text_style_modifier.g.dart';

/// A modifier that wraps a widget with the [DefaultTextStyle] widget.
@MixableSpec()
final class DefaultTextStyleModifierSpec
    extends WidgetModifierSpec<DefaultTextStyleModifierSpec>
    with _$DefaultTextStyleModifierSpec {
  final TextStyle? style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;

  @MixableProperty(dto: MixableFieldDto(type: TextHeightBehaviorDto))
  final TextHeightBehavior? textHeightBehavior;

  const DefaultTextStyleModifierSpec({
    this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textHeightBehavior,
    this.textWidthBasis,
  });

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
