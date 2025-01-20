import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/moon_core.dart';

part 'moon_border_dto.g.dart';

@MixableDto(generateUtility: false)
final class MoonBorderDto extends OutlinedBorderDto<MoonBorder>
    with _$MoonBorderDto {
  final BorderRadiusGeometryDto? borderRadius;
  final BorderAlign? borderAlign;

  const MoonBorderDto({
    this.borderRadius,
    this.borderAlign,
    super.side,
  });

  @override
  BorderRadiusGeometryDto<BorderRadiusGeometry>? get borderRadiusGetter =>
      borderRadius;

  @override
  MoonBorder get defaultValue => const MoonBorder();

  @override
  OutlinedBorderDto<MoonBorder> adapt(OutlinedBorderDto<OutlinedBorder> other) {
    return MoonBorderDto(
      borderRadius: other.borderRadiusGetter,
      side: other.side,
    );
  }
}
