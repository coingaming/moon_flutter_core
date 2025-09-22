import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/utils/color/color_premul_lerp.dart';

/// Modifier that wraps a widget with animated shape decoration support.
final class AnimatedShapeDecorationModifier
    extends WidgetModifier<AnimatedShapeDecorationModifier>
    with Diagnosticable {
  final Color? bgColor;
  final Color? hoverColor;
  final MoonBorder? border;
  final Duration duration;
  final Curve curve;

  const AnimatedShapeDecorationModifier({
    this.bgColor,
    this.hoverColor,
    this.border,
    Duration? duration,
    Curve? curve,
  })  : duration = duration ?? _kDefaultDuration,
        curve = curve ?? _kDefaultCurve;

  @override
  AnimatedShapeDecorationModifier copyWith({
    Color? bgColor,
    Color? hoverColor,
    MoonBorder? border,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedShapeDecorationModifier(
      bgColor: bgColor ?? this.bgColor,
      hoverColor: hoverColor ?? this.hoverColor,
      border: border ?? this.border,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  AnimatedShapeDecorationModifier lerp(
    AnimatedShapeDecorationModifier? other,
    double t,
  ) {
    if (other == null) return this;

    return AnimatedShapeDecorationModifier(
      bgColor: colorPremulLerp(bgColor, other.bgColor, t),
      hoverColor: colorPremulLerp(hoverColor, other.hoverColor, t),
      border: _lerpMoonBorder(border, other.border, t),
      duration: _lerpDuration(duration, other.duration, t) ?? duration,
      curve: t < 0.5 ? curve : other.curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('bgColor', bgColor))
      ..add(ColorProperty('hoverColor', hoverColor))
      ..add(DiagnosticsProperty<MoonBorder>('border', border))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(DiagnosticsProperty<Curve>('curve', curve));
  }

  @override
  List<Object?> get props => [bgColor, hoverColor, border, duration, curve];

  @override
  Widget build(Widget child) {
    return _AnimatedShapeDecoration(
      bgColor: bgColor,
      hoverColor: hoverColor,
      border: border,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class AnimatedShapeDecorationModifierMix
    extends ModifierMix<AnimatedShapeDecorationModifier> {
  final Prop<Color>? bgColor;
  final Prop<Color>? hoverColor;
  final Prop<MoonBorder>? border;
  final Prop<Duration>? duration;
  final Prop<Curve>? curve;

  const AnimatedShapeDecorationModifierMix.create({
    this.bgColor,
    this.hoverColor,
    this.border,
    this.duration,
    this.curve,
  });

  AnimatedShapeDecorationModifierMix({
    Color? bgColor,
    Color? hoverColor,
    MoonBorderMix? borderMix,
    MoonBorder? border,
    Duration? duration,
    Curve? curve,
  }) : this.create(
         bgColor: Prop.maybe(bgColor),
         hoverColor: Prop.maybe(hoverColor),
         border: Prop.maybeMix(borderMix ?? MoonBorderMix.maybeValue(border)),
         duration: Prop.maybe(duration),
         curve: Prop.maybe(curve),
       );

  @override
  AnimatedShapeDecorationModifier resolve(BuildContext context) {
    return AnimatedShapeDecorationModifier(
      bgColor: MixOps.resolve(context, bgColor),
      hoverColor: MixOps.resolve(context, hoverColor),
      border: MixOps.resolve(context, border),
      duration:
          MixOps.resolve(context, duration) ?? _kDefaultDuration,
      curve: MixOps.resolve(context, curve) ?? _kDefaultCurve,
    );
  }

  @override
  AnimatedShapeDecorationModifierMix merge(
    AnimatedShapeDecorationModifierMix? other,
  ) {
    if (other == null) return this;

    return AnimatedShapeDecorationModifierMix.create(
      bgColor: MixOps.merge(bgColor, other.bgColor),
      hoverColor: MixOps.merge(hoverColor, other.hoverColor),
      border: MixOps.merge(border, other.border),
      duration: MixOps.merge(duration, other.duration),
      curve: MixOps.merge(curve, other.curve),
    );
  }

  @override
  List<Object?> get props => [bgColor, hoverColor, border, duration, curve];
}

final class AnimatedShapeDecorationModifierUtility<T extends Style<Object?>>
    extends MixUtility<T, AnimatedShapeDecorationModifierMix> {
  const AnimatedShapeDecorationModifierUtility(super.utilityBuilder);

  T call({
    Color? bgColor,
    Color? hoverColor,
    MoonBorderMix? borderMix,
    MoonBorder? border,
    Duration? duration,
    Curve? curve,
  }) {
    return utilityBuilder(
      AnimatedShapeDecorationModifierMix(
        bgColor: bgColor,
        hoverColor: hoverColor,
        borderMix: borderMix,
        border: border,
        duration: duration,
        curve: curve,
      ),
    );
  }
}

class _AnimatedShapeDecoration extends StatefulWidget {
  final Color? bgColor;
  final Color? hoverColor;
  final MoonBorder? border;
  final Duration duration;
  final Curve curve;
  final Widget child;

  /// Creates a utility widget for animating the border and color properties of
  /// shape decoration.
  const _AnimatedShapeDecoration({
    this.bgColor,
    this.hoverColor,
    required this.border,
    required this.duration,
    required this.curve,
    required this.child,
  });

  @override
  State<_AnimatedShapeDecoration> createState() =>
      _AnimatedShapeDecorationState();
}

class _AnimatedShapeDecorationState extends State<_AnimatedShapeDecoration>
    with TickerProviderStateMixin {
  AnimationController? _borderController;
  Animation<double>? _borderAnimation;
  ShapeBorderTween? _borderTween;

  ColorTweenWithPremultipliedAlpha? _backgroundColorTween;
  AnimationController? _bgController;
  Animation<Color?>? _backgroundColor;

  void _ensureBorderAnimationInitialized() {
    if (_borderController == null && widget.border != null) {
      _borderController ??= AnimationController(
        duration: widget.duration,
        vsync: this,
      );

      _borderTween ??= ShapeBorderTween(begin: widget.border);

      _borderAnimation ??= CurvedAnimation(
        parent: _borderController!,
        curve: widget.curve,
        reverseCurve: widget.curve.flipped,
      );
    }
  }

  void _ensureBackgroundAnimationInitialized() {
    if (_bgController == null &&
        (widget.bgColor != null || widget.hoverColor != null)) {
      _bgController ??= AnimationController(
        duration: widget.duration,
        vsync: this,
      );
      _backgroundColorTween ??=
          ColorTweenWithPremultipliedAlpha(begin: widget.bgColor);

      _backgroundColor ??= _bgController!.drive(
        _backgroundColorTween!.chain(CurveTween(curve: widget.curve)),
      );
    }
  }

  void _updateBorderAnimation(MoonBorder? oldBorder) {
    if (widget.border != oldBorder) {
      _ensureBorderAnimationInitialized();

      _borderTween!
        ..begin = _borderTween!.end ?? oldBorder ?? const MoonBorder()
        ..end = widget.border ?? const MoonBorder();

      if (_borderController != null) {
        _borderController!
          ..stop()
          ..forward(from: 0.0);
      }
    }
  }

  void _updateBackgroundAnimation(Color? oldBgColor, Color? oldHoverColor) {
    if ((widget.bgColor != oldBgColor) || widget.hoverColor != oldHoverColor) {
      _ensureBackgroundAnimationInitialized();

      _backgroundColorTween!
        ..begin = _backgroundColorTween!.end ?? oldBgColor ?? Colors.transparent
        ..end = widget.hoverColor != null
            ? Color.alphaBlend(
                widget.hoverColor!,
                widget.bgColor ?? _backgroundColor?.value ?? widget.hoverColor!,
              )
            : widget.bgColor ?? Colors.transparent;

      if (_bgController != null) {
        _bgController!
          ..stop()
          ..forward(from: 0.0);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _ensureBorderAnimationInitialized();
    _ensureBackgroundAnimationInitialized();
  }

  @override
  void didUpdateWidget(_AnimatedShapeDecoration oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateBorderAnimation(oldWidget.border);
    _updateBackgroundAnimation(oldWidget.bgColor, oldWidget.hoverColor);
  }

  @override
  void dispose() {
    _borderController?.dispose();
    _bgController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_borderController != null && _borderAnimation != null) {
      _borderTween!.end = widget.border ?? const MoonBorder();
    }

    final Listenable animation;
    if (_borderController != null && _bgController != null) {
      animation = Listenable.merge([
        _borderController!,
        _bgController!,
      ]);
    } else {
      animation = _borderController ??
          _bgController ??
          const AlwaysStoppedAnimation<double>(0);
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return DecoratedBox(
          decoration: ShapeDecoration(
            color: _backgroundColor?.value ?? widget.bgColor,
            shape: _borderAnimation != null && _borderTween != null
                ? _borderTween!.transform(
                    _borderAnimation!.value,
                  )
                : widget.border ?? const MoonBorder(),
          ),
          child: child,
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

MoonBorder? _lerpMoonBorder(MoonBorder? a, MoonBorder? b, double t) {
  if (a == null && b == null) return null;

  final first = a ?? const MoonBorder();
  final second = b ?? const MoonBorder();

  return MoonBorder(
    borderRadius: BorderRadiusGeometry.lerp(
      first.borderRadius,
      second.borderRadius,
      t,
    )!,
    side: MoonBorderSide.lerp(first.side, second.side, t),
    borderAlign: t < 0.5 ? first.borderAlign : second.borderAlign,
  );
}

const Duration _kDefaultDuration = Duration(milliseconds: 200);
const Curve _kDefaultCurve = Curves.fastOutSlowIn;
