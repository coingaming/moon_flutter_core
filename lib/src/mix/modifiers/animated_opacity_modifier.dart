import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:mix/mix.dart';

const _kDefaultOpacity = 1.0;
const Duration _kAnimatedOpacityDuration = Duration(milliseconds: 200);
const Curve _kAnimatedOpacityCurve = Curves.linear;

/// Modifier that wraps a widget with [AnimatedOpacity].
final class AnimatedOpacityModifier
    extends WidgetModifier<AnimatedOpacityModifier>
    with Diagnosticable {
  final double opacity;
  final Duration duration;
  final Curve curve;

  const AnimatedOpacityModifier({
    double? opacity,
    Duration? duration,
    Curve? curve,
  }) : opacity = opacity ?? _kDefaultOpacity,
       duration = duration ?? _kAnimatedOpacityDuration,
       curve = curve ?? _kAnimatedOpacityCurve;

  @override
  AnimatedOpacityModifier copyWith({
    double? opacity,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedOpacityModifier(
      opacity: opacity ?? this.opacity,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  AnimatedOpacityModifier lerp(AnimatedOpacityModifier? other, double t) {
    if (other == null) return this;

    return AnimatedOpacityModifier(
      opacity: lerpDouble(opacity, other.opacity, t),
      duration: _lerpDuration(duration, other.duration, t) ?? duration,
      curve: t < 0.5 ? curve : other.curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('opacity', opacity))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(DiagnosticsProperty<Curve>('curve', curve));
  }

  @override
  List<Object?> get props => [opacity, duration, curve];

  @override
  Widget build(Widget child) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class AnimatedOpacityModifierMix extends ModifierMix<AnimatedOpacityModifier> {
  final Prop<double>? opacity;
  final Prop<Duration>? duration;
  final Prop<Curve>? curve;

  const AnimatedOpacityModifierMix.create({
    this.opacity,
    this.duration,
    this.curve,
  });

  AnimatedOpacityModifierMix({
    double? opacity,
    Duration? duration,
    Curve? curve,
  }) : this.create(
         opacity: Prop.maybe(opacity),
         duration: Prop.maybe(duration),
         curve: Prop.maybe(curve),
       );

  @override
  AnimatedOpacityModifier resolve(BuildContext context) {
    return AnimatedOpacityModifier(
      opacity: MixOps.resolve(context, opacity) ?? _kDefaultOpacity,
      duration: MixOps.resolve(context, duration) ?? _kAnimatedOpacityDuration,
      curve: MixOps.resolve(context, curve) ?? _kAnimatedOpacityCurve,
    );
  }

  @override
  AnimatedOpacityModifierMix merge(AnimatedOpacityModifierMix? other) {
    if (other == null) return this;

    return AnimatedOpacityModifierMix.create(
      opacity: MixOps.merge<Prop<double>, double>(opacity, other.opacity),
      duration:
          MixOps.merge<Prop<Duration>, Duration>(duration, other.duration),
      curve: MixOps.merge<Prop<Curve>, Curve>(curve, other.curve),
    );
  }

  @override
  List<Object?> get props => [opacity, duration, curve];
}

final class AnimatedOpacityModifierUtility<T extends Style<Object?>>
    extends MixUtility<T, AnimatedOpacityModifierMix> {
  const AnimatedOpacityModifierUtility(super.utilityBuilder);

  T call({double? opacity, Duration? duration, Curve? curve}) {
    return utilityBuilder(
      AnimatedOpacityModifierMix(
        opacity: opacity,
        duration: duration,
        curve: curve,
      ),
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
