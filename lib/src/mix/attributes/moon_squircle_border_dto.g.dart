// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moon_squircle_border_dto.dart';

// **************************************************************************
// MixableDtoGenerator
// **************************************************************************

mixin _$MoonSquircleBorderDto on Dto<MoonSquircleBorder> {
  /// Resolves to [MoonSquircleBorder] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final moonSquircleBorder = MoonSquircleBorderDto(...).resolve(mix);
  /// ```
  @override
  MoonSquircleBorder resolve(MixData mix) {
    return MoonSquircleBorder(
      borderRadius:
          _$this.borderRadius?.resolve(mix) ?? defaultValue.borderRadius,
      borderAlign: _$this.borderAlign ?? defaultValue.borderAlign,
      side: _$this.side?.resolve(mix) ?? defaultValue.side,
    );
  }

  /// Merges the properties of this [MoonSquircleBorderDto] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MoonSquircleBorderDto] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MoonSquircleBorderDto merge(MoonSquircleBorderDto? other) {
    if (other == null) return _$this;

    return MoonSquircleBorderDto(
      borderRadius:
          _$this.borderRadius?.merge(other.borderRadius) ?? other.borderRadius,
      borderAlign: other.borderAlign ?? _$this.borderAlign,
      side: _$this.side?.merge(other.side) ?? other.side,
    );
  }

  /// The list of properties that constitute the state of this [MoonSquircleBorderDto].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MoonSquircleBorderDto] instances for equality.
  @override
  List<Object?> get props => [
        _$this.borderRadius,
        _$this.borderAlign,
        _$this.side,
      ];

  MoonSquircleBorderDto get _$this => this as MoonSquircleBorderDto;
}

extension MoonSquircleBorderMixExt on MoonSquircleBorder {
  MoonSquircleBorderDto toDto() {
    return MoonSquircleBorderDto(
      borderRadius: borderRadius.toDto(),
      borderAlign: borderAlign,
      side: side.toDto(),
    );
  }
}

extension ListMoonSquircleBorderMixExt on List<MoonSquircleBorder> {
  List<MoonSquircleBorderDto> toDto() {
    return map((e) => e.toDto()).toList();
  }
}
