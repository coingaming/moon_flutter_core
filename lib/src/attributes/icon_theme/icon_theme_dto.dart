import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'icon_theme_dto.g.dart';

@MixableDto(generateUtility: false)
final class IconThemeDto extends Dto<IconThemeData> with _$IconThemeDto {
  final ColorDto? color;
  final double? size;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final double? opacity;
  final List<ShadowDto>? shadows;
  final bool? applyTextScaling;

  const IconThemeDto({
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
  IconThemeData resolve(MixData mix) {
    return IconThemeData(
      color: color?.resolve(mix),
      size: size,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      opacity: opacity,
      shadows: shadows?.map((e) => e.resolve(mix)).toList(),
      applyTextScaling: applyTextScaling,
    );
  }

  @override
  IconThemeDto merge(IconThemeDto other) {
    return IconThemeDto(
      color: color?.merge(other.color) ?? other.color,
      size: size ?? other.size,
      fill: fill ?? other.fill,
      weight: weight ?? other.weight,
      grade: grade ?? other.grade,
      opticalSize: opticalSize ?? other.opticalSize,
      opacity: opacity ?? other.opacity,
      shadows: MixHelpers.mergeList(shadows, other.shadows),
      applyTextScaling: applyTextScaling ?? other.applyTextScaling,
    );
  }

  @override
  IconThemeData get defaultValue => const IconThemeData();

  @override
  List<Object?> get props => [
        color,
        size,
        fill,
        weight,
        grade,
        opticalSize,
        opacity,
        shadows,
        applyTextScaling,
      ];
}

final class IconThemeUtility<T extends Attribute>
    extends DtoUtility<T, IconThemeDto, IconThemeData> {
  late final color = ColorUtility((v) => only(color: v));

  late final shadow = ShadowUtility((v) => only(shadows: [v]));

  late final fill = DoubleUtility((v) => only(fill: v));

  late final size = DoubleUtility((v) => only(size: v));

  late final weight = DoubleUtility((v) => only(weight: v));

  late final grade = DoubleUtility((v) => only(grade: v));

  late final opticalSize = DoubleUtility((v) => only(opticalSize: v));

  late final shadows = ShadowListUtility((v) => only(shadows: v));

  late final applyTextScaling = BoolUtility((v) => only(applyTextScaling: v));

  IconThemeUtility(super.builder) : super(valueToDto: (v) => v.toDto());

  T call({
    Color? color,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    double? opacity,
    List<Shadow>? shadows,
    bool? applyTextScaling,
  }) {
    return only(
      color: color?.toDto(),
      size: size,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      opacity: opacity,
      shadows: shadows?.map((e) => e.toDto()).toList(),
      applyTextScaling: applyTextScaling,
    );
  }

  @override
  T only({
    ColorDto? color,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    double? opacity,
    List<ShadowDto>? shadows,
    bool? applyTextScaling,
  }) {
    return builder(
      IconThemeDto(
        color: color,
        size: size,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        opacity: opacity,
        shadows: shadows,
        applyTextScaling: applyTextScaling,
      ),
    );
  }
}
