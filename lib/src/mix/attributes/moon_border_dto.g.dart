// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moon_border_dto.dart';

// **************************************************************************
// MixableDtoGenerator
// **************************************************************************

mixin _$MoonBorderDto on Dto<MoonBorder> {
  /// Resolves to [MoonBorder] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final moonBorder = MoonBorderDto(...).resolve(mix);
  /// ```
  @override
  MoonBorder resolve(MixData mix) {
    return MoonBorder(
      borderRadius:
          _$this.borderRadius?.resolve(mix) ?? defaultValue.borderRadius,
      borderAlign: _$this.borderAlign ?? defaultValue.borderAlign,
      side: _$this.side?.resolve(mix) ?? defaultValue.side,
    );
  }

  /// Merges the properties of this [MoonBorderDto] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MoonBorderDto] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MoonBorderDto merge(MoonBorderDto? other) {
    if (other == null) return _$this;

    return MoonBorderDto(
      borderRadius:
          _$this.borderRadius?.merge(other.borderRadius) ?? other.borderRadius,
      borderAlign: other.borderAlign ?? _$this.borderAlign,
      side: _$this.side?.merge(other.side) ?? other.side,
    );
  }

  /// The list of properties that constitute the state of this [MoonBorderDto].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MoonBorderDto] instances for equality.
  @override
  List<Object?> get props => [
        _$this.borderRadius,
        _$this.borderAlign,
        _$this.side,
      ];

  MoonBorderDto get _$this => this as MoonBorderDto;
}

extension MoonBorderMixExt on MoonBorder {
  MoonBorderDto toDto() {
    return MoonBorderDto(
      borderRadius: borderRadius.toDto(),
      borderAlign: borderAlign,
      side: side.toDto(),
    );
  }
}

extension ListMoonBorderMixExt on List<MoonBorder> {
  List<MoonBorderDto> toDto() {
    return map((e) => e.toDto()).toList();
  }
}
