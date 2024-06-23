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
    IconThemeData? leadingIconThemeData,
    IconThemeData? labelIconThemeData,
    IconThemeData? trailingIconThemeData,
    IconThemeData? contentIconThemeData,
    TextStyle? leadingTextStyle,
    TextStyle? labelTextStyle,
    TextStyle? trailingTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return BaseLayoutSpec(
      animated: animated ?? _$this.animated,
      horizontalGap: horizontalGap ?? _$this.horizontalGap,
      verticalGap: verticalGap ?? _$this.verticalGap,
      leadingIconThemeData: leadingIconThemeData ?? _$this.leadingIconThemeData,
      labelIconThemeData: labelIconThemeData ?? _$this.labelIconThemeData,
      trailingIconThemeData:
          trailingIconThemeData ?? _$this.trailingIconThemeData,
      contentIconThemeData: contentIconThemeData ?? _$this.contentIconThemeData,
      leadingTextStyle: leadingTextStyle ?? _$this.leadingTextStyle,
      labelTextStyle: labelTextStyle ?? _$this.labelTextStyle,
      trailingTextStyle: trailingTextStyle ?? _$this.trailingTextStyle,
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
  /// - [IconThemeData.lerp] for [leadingIconThemeData] and [labelIconThemeData] and [trailingIconThemeData] and [contentIconThemeData].
  /// - [MixHelpers.lerpTextStyle] for [leadingTextStyle] and [labelTextStyle] and [trailingTextStyle] and [contentTextStyle].

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
      leadingIconThemeData: IconThemeData.lerp(
          _$this.leadingIconThemeData, other.leadingIconThemeData, t),
      labelIconThemeData: IconThemeData.lerp(
          _$this.labelIconThemeData, other.labelIconThemeData, t),
      trailingIconThemeData: IconThemeData.lerp(
          _$this.trailingIconThemeData, other.trailingIconThemeData, t),
      contentIconThemeData: IconThemeData.lerp(
          _$this.contentIconThemeData, other.contentIconThemeData, t),
      leadingTextStyle: MixHelpers.lerpTextStyle(
          _$this.leadingTextStyle, other.leadingTextStyle, t),
      labelTextStyle: MixHelpers.lerpTextStyle(
          _$this.labelTextStyle, other.labelTextStyle, t),
      trailingTextStyle: MixHelpers.lerpTextStyle(
          _$this.trailingTextStyle, other.trailingTextStyle, t),
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
        _$this.leadingIconThemeData,
        _$this.labelIconThemeData,
        _$this.trailingIconThemeData,
        _$this.contentIconThemeData,
        _$this.leadingTextStyle,
        _$this.labelTextStyle,
        _$this.trailingTextStyle,
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
  final IconThemeDataDto? leadingIconThemeData;
  final IconThemeDataDto? labelIconThemeData;
  final IconThemeDataDto? trailingIconThemeData;
  final IconThemeDataDto? contentIconThemeData;
  final TextStyleDto? leadingTextStyle;
  final TextStyleDto? labelTextStyle;
  final TextStyleDto? trailingTextStyle;
  final TextStyleDto? contentTextStyle;

  const BaseLayoutSpecAttribute({
    super.animated,
    this.horizontalGap,
    this.verticalGap,
    this.leadingIconThemeData,
    this.labelIconThemeData,
    this.trailingIconThemeData,
    this.contentIconThemeData,
    this.leadingTextStyle,
    this.labelTextStyle,
    this.trailingTextStyle,
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
      leadingIconThemeData: leadingIconThemeData?.resolve(mix),
      labelIconThemeData: labelIconThemeData?.resolve(mix),
      trailingIconThemeData: trailingIconThemeData?.resolve(mix),
      contentIconThemeData: contentIconThemeData?.resolve(mix),
      leadingTextStyle: leadingTextStyle?.resolve(mix),
      labelTextStyle: labelTextStyle?.resolve(mix),
      trailingTextStyle: trailingTextStyle?.resolve(mix),
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
      leadingIconThemeData:
          leadingIconThemeData?.merge(other.leadingIconThemeData) ??
              other.leadingIconThemeData,
      labelIconThemeData: labelIconThemeData?.merge(other.labelIconThemeData) ??
          other.labelIconThemeData,
      trailingIconThemeData:
          trailingIconThemeData?.merge(other.trailingIconThemeData) ??
              other.trailingIconThemeData,
      contentIconThemeData:
          contentIconThemeData?.merge(other.contentIconThemeData) ??
              other.contentIconThemeData,
      leadingTextStyle: leadingTextStyle?.merge(other.leadingTextStyle) ??
          other.leadingTextStyle,
      labelTextStyle:
          labelTextStyle?.merge(other.labelTextStyle) ?? other.labelTextStyle,
      trailingTextStyle: trailingTextStyle?.merge(other.trailingTextStyle) ??
          other.trailingTextStyle,
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
        leadingIconThemeData,
        labelIconThemeData,
        trailingIconThemeData,
        contentIconThemeData,
        leadingTextStyle,
        labelTextStyle,
        trailingTextStyle,
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

  /// Utility for defining [BaseLayoutSpecAttribute.leadingIconThemeData]
  late final leadingIconThemeData =
      IconThemeDataUtility((v) => only(leadingIconThemeData: v));

  /// Utility for defining [BaseLayoutSpecAttribute.labelIconThemeData]
  late final labelIconThemeData =
      IconThemeDataUtility((v) => only(labelIconThemeData: v));

  /// Utility for defining [BaseLayoutSpecAttribute.trailingIconThemeData]
  late final trailingIconThemeData =
      IconThemeDataUtility((v) => only(trailingIconThemeData: v));

  /// Utility for defining [BaseLayoutSpecAttribute.contentIconThemeData]
  late final contentIconThemeData =
      IconThemeDataUtility((v) => only(contentIconThemeData: v));

  /// Utility for defining [BaseLayoutSpecAttribute.leadingTextStyle]
  late final leadingTextStyle =
      TextStyleUtility((v) => only(leadingTextStyle: v));

  /// Utility for defining [BaseLayoutSpecAttribute.labelTextStyle]
  late final labelTextStyle = TextStyleUtility((v) => only(labelTextStyle: v));

  /// Utility for defining [BaseLayoutSpecAttribute.trailingTextStyle]
  late final trailingTextStyle =
      TextStyleUtility((v) => only(trailingTextStyle: v));

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
    IconThemeDataDto? leadingIconThemeData,
    IconThemeDataDto? labelIconThemeData,
    IconThemeDataDto? trailingIconThemeData,
    IconThemeDataDto? contentIconThemeData,
    TextStyleDto? leadingTextStyle,
    TextStyleDto? labelTextStyle,
    TextStyleDto? trailingTextStyle,
    TextStyleDto? contentTextStyle,
  }) {
    return builder(BaseLayoutSpecAttribute(
      animated: animated,
      horizontalGap: horizontalGap,
      verticalGap: verticalGap,
      leadingIconThemeData: leadingIconThemeData,
      labelIconThemeData: labelIconThemeData,
      trailingIconThemeData: trailingIconThemeData,
      contentIconThemeData: contentIconThemeData,
      leadingTextStyle: leadingTextStyle,
      labelTextStyle: labelTextStyle,
      trailingTextStyle: trailingTextStyle,
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
