import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/mix/attributes/moon_border_dto.dart';
import 'package:moon_core/src/utils/color/color_premul_lerp.dart';

part 'animated_shape_decoration_modifier.g.dart';

/// A modifier that wraps a widget with animated pre-multiplied alpha shape decoration.
@MixableSpec(skipUtility: true)
final class AnimatedShapeDecorationModifierSpec
    extends WidgetModifierSpec<AnimatedShapeDecorationModifierSpec>
    with _$AnimatedShapeDecorationModifierSpec, Diagnosticable {
  @MixableProperty(dto: MixableFieldDto(type: ColorDto))
  final Color? bgColor;

  @MixableProperty(dto: MixableFieldDto(type: ColorDto))
  final Color? hoverColor;

  @MixableProperty(dto: MixableFieldDto(type: MoonBorderDto))
  final MoonBorder? border;

  final Duration duration;
  final Curve curve;

  const AnimatedShapeDecorationModifierSpec({
    this.bgColor,
    this.hoverColor,
    this.border,
    Duration? duration,
    Curve? curve,
  })  : duration = duration ?? const Duration(milliseconds: 200),
        curve = curve ?? Curves.fastOutSlowIn;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    _debugFillProperties(properties);
  }

  @override
  AnimatedShapeDecorationModifierSpec lerp(
    AnimatedShapeDecorationModifierSpec? other,
    double t,
  ) {
    if (other == null) return this;

    return AnimatedShapeDecorationModifierSpec(
      bgColor: colorPremulLerp(bgColor, other.bgColor, t),
      hoverColor: colorPremulLerp(hoverColor, other.hoverColor, t),
      duration: lerpDuration(duration, other.duration, t),
      curve: other.curve,
      border: MoonBorder(
        borderRadius: BorderRadiusGeometry.lerp(
          border?.borderRadius,
          other.border?.borderRadius,
          t,
        )!,
        side: BorderSide(
          width: lerpDouble(border?.side.width, other.border?.side.width, t)!,
          color: colorPremulLerp(
            border?.side.color,
            other.border?.side.color,
            t,
          )!,
        ),
      ),
    );
  }

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
  _AnimatedShapeDecorationState createState() =>
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
    return AnimatedBuilder(
      animation: Listenable.merge([
        _borderAnimation ?? kAlwaysDismissedAnimation,
        _bgController ?? kAlwaysDismissedAnimation,
      ]),
      builder: (BuildContext context, Widget? child) {
        return DecoratedBox(
          decoration: ShapeDecorationWithPremultipliedAlpha(
            color: _backgroundColor?.value,
            shape: _borderTween != null
                ? _borderTween!.evaluate(_borderAnimation!)!
                : const MoonBorder(),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

final class AnimatedShapeDecorationModifierSpecUtility<T extends Attribute>
    extends MixUtility<T, AnimatedShapeDecorationModifierSpecAttribute> {
  const AnimatedShapeDecorationModifierSpecUtility(super.builder);

  T call({
    Color? bgColor,
    Color? hoverColor,
    MoonBorder? border,
    Duration? duration,
    Curve? curve,
  }) {
    return builder(
      AnimatedShapeDecorationModifierSpecAttribute(
        bgColor: bgColor?.toDto(),
        hoverColor: hoverColor?.toDto(),
        border: border?.toDto(),
        duration: duration,
        curve: curve,
      ),
    );
  }
}
