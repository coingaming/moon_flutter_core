// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_text_style_modifier.dart';

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

mixin _$DefaultTextStyleModifierSpec
    on WidgetModifierSpec<DefaultTextStyleModifierSpec> {
  /// Creates a copy of this [DefaultTextStyleModifierSpec] but with the given fields
  /// replaced with the new values.
  @override
  DefaultTextStyleModifierSpec copyWith({
    TextStyle? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextHeightBehavior? textHeightBehavior,
    TextWidthBasis? textWidthBasis,
  }) {
    return DefaultTextStyleModifierSpec(
      style: style ?? _$this.style,
      softWrap: softWrap ?? _$this.softWrap,
      maxLines: maxLines ?? _$this.maxLines,
      textAlign: textAlign ?? _$this.textAlign,
      overflow: overflow ?? _$this.overflow,
      textHeightBehavior: textHeightBehavior ?? _$this.textHeightBehavior,
      textWidthBasis: textWidthBasis ?? _$this.textWidthBasis,
    );
  }

  /// Linearly interpolates between this [DefaultTextStyleModifierSpec] and another [DefaultTextStyleModifierSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [DefaultTextStyleModifierSpec] is returned. When [t] is 1.0, the [other] [DefaultTextStyleModifierSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [DefaultTextStyleModifierSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [DefaultTextStyleModifierSpec] instance.
  ///
  /// The interpolation is performed on each property of the [DefaultTextStyleModifierSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [style].

  /// For [softWrap] and [maxLines] and [textAlign] and [overflow] and [textHeightBehavior] and [textWidthBasis], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [DefaultTextStyleModifierSpec] is used. Otherwise, the value
  /// from the [other] [DefaultTextStyleModifierSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [DefaultTextStyleModifierSpec] configurations.
  @override
  DefaultTextStyleModifierSpec lerp(
      DefaultTextStyleModifierSpec? other, double t) {
    if (other == null) return _$this;

    return DefaultTextStyleModifierSpec(
      style: MixHelpers.lerpTextStyle(_$this.style, other.style, t),
      softWrap: t < 0.5 ? _$this.softWrap : other.softWrap,
      maxLines: t < 0.5 ? _$this.maxLines : other.maxLines,
      textAlign: t < 0.5 ? _$this.textAlign : other.textAlign,
      overflow: t < 0.5 ? _$this.overflow : other.overflow,
      textHeightBehavior:
          t < 0.5 ? _$this.textHeightBehavior : other.textHeightBehavior,
      textWidthBasis: t < 0.5 ? _$this.textWidthBasis : other.textWidthBasis,
    );
  }

  /// The list of properties that constitute the state of this [DefaultTextStyleModifierSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [DefaultTextStyleModifierSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.style,
        _$this.softWrap,
        _$this.maxLines,
        _$this.textAlign,
        _$this.overflow,
        _$this.textHeightBehavior,
        _$this.textWidthBasis,
      ];

  DefaultTextStyleModifierSpec get _$this =>
      this as DefaultTextStyleModifierSpec;
}

/// Represents the attributes of a [DefaultTextStyleModifierSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [DefaultTextStyleModifierSpec].
///
/// Use this class to configure the attributes of a [DefaultTextStyleModifierSpec] and pass it to
/// the [DefaultTextStyleModifierSpec] constructor.
final class DefaultTextStyleModifierSpecAttribute
    extends WidgetModifierSpecAttribute<DefaultTextStyleModifierSpec> {
  final TextStyleDto? style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;

  const DefaultTextStyleModifierSpecAttribute({
    this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textHeightBehavior,
    this.textWidthBasis,
  });

  /// Resolves to [DefaultTextStyleModifierSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final defaultTextStyleModifierSpec = DefaultTextStyleModifierSpecAttribute(...).resolve(mix);
  /// ```
  @override
  DefaultTextStyleModifierSpec resolve(MixData mix) {
    return DefaultTextStyleModifierSpec(
      style: style?.resolve(mix),
      softWrap: softWrap,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
    );
  }

  /// Merges the properties of this [DefaultTextStyleModifierSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [DefaultTextStyleModifierSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  DefaultTextStyleModifierSpecAttribute merge(
      DefaultTextStyleModifierSpecAttribute? other) {
    if (other == null) return this;

    return DefaultTextStyleModifierSpecAttribute(
      style: style?.merge(other.style) ?? other.style,
      softWrap: other.softWrap ?? softWrap,
      maxLines: other.maxLines ?? maxLines,
      textAlign: other.textAlign ?? textAlign,
      overflow: other.overflow ?? overflow,
      textHeightBehavior: other.textHeightBehavior ?? textHeightBehavior,
      textWidthBasis: other.textWidthBasis ?? textWidthBasis,
    );
  }

  /// The list of properties that constitute the state of this [DefaultTextStyleModifierSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [DefaultTextStyleModifierSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        style,
        softWrap,
        maxLines,
        textAlign,
        overflow,
        textHeightBehavior,
        textWidthBasis,
      ];
}

/// Utility class for configuring [DefaultTextStyleModifierSpec] properties.
///
/// This class provides methods to set individual properties of a [DefaultTextStyleModifierSpec].
/// Use the methods of this class to configure specific properties of a [DefaultTextStyleModifierSpec].
class DefaultTextStyleModifierSpecUtility<T extends Attribute>
    extends SpecUtility<T, DefaultTextStyleModifierSpecAttribute> {
  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.style]
  late final style = TextStyleUtility((v) => only(style: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.softWrap]
  late final softWrap = BoolUtility((v) => only(softWrap: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.maxLines]
  late final maxLines = IntUtility((v) => only(maxLines: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.textAlign]
  late final textAlign = TextAlignUtility((v) => only(textAlign: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.overflow]
  late final overflow = TextOverflowUtility((v) => only(overflow: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.textHeightBehavior]
  late final textHeightBehavior =
      TextHeightBehaviorUtility((v) => only(textHeightBehavior: v));

  /// Utility for defining [DefaultTextStyleModifierSpecAttribute.textWidthBasis]
  late final textWidthBasis =
      TextWidthBasisUtility((v) => only(textWidthBasis: v));

  DefaultTextStyleModifierSpecUtility(super.builder, {super.mutable});

  DefaultTextStyleModifierSpecUtility<T> get chain =>
      DefaultTextStyleModifierSpecUtility(attributeBuilder, mutable: true);

  static DefaultTextStyleModifierSpecUtility<
          DefaultTextStyleModifierSpecAttribute>
      get self => DefaultTextStyleModifierSpecUtility((v) => v);

  /// Returns a new [DefaultTextStyleModifierSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextHeightBehavior? textHeightBehavior,
    TextWidthBasis? textWidthBasis,
  }) {
    return builder(DefaultTextStyleModifierSpecAttribute(
      style: style,
      softWrap: softWrap,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
    ));
  }
}

/// A tween that interpolates between two [DefaultTextStyleModifierSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [DefaultTextStyleModifierSpec] specifications.
class DefaultTextStyleModifierSpecTween
    extends Tween<DefaultTextStyleModifierSpec?> {
  DefaultTextStyleModifierSpecTween({
    super.begin,
    super.end,
  });

  @override
  DefaultTextStyleModifierSpec lerp(double t) {
    if (begin == null && end == null) {
      return const DefaultTextStyleModifierSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}
