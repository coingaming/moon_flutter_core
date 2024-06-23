import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/src/mix/attributes/icon_theme_data/icon_theme_data_dto.dart';

part 'base_layout_spec.g.dart';

@MixableSpec()
final class BaseLayoutSpec extends Spec<BaseLayoutSpec> with _$BaseLayoutSpec {
  static const of = _$BaseLayoutSpec.of;
  static const from = _$BaseLayoutSpec.from;

  final double? horizontalGap;
  final double? verticalGap;

  @MixableProperty(dto: MixableFieldDto(type: IconThemeDataDto))
  final IconThemeData? leadingIconThemeData;
  @MixableProperty(dto: MixableFieldDto(type: IconThemeDataDto))
  final IconThemeData? labelIconThemeData;
  @MixableProperty(dto: MixableFieldDto(type: IconThemeDataDto))
  final IconThemeData? trailingIconThemeData;
  @MixableProperty(dto: MixableFieldDto(type: IconThemeDataDto))
  final IconThemeData? contentIconThemeData;

  @MixableProperty(dto: MixableFieldDto(type: TextStyleDto))
  final TextStyle? leadingTextStyle;
  @MixableProperty(dto: MixableFieldDto(type: TextStyleDto))
  final TextStyle? labelTextStyle;
  @MixableProperty(dto: MixableFieldDto(type: TextStyleDto))
  final TextStyle? trailingTextStyle;
  @MixableProperty(dto: MixableFieldDto(type: TextStyleDto))
  final TextStyle? contentTextStyle;

  const BaseLayoutSpec({
    super.animated,
    this.horizontalGap,
    this.verticalGap,
    this.leadingIconThemeData,
    this.labelIconThemeData,
    this.trailingIconThemeData,
    this.contentIconThemeData,
    this.leadingTextStyle,
    this.labelTextStyle,
    this.trailingTextStyle,
    this.contentTextStyle,
  });
}
