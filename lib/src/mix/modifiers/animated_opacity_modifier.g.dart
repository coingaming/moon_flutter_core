// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animated_opacity_modifier.dart';

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

mixin _$AnimatedOpacityModifierSpec
    on WidgetModifierSpec<AnimatedOpacityModifierSpec> {
  /// Creates a copy of this [AnimatedOpacityModifierSpec] but with the given fields
  /// replaced with the new values.
  @override
  AnimatedOpacityModifierSpec copyWith({
    double? opacity,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedOpacityModifierSpec(
      opacity: opacity ?? _$this.opacity,
      duration: duration ?? _$this.duration,
      curve: curve ?? _$this.curve,
    );
  }

  /// Linearly interpolates between this [AnimatedOpacityModifierSpec] and another [AnimatedOpacityModifierSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [AnimatedOpacityModifierSpec] is returned. When [t] is 1.0, the [other] [AnimatedOpacityModifierSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [AnimatedOpacityModifierSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [AnimatedOpacityModifierSpec] instance.
  ///
  /// The interpolation is performed on each property of the [AnimatedOpacityModifierSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpDouble] for [opacity].

  /// For [duration] and [curve], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [AnimatedOpacityModifierSpec] is used. Otherwise, the value
  /// from the [other] [AnimatedOpacityModifierSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [AnimatedOpacityModifierSpec] configurations.
  @override
  AnimatedOpacityModifierSpec lerp(
      AnimatedOpacityModifierSpec? other, double t) {
    if (other == null) return _$this;

    return AnimatedOpacityModifierSpec(
      opacity: MixHelpers.lerpDouble(_$this.opacity, other.opacity, t)!,
      duration: t < 0.5 ? _$this.duration : other.duration,
      curve: t < 0.5 ? _$this.curve : other.curve,
    );
  }

  /// The list of properties that constitute the state of this [AnimatedOpacityModifierSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [AnimatedOpacityModifierSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.opacity,
        _$this.duration,
        _$this.curve,
      ];

  AnimatedOpacityModifierSpec get _$this => this as AnimatedOpacityModifierSpec;

  void _debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty('opacity', _$this.opacity, defaultValue: null));
    properties.add(
        DiagnosticsProperty('duration', _$this.duration, defaultValue: null));
    properties
        .add(DiagnosticsProperty('curve', _$this.curve, defaultValue: null));
  }
}

/// Represents the attributes of a [AnimatedOpacityModifierSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [AnimatedOpacityModifierSpec].
///
/// Use this class to configure the attributes of a [AnimatedOpacityModifierSpec] and pass it to
/// the [AnimatedOpacityModifierSpec] constructor.
final class AnimatedOpacityModifierSpecAttribute
    extends WidgetModifierSpecAttribute<AnimatedOpacityModifierSpec>
    with Diagnosticable {
  final double? opacity;
  final Duration? duration;
  final Curve? curve;

  const AnimatedOpacityModifierSpecAttribute({
    this.opacity,
    this.duration,
    this.curve,
  });

  /// Resolves to [AnimatedOpacityModifierSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final animatedOpacityModifierSpec = AnimatedOpacityModifierSpecAttribute(...).resolve(mix);
  /// ```
  @override
  AnimatedOpacityModifierSpec resolve(MixData mix) {
    return AnimatedOpacityModifierSpec(
      opacity: opacity,
      duration: duration,
      curve: curve,
    );
  }

  /// Merges the properties of this [AnimatedOpacityModifierSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [AnimatedOpacityModifierSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  AnimatedOpacityModifierSpecAttribute merge(
      AnimatedOpacityModifierSpecAttribute? other) {
    if (other == null) return this;

    return AnimatedOpacityModifierSpecAttribute(
      opacity: other.opacity ?? opacity,
      duration: other.duration ?? duration,
      curve: other.curve ?? curve,
    );
  }

  /// The list of properties that constitute the state of this [AnimatedOpacityModifierSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [AnimatedOpacityModifierSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        opacity,
        duration,
        curve,
      ];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('opacity', opacity, defaultValue: null));
    properties
        .add(DiagnosticsProperty('duration', duration, defaultValue: null));
    properties.add(DiagnosticsProperty('curve', curve, defaultValue: null));
  }
}

/// A tween that interpolates between two [AnimatedOpacityModifierSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [AnimatedOpacityModifierSpec] specifications.
class AnimatedOpacityModifierSpecTween
    extends Tween<AnimatedOpacityModifierSpec?> {
  AnimatedOpacityModifierSpecTween({
    super.begin,
    super.end,
  });

  @override
  AnimatedOpacityModifierSpec lerp(double t) {
    if (begin == null && end == null) {
      return const AnimatedOpacityModifierSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}
