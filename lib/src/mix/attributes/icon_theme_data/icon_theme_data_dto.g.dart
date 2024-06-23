// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_theme_data_dto.dart';

// **************************************************************************
// MixableDtoGenerator
// **************************************************************************

base mixin _$IconThemeDataDto on Dto<IconThemeData> {
  /// Resolves to [IconThemeData] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final iconThemeData = IconThemeDataDto(...).resolve(mix);
  /// ```
  @override
  IconThemeData resolve(MixData mix) {
    return IconThemeData(
      color: _$this.color?.resolve(mix) ?? defaultValue.color,
      size: _$this.size ?? defaultValue.size,
      fill: _$this.fill ?? defaultValue.fill,
      weight: _$this.weight ?? defaultValue.weight,
      grade: _$this.grade ?? defaultValue.grade,
      opticalSize: _$this.opticalSize ?? defaultValue.opticalSize,
      opacity: _$this.opacity ?? defaultValue.opacity,
      shadows: _$this.shadows?.map((e) => e.resolve(mix)).toList() ??
          defaultValue.shadows,
      applyTextScaling:
          _$this.applyTextScaling ?? defaultValue.applyTextScaling,
    );
  }

  /// Merges the properties of this [IconThemeDataDto] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [IconThemeDataDto] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  IconThemeDataDto merge(IconThemeDataDto? other) {
    if (other == null) return _$this;

    return IconThemeDataDto(
      color: _$this.color?.merge(other.color) ?? other.color,
      size: other.size ?? _$this.size,
      fill: other.fill ?? _$this.fill,
      weight: other.weight ?? _$this.weight,
      grade: other.grade ?? _$this.grade,
      opticalSize: other.opticalSize ?? _$this.opticalSize,
      opacity: other.opacity ?? _$this.opacity,
      shadows: MixHelpers.mergeList(_$this.shadows, other.shadows),
      applyTextScaling: other.applyTextScaling ?? _$this.applyTextScaling,
    );
  }

  /// The list of properties that constitute the state of this [IconThemeDataDto].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [IconThemeDataDto] instances for equality.
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

  IconThemeDataDto get _$this => this as IconThemeDataDto;
}

/// Utility class for configuring [IconThemeDataDto] properties.
///
/// This class provides methods to set individual properties of a [IconThemeDataDto].
/// Use the methods of this class to configure specific properties of a [IconThemeDataDto].
final class IconThemeDataUtility<T extends Attribute>
    extends DtoUtility<T, IconThemeDataDto, IconThemeData> {
  /// Utility for defining [IconThemeDataDto.color]
  late final color = ColorUtility((v) => only(color: v));

  /// Utility for defining [IconThemeDataDto.size]
  late final size = DoubleUtility((v) => only(size: v));

  /// Utility for defining [IconThemeDataDto.fill]
  late final fill = DoubleUtility((v) => only(fill: v));

  /// Utility for defining [IconThemeDataDto.weight]
  late final weight = DoubleUtility((v) => only(weight: v));

  /// Utility for defining [IconThemeDataDto.grade]
  late final grade = DoubleUtility((v) => only(grade: v));

  /// Utility for defining [IconThemeDataDto.opticalSize]
  late final opticalSize = DoubleUtility((v) => only(opticalSize: v));

  /// Utility for defining [IconThemeDataDto.opacity]
  late final opacity = DoubleUtility((v) => only(opacity: v));

  /// Utility for defining [IconThemeDataDto.shadows]
  late final shadows = ShadowListUtility((v) => only(shadows: v));

  /// Utility for defining [IconThemeDataDto.applyTextScaling]
  late final applyTextScaling = BoolUtility((v) => only(applyTextScaling: v));

  IconThemeDataUtility(super.builder) : super(valueToDto: (v) => v.toDto());

  /// Returns a new [IconThemeDataDto] with the specified properties.
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
    return builder(IconThemeDataDto(
      color: color,
      size: size,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      opacity: opacity,
      shadows: shadows,
      applyTextScaling: applyTextScaling,
    ));
  }

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
}

extension IconThemeDataMixExt on IconThemeData {
  IconThemeDataDto toDto() {
    return IconThemeDataDto(
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
