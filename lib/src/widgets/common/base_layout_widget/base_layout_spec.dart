import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'base_layout_spec.g.dart';

@MixableSpec()
final class BaseLayoutSpec extends Spec<BaseLayoutSpec> with _$BaseLayoutSpec {
  final double? horizontalGap;
  final double? verticalGap;
  final TextStyle? contentTextStyle;

  static const of = _$BaseLayoutSpec.of;

  static const from = _$BaseLayoutSpec.from;

  const BaseLayoutSpec({
    super.animated,
    this.horizontalGap,
    this.verticalGap,
    this.contentTextStyle,
  });
}
