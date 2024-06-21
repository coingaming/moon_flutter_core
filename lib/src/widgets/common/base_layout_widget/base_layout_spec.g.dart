// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_layout_spec.dart';

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

base mixin _$BaseLayoutSpec on Spec<BaseLayoutSpec> {
  static BaseLayoutSpec from(MixData mix) {
    return mix.attributeOf<BaseLayoutSpecAttribute>()?.resolve(mix) ??
        const BaseLayoutSpec();
  }

  /// {@template base_layout_spec_of}
  /// Retrieves the [BaseLayoutSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [BaseLayoutSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [BaseLayoutSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final baseLayoutSpec = BaseLayoutSpec.of(context);
  /// ```
  /// {@endtemplate}
  static BaseLayoutSpec of(BuildContext context) {
    return _$BaseLayoutSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [BaseLayoutSpec] but with the given fields
  /// replaced with the new values.
  @override
  BaseLayoutSpec copyWith({
    AnimatedData? animated,
    double? horizontalGap,
    double? verticalGap,
    TextStyle? contentTextStyle,
  }) {
    return BaseLayoutSpec(
      animated: animated ?? _$this.animated,
      horizontalGap: horizontalGap ?? _$this.horizontalGap,
      verticalGap: verticalGap ?? _$this.verticalGap,
      contentTextStyle: contentTextStyle ?? _$this.contentTextStyle,
    );
  }

  /// Linearly interpolates between this [BaseLayoutSpec] and another [BaseLayoutSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [BaseLayoutSpec] is returned. When [t] is 1.0, the [other] [BaseLayoutSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [BaseLayoutSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [BaseLayoutSpec] instance.
  ///
  /// The interpolation is performed on each property of the [BaseLayoutSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpDouble] for [horizontalGap] and [verticalGap].
  /// - [MixHelpers.lerpTextStyle] for [contentTextStyle].

  /// For [animated], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [BaseLayoutSpec] is used. Otherwise, the value
  /// from the [other] [BaseLayoutSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [BaseLayoutSpec] configurations.
  @override
  BaseLayoutSpec lerp(BaseLayoutSpec? other, double t) {
    if (other == null) return _$this;

    return BaseLayoutSpec(
      animated: t < 0.5 ? _$this.animated : other.animated,
      horizontalGap:
          MixHelpers.lerpDouble(_$this.horizontalGap, other.horizontalGap, t),
      verticalGap:
          MixHelpers.lerpDouble(_$this.verticalGap, other.verticalGap, t),
      contentTextStyle: MixHelpers.lerpTextStyle(
          _$this.contentTextStyle, other.contentTextStyle, t),
    );
  }

  /// The list of properties that constitute the state of this [BaseLayoutSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [BaseLayoutSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.animated,
        _$this.horizontalGap,
        _$this.verticalGap,
        _$this.contentTextStyle,
      ];

  BaseLayoutSpec get _$this => this as BaseLayoutSpec;
}

/// Represents the attributes of a [BaseLayoutSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [BaseLayoutSpec].
///
/// Use this class to configure the attributes of a [BaseLayoutSpec] and pass it to
/// the [BaseLayoutSpec] constructor.
final class BaseLayoutSpecAttribute extends SpecAttribute<BaseLayoutSpec> {
  final double? horizontalGap;
  final double? verticalGap;
  final TextStyleDto? contentTextStyle;

  const BaseLayoutSpecAttribute({
    super.animated,
    this.horizontalGap,
    this.verticalGap,
    this.contentTextStyle,
  });

  /// Resolves to [BaseLayoutSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final baseLayoutSpec = BaseLayoutSpecAttribute(...).resolve(mix);
  /// ```
  @override
  BaseLayoutSpec resolve(MixData mix) {
    return BaseLayoutSpec(
      animated: animated?.resolve(mix) ?? mix.animation,
      horizontalGap: horizontalGap,
      verticalGap: verticalGap,
      contentTextStyle: contentTextStyle?.resolve(mix),
    );
  }

  /// Merges the properties of this [BaseLayoutSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [BaseLayoutSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  BaseLayoutSpecAttribute merge(BaseLayoutSpecAttribute? other) {
    if (other == null) return this;

    return BaseLayoutSpecAttribute(
      animated: animated?.merge(other.animated) ?? other.animated,
      horizontalGap: other.horizontalGap ?? horizontalGap,
      verticalGap: other.verticalGap ?? verticalGap,
      contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ??
          other.contentTextStyle,
    );
  }

  /// The list of properties that constitute the state of this [BaseLayoutSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [BaseLayoutSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        animated,
        horizontalGap,
        verticalGap,
        contentTextStyle,
      ];
}

/// Utility class for configuring [BaseLayoutSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [BaseLayoutSpecAttribute].
/// Use the methods of this class to configure specific properties of a [BaseLayoutSpecAttribute].
base class BaseLayoutSpecUtility<T extends Attribute>
    extends SpecUtility<T, BaseLayoutSpecAttribute> {
  /// Utility for defining [BaseLayoutSpecAttribute.animated]
  late final animated = AnimatedUtility((v) => only(animated: v));

  /// Utility for defining [BaseLayoutSpecAttribute.horizontalGap]
  late final horizontalGap = DoubleUtility((v) => only(horizontalGap: v));

  /// Utility for defining [BaseLayoutSpecAttribute.verticalGap]
  late final verticalGap = DoubleUtility((v) => only(verticalGap: v));

  /// Utility for defining [BaseLayoutSpecAttribute.contentTextStyle]
  late final contentTextStyle =
      TextStyleUtility((v) => only(contentTextStyle: v));

  BaseLayoutSpecUtility(super.builder);

  static final self = BaseLayoutSpecUtility((v) => v);

  /// Returns a new [BaseLayoutSpecAttribute] with the specified properties.
  @override
  T only({
    AnimatedDataDto? animated,
    double? horizontalGap,
    double? verticalGap,
    TextStyleDto? contentTextStyle,
  }) {
    return builder(BaseLayoutSpecAttribute(
      animated: animated,
      horizontalGap: horizontalGap,
      verticalGap: verticalGap,
      contentTextStyle: contentTextStyle,
    ));
  }
}

/// A tween that interpolates between two [BaseLayoutSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [BaseLayoutSpec] specifications.
class BaseLayoutSpecTween extends Tween<BaseLayoutSpec?> {
  BaseLayoutSpecTween({
    super.begin,
    super.end,
  });

  @override
  BaseLayoutSpec lerp(double t) {
    if (begin == null && end == null) return const BaseLayoutSpec();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}
