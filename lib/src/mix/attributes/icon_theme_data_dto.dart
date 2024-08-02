import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'icon_theme_data_dto.g.dart';

@MixableDto()
final class IconThemeDataDto extends Dto<IconThemeData>
    with _$IconThemeDataDto {
  final ColorDto? color;
  final double? size;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final double? opacity;
  final List<ShadowDto>? shadows;
  final bool? applyTextScaling;

  const IconThemeDataDto({
    this.color,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.opacity,
    this.shadows,
    this.applyTextScaling,
  });

  @override
  IconThemeData get defaultValue => const IconThemeData();
}
