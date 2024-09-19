import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/src/utils/moon_squircle_border.dart';

part 'moon_squircle_border_dto.g.dart';

@MixableDto(generateUtility: false)
final class MoonSquircleBorderDto extends OutlinedBorderDto<MoonSquircleBorder>
    with _$MoonSquircleBorderDto {
  final BorderRadiusGeometryDto? borderRadius;
  final BorderAlign? borderAlign;

  const MoonSquircleBorderDto({
    this.borderRadius,
    this.borderAlign,
    super.side,
  });

  @override
  BorderRadiusGeometryDto<BorderRadiusGeometry>? get borderRadiusGetter =>
      borderRadius;

  @override
  MoonSquircleBorder get defaultValue => const MoonSquircleBorder();

  @override
  OutlinedBorderDto<MoonSquircleBorder> adapt(OutlinedBorderDto<OutlinedBorder> other) {
    return MoonSquircleBorderDto(
      borderRadius: other.borderRadiusGetter,
      side: other.side,
    );
  }
}
