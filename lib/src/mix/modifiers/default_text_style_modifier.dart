
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/color/color_tween_premul.dart';

const Curve _kDefaultTextStyleCurve = Curves.easeInOutCubic;

/// Modifier that wraps a widget with [DefaultTextStyle] support.
final class DefaultTextStyleModifier
    extends WidgetModifier<DefaultTextStyleModifier>
    with Diagnosticable {
  final TextStyle style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Duration? duration;
  final Curve curve;

  const DefaultTextStyleModifier({
    TextStyle? style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.duration,
    Curve? curve,
  }) : style = style ?? const TextStyle(),
       curve = curve ?? _kDefaultTextStyleCurve;

  bool get _shouldAnimateColor => duration != null && style.color != null;

  @override
  DefaultTextStyleModifier copyWith({
    TextStyle? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Duration? duration,
    Curve? curve,
  }) {
    return DefaultTextStyleModifier(
      style: style ?? this.style,
      softWrap: softWrap ?? this.softWrap,
      maxLines: maxLines ?? this.maxLines,
      textAlign: textAlign ?? this.textAlign,
      overflow: overflow ?? this.overflow,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  DefaultTextStyleModifier lerp(DefaultTextStyleModifier? other, double t) {
    if (other == null) return this;

    return DefaultTextStyleModifier(
      style: MixOps.lerp(style, other.style, t) ?? style,
      softWrap: MixOps.lerpSnap(softWrap, other.softWrap, t),
      maxLines: MixOps.lerpSnap(maxLines, other.maxLines, t),
      textAlign: MixOps.lerpSnap(textAlign, other.textAlign, t),
      overflow: MixOps.lerpSnap(overflow, other.overflow, t),
      textWidthBasis: MixOps.lerpSnap(textWidthBasis, other.textWidthBasis, t),
      textHeightBehavior: MixOps.lerpSnap(
        textHeightBehavior,
        other.textHeightBehavior,
        t,
      ),
      duration: _lerpDuration(duration, other.duration, t) ?? duration,
      curve: t < 0.5 ? curve : other.curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextStyle>('style', style))
      ..add(FlagProperty('softWrap', value: softWrap, ifTrue: 'soft wrap'))
      ..add(IntProperty('maxLines', maxLines))
      ..add(EnumProperty<TextAlign>('textAlign', textAlign))
      ..add(EnumProperty<TextOverflow>('overflow', overflow))
      ..add(EnumProperty<TextWidthBasis>('textWidthBasis', textWidthBasis))
      ..add(
        DiagnosticsProperty<TextHeightBehavior>(
          'textHeightBehavior',
          textHeightBehavior,
        ),
      )
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(DiagnosticsProperty<Curve>('curve', curve));
  }

  @override
  List<Object?> get props => [
    style,
    softWrap,
    maxLines,
    textAlign,
    overflow,
    textWidthBasis,
    textHeightBehavior,
    duration,
    curve,
  ];

  @override
  Widget build(Widget child) {
    if (!_shouldAnimateColor) {
      return DefaultTextStyle.merge(
        style: style,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        child: child,
      );
    }

    return _AnimatedDefaultTextStyle(modifier: this, child: child);
  }
}

class DefaultTextStyleModifierMix
    extends ModifierMix<DefaultTextStyleModifier> {
  final Prop<TextStyle>? style;
  final Prop<bool>? softWrap;
  final Prop<int>? maxLines;
  final Prop<TextAlign>? textAlign;
  final Prop<TextOverflow>? overflow;
  final Prop<TextWidthBasis>? textWidthBasis;
  final Prop<TextHeightBehavior>? textHeightBehavior;
  final Prop<Duration>? duration;
  final Prop<Curve>? curve;

  const DefaultTextStyleModifierMix.create({
    this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.duration,
    this.curve,
  });

  DefaultTextStyleModifierMix({
    TextStyleMix? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextWidthBasis? textWidthBasis,
    TextHeightBehaviorMix? textHeightBehavior,
    Duration? duration,
    Curve? curve,
  }) : this.create(
         style: Prop.maybeMix(style),
         softWrap: Prop.maybe(softWrap),
         maxLines: Prop.maybe(maxLines),
         textAlign: Prop.maybe(textAlign),
         overflow: Prop.maybe(overflow),
         textWidthBasis: Prop.maybe(textWidthBasis),
         textHeightBehavior: Prop.maybeMix(textHeightBehavior),
         duration: Prop.maybe(duration),
         curve: Prop.maybe(curve),
       );

  @override
  DefaultTextStyleModifier resolve(BuildContext context) {
    return DefaultTextStyleModifier(
      style: MixOps.resolve(context, style),
      softWrap: MixOps.resolve(context, softWrap),
      maxLines: MixOps.resolve(context, maxLines),
      textAlign: MixOps.resolve(context, textAlign),
      overflow: MixOps.resolve(context, overflow),
      textWidthBasis: MixOps.resolve(context, textWidthBasis),
      textHeightBehavior: MixOps.resolve(context, textHeightBehavior),
      duration: MixOps.resolve(context, duration),
      curve: MixOps.resolve(context, curve) ?? _kDefaultTextStyleCurve,
    );
  }

  @override
  DefaultTextStyleModifierMix merge(DefaultTextStyleModifierMix? other) {
    if (other == null) return this;

    return DefaultTextStyleModifierMix.create(
      style: MixOps.merge(style, other.style),
      softWrap: MixOps.merge(softWrap, other.softWrap),
      maxLines: MixOps.merge(maxLines, other.maxLines),
      textAlign: MixOps.merge(textAlign, other.textAlign),
      overflow: MixOps.merge(overflow, other.overflow),
      textWidthBasis: MixOps.merge(textWidthBasis, other.textWidthBasis),
      textHeightBehavior: MixOps.merge(
        textHeightBehavior,
        other.textHeightBehavior,
      ),
      duration: MixOps.merge(duration, other.duration),
      curve: MixOps.merge(curve, other.curve),
    );
  }

  @override
  List<Object?> get props => [
    style,
    softWrap,
    maxLines,
    textAlign,
    overflow,
    textWidthBasis,
    textHeightBehavior,
    duration,
    curve,
  ];
}

final class DefaultTextStyleModifierUtility<T extends Style<Object?>>
    extends MixUtility<T, DefaultTextStyleModifierMix> {
  const DefaultTextStyleModifierUtility(super.utilityBuilder);

  T call({
    TextStyleMix? style,
    bool? softWrap,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextWidthBasis? textWidthBasis,
    TextHeightBehaviorMix? textHeightBehavior,
    Duration? duration,
    Curve? curve,
  }) {
    return utilityBuilder(
      DefaultTextStyleModifierMix(
        style: style,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        duration: duration,
        curve: curve,
      ),
    );
  }
}

class _AnimatedDefaultTextStyle extends StatefulWidget {
  final DefaultTextStyleModifier modifier;
  final Widget child;

  const _AnimatedDefaultTextStyle({
    required this.modifier,
    required this.child,
  });

  @override
  State<_AnimatedDefaultTextStyle> createState() =>
      _AnimatedDefaultTextStyleState();
}

class _AnimatedDefaultTextStyleState extends State<_AnimatedDefaultTextStyle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _textColor;

  final ColorTweenWithPremultipliedAlpha _colorTween =
      ColorTweenWithPremultipliedAlpha();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.modifier.duration,
      vsync: this,
    );

    _textColor = _controller.drive(
      _colorTween.chain(CurveTween(curve: widget.modifier.curve)),
    );

    _colorTween.begin = widget.modifier.style.color;
  }

  @override
  void didUpdateWidget(_AnimatedDefaultTextStyle oldWidget) {
    super.didUpdateWidget(oldWidget);

    final Color? newColor = widget.modifier.style.color;
    final Color? oldColor = oldWidget.modifier.style.color;

    if (newColor != oldColor) {
      _colorTween
        ..begin = _colorTween.end ?? oldColor ?? Colors.transparent
        ..end = newColor ?? Colors.transparent;

      _controller
        ..stop()
        ..forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return DefaultTextStyle.merge(
          style: widget.modifier.style.copyWith(color: _textColor.value),
          softWrap: widget.modifier.softWrap,
          maxLines: widget.modifier.maxLines,
          textAlign: widget.modifier.textAlign,
          overflow: widget.modifier.overflow,
          textWidthBasis: widget.modifier.textWidthBasis,
          textHeightBehavior: widget.modifier.textHeightBehavior,
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

Duration? _lerpDuration(Duration? a, Duration? b, double t) {
  if (a == null && b == null) return null;
  if (a == null) return b;
  if (b == null) return a;

  final interpolated =
      (a.inMicroseconds + ((b.inMicroseconds - a.inMicroseconds) * t)).round();
  return Duration(microseconds: interpolated);
}
