// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_theme_dto.dart';

// **************************************************************************
// MixableDtoGenerator
// **************************************************************************

base mixin _$IconThemeDto on Dto<IconThemeData> {
  /// The list of properties that constitute the state of this [IconThemeDto].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [IconThemeDto] instances for equality.
  @override
  List<Object?> get props => [
        _$this.color,
        _$this.size,
        _$this.fill,
        _$this.weight,
        _$this.grade,
        _$this.opticalSize,
        _$this.opacity,
        _$this.shadows,
        _$this.applyTextScaling,
      ];

  IconThemeDto get _$this => this as IconThemeDto;
}

extension IconThemeDataMixExt on IconThemeData {
  IconThemeDto toDto() {
    return IconThemeDto(
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
}
