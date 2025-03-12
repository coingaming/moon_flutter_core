// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animated_shape_decoration_modifier.dart';

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

mixin _$AnimatedShapeDecorationModifierSpec
    on WidgetModifierSpec<AnimatedShapeDecorationModifierSpec> {
  /// Creates a copy of this [AnimatedShapeDecorationModifierSpec] but with the given fields
  /// replaced with the new values.
  @override
  AnimatedShapeDecorationModifierSpec copyWith({
    Color? bgColor,
    Color? hoverColor,
    MoonBorder? border,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedShapeDecorationModifierSpec(
      bgColor: bgColor ?? _$this.bgColor,
      hoverColor: hoverColor ?? _$this.hoverColor,
      border: border ?? _$this.border,
      duration: duration ?? _$this.duration,
      curve: curve ?? _$this.curve,
    );
  }

  /// The list of properties that constitute the state of this [AnimatedShapeDecorationModifierSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [AnimatedShapeDecorationModifierSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.bgColor,
        _$this.hoverColor,
        _$this.border,
        _$this.duration,
        _$this.curve,
      ];

  AnimatedShapeDecorationModifierSpec get _$this =>
      this as AnimatedShapeDecorationModifierSpec;

  void _debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty('bgColor', _$this.bgColor, defaultValue: null));
    properties.add(DiagnosticsProperty('hoverColor', _$this.hoverColor,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty('border', _$this.border, defaultValue: null));
    properties.add(
        DiagnosticsProperty('duration', _$this.duration, defaultValue: null));
    properties
        .add(DiagnosticsProperty('curve', _$this.curve, defaultValue: null));
  }
}

/// Represents the attributes of a [AnimatedShapeDecorationModifierSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [AnimatedShapeDecorationModifierSpec].
///
/// Use this class to configure the attributes of a [AnimatedShapeDecorationModifierSpec] and pass it to
/// the [AnimatedShapeDecorationModifierSpec] constructor.
final class AnimatedShapeDecorationModifierSpecAttribute
    extends WidgetModifierSpecAttribute<AnimatedShapeDecorationModifierSpec>
    with Diagnosticable {
  final ColorDto? bgColor;
  final ColorDto? hoverColor;
  final MoonBorderDto? border;
  final Duration? duration;
  final Curve? curve;

  const AnimatedShapeDecorationModifierSpecAttribute({
    this.bgColor,
    this.hoverColor,
    this.border,
    this.duration,
    this.curve,
  });

  /// Resolves to [AnimatedShapeDecorationModifierSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final animatedShapeDecorationModifierSpec = AnimatedShapeDecorationModifierSpecAttribute(...).resolve(mix);
  /// ```
  @override
  AnimatedShapeDecorationModifierSpec resolve(MixData mix) {
    return AnimatedShapeDecorationModifierSpec(
      bgColor: bgColor?.resolve(mix),
      hoverColor: hoverColor?.resolve(mix),
      border: border?.resolve(mix),
      duration: duration,
      curve: curve,
    );
  }

  /// Merges the properties of this [AnimatedShapeDecorationModifierSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [AnimatedShapeDecorationModifierSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  AnimatedShapeDecorationModifierSpecAttribute merge(
      AnimatedShapeDecorationModifierSpecAttribute? other) {
    if (other == null) return this;

    return AnimatedShapeDecorationModifierSpecAttribute(
      bgColor: bgColor?.merge(other.bgColor) ?? other.bgColor,
      hoverColor: hoverColor?.merge(other.hoverColor) ?? other.hoverColor,
      border: border?.merge(other.border) ?? other.border,
      duration: other.duration ?? duration,
      curve: other.curve ?? curve,
    );
  }

  /// The list of properties that constitute the state of this [AnimatedShapeDecorationModifierSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [AnimatedShapeDecorationModifierSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        bgColor,
        hoverColor,
        border,
        duration,
        curve,
      ];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('bgColor', bgColor, defaultValue: null));
    properties
        .add(DiagnosticsProperty('hoverColor', hoverColor, defaultValue: null));
    properties.add(DiagnosticsProperty('border', border, defaultValue: null));
    properties
        .add(DiagnosticsProperty('duration', duration, defaultValue: null));
    properties.add(DiagnosticsProperty('curve', curve, defaultValue: null));
  }
}

/// A tween that interpolates between two [AnimatedShapeDecorationModifierSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [AnimatedShapeDecorationModifierSpec] specifications.
class AnimatedShapeDecorationModifierSpecTween
    extends Tween<AnimatedShapeDecorationModifierSpec?> {
  AnimatedShapeDecorationModifierSpecTween({
    super.begin,
    super.end,
  });

  @override
  AnimatedShapeDecorationModifierSpec lerp(double t) {
    if (begin == null && end == null) {
      return const AnimatedShapeDecorationModifierSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}
