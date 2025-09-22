import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/color/color_tween_premul.dart';

const Curve _kDefaultIconThemeCurve = Curves.easeInOutCubic;

/// Modifier that applies icon theme data to its descendants.
///
/// Wraps the child in an [IconTheme] widget with the specified theme data.
final class IconThemeModifier extends WidgetModifier<IconThemeModifier>
    with Diagnosticable {
  final IconThemeData data;
  final Duration? duration;
  final Curve curve;

  const IconThemeModifier({
    IconThemeData? data,
    this.duration,
    Curve? curve,
  })  : data = data ?? const IconThemeData(),
        curve = curve ?? _kDefaultIconThemeCurve;

  bool get _shouldAnimateColor => duration != null && data.color != null;

  @override
  IconThemeModifier copyWith({
    IconThemeData? data,
    Duration? duration,
    Curve? curve,
  }) {
    return IconThemeModifier(
      data: data ?? this.data,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  IconThemeModifier lerp(IconThemeModifier? other, double t) {
    if (other == null) return this;

    return IconThemeModifier(
      data: MixOps.lerp(data, other.data, t) ?? data,
      duration: _lerpDuration(duration, other.duration, t) ?? duration,
      curve: t < 0.5 ? curve : other.curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('curve', curve));
  }

  @override
  List<Object?> get props => [data, duration, curve];

  @override
  Widget build(Widget child) {
    if (!_shouldAnimateColor) {
      return IconTheme(data: data, child: child);
    }

    return _AnimatedIconTheme(
      modifier: this,
      child: child,
    );
  }
}

/// Represents the attributes of an [IconThemeModifier].
class IconThemeModifierMix extends ModifierMix<IconThemeModifier> {
  final Prop<Color>? color;
  final Prop<double>? size;
  final Prop<double>? fill;
  final Prop<double>? weight;
  final Prop<double>? grade;
  final Prop<double>? opticalSize;
  final Prop<double>? opacity;
  final Prop<List<Shadow>>? shadows;
  final Prop<bool>? applyTextScaling;
  final Prop<Duration>? duration;
  final Prop<Curve>? curve;

  const IconThemeModifierMix.create({
    this.color,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.opacity,
    this.shadows,
    this.applyTextScaling,
    this.duration,
    this.curve,
  });

  IconThemeModifierMix({
    Color? color,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    double? opacity,
    List<ShadowMix>? shadows,
    bool? applyTextScaling,
    Duration? duration,
    Curve? curve,
  }) : this.create(
         color: Prop.maybe(color),
         size: Prop.maybe(size),
         fill: Prop.maybe(fill),
         weight: Prop.maybe(weight),
         grade: Prop.maybe(grade),
         opticalSize: Prop.maybe(opticalSize),
         opacity: Prop.maybe(opacity),
         shadows: shadows != null ? Prop.mix(ShadowListMix(shadows)) : null,
         applyTextScaling: Prop.maybe(applyTextScaling),
         duration: Prop.maybe(duration),
         curve: Prop.maybe(curve),
       );

  @override
  IconThemeModifier resolve(BuildContext context) {
    return IconThemeModifier(
      data: IconThemeData(
        size: MixOps.resolve(context, size),
        fill: MixOps.resolve(context, fill),
        weight: MixOps.resolve(context, weight),
        grade: MixOps.resolve(context, grade),
        opticalSize: MixOps.resolve(context, opticalSize),
        color: MixOps.resolve(context, color),
        opacity: MixOps.resolve(context, opacity),
        shadows: MixOps.resolve(context, shadows),
        applyTextScaling: MixOps.resolve(context, applyTextScaling),
      ),
      duration: MixOps.resolve(context, duration),
      curve: MixOps.resolve(context, curve) ?? _kDefaultIconThemeCurve,
    );
  }

  @override
  IconThemeModifierMix merge(IconThemeModifierMix? other) {
    if (other == null) return this;

    return IconThemeModifierMix.create(
      color: MixOps.merge(color, other.color),
      size: MixOps.merge(size, other.size),
      fill: MixOps.merge(fill, other.fill),
      weight: MixOps.merge(weight, other.weight),
      grade: MixOps.merge(grade, other.grade),
      opticalSize: MixOps.merge(opticalSize, other.opticalSize),
      opacity: MixOps.merge(opacity, other.opacity),
      shadows: MixOps.merge(shadows, other.shadows),
      applyTextScaling: MixOps.merge(applyTextScaling, other.applyTextScaling),
      duration: MixOps.merge(duration, other.duration),
      curve: MixOps.merge(curve, other.curve),
    );
  }

  @override
  List<Object?> get props => [
        color,
        size,
        fill,
        weight,
        grade,
        opticalSize,
        opacity,
        shadows,
        applyTextScaling,
        duration,
        curve,
      ];
}

final class IconThemeModifierUtility<T extends Style<Object?>>
    extends MixUtility<T, IconThemeModifierMix> {
  const IconThemeModifierUtility(super.utilityBuilder);

  T call({
    Color? color,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    double? opacity,
    List<ShadowMix>? shadows,
    bool? applyTextScaling,
    Duration? duration,
    Curve? curve,
  }) {
    return utilityBuilder(
      IconThemeModifierMix(
        color: color,
        size: size,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        opacity: opacity,
        shadows: shadows,
        applyTextScaling: applyTextScaling,
        duration: duration,
        curve: curve,
      ),
    );
  }
}

class _AnimatedIconTheme extends StatefulWidget {
  final IconThemeModifier modifier;
  final Widget child;

  const _AnimatedIconTheme({required this.modifier, required this.child});

  @override
  State<_AnimatedIconTheme> createState() => _AnimatedIconThemeState();
}

class _AnimatedIconThemeState extends State<_AnimatedIconTheme>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  final ColorTweenWithPremultipliedAlpha _colorTween =
      ColorTweenWithPremultipliedAlpha();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.modifier.duration,
      vsync: this,
    );

    _color = _controller.drive(
      _colorTween.chain(CurveTween(curve: widget.modifier.curve)),
    );

    _colorTween.begin = widget.modifier.data.color;
  }

  @override
  void didUpdateWidget(_AnimatedIconTheme oldWidget) {
    super.didUpdateWidget(oldWidget);

    final Color? newColor = widget.modifier.data.color;
    final Color? oldColor = oldWidget.modifier.data.color;

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
        return IconTheme(
          data: widget.modifier.data.copyWith(color: _color.value),
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
