import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:moon_core/src/utils/color/color_premul_lerp.dart';

// TODO: Remove this once Flutter transitions from straight alpha to premultiplied alpha for color lerping.
class ShapeDecorationWithPremultipliedAlpha extends ShapeDecoration {
  /// Creates a shape decoration with premultiplied alpha for color lerp.
  /// In others respects, it is identical to [ShapeDecoration].
  ///
  /// * If [color] is null, this decoration does not paint a background color.
  /// * If [gradient] is null, this decoration does not paint gradients.
  /// * If [image] is null, this decoration does not paint a background image.
  /// * If [shadows] is null, this decoration does not paint shadows.
  ///
  /// The [color] and [gradient] properties are mutually exclusive,
  /// one (or both) of them must be null.
  ///
  /// The [shape] must not be null.
  const ShapeDecorationWithPremultipliedAlpha({
    super.color,
    super.image,
    super.gradient,
    super.shadows,
    required super.shape,
  }) : assert(!(color != null && gradient != null));

  /// Creates a shape decoration configured to match a [BoxDecoration].
  ///
  /// The [BoxDecoration] class is more efficient for shapes that it can
  /// describe than the [ShapeDecorationWithPremultipliedAlpha] class is for
  /// those same shapes, because [ShapeDecorationWithPremultipliedAlpha] has to
  /// be more general as it can support any shape. However, having a
  /// [ShapeDecorationWithPremultipliedAlpha] is sometimes necessary, for
  /// example when calling [ShapeDecorationWithPremultipliedAlpha.lerp] to
  /// transition between different shapes (e.g. from a [CircleBorder] to a
  /// [RoundedRectangleBorder]; the [BoxDecoration] class cannot animate the
  /// transition from a [BoxShape.circle] to [BoxShape.rectangle]).
  factory ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(
    BoxDecoration source,
  ) {
    final ShapeBorder shape;

    switch (source.shape) {
      case BoxShape.circle:
        if (source.border != null) {
          assert(source.border!.isUniform);
          shape = CircleBorder(side: source.border!.top);
        } else {
          shape = const CircleBorder();
        }
      case BoxShape.rectangle:
        if (source.borderRadius != null) {
          assert(source.border == null || source.border!.isUniform);
          shape = RoundedRectangleBorder(
            side: source.border?.top ?? BorderSide.none,
            borderRadius: source.borderRadius!,
          );
        } else {
          shape = source.border ?? const Border();
        }
    }

    return ShapeDecorationWithPremultipliedAlpha(
      color: source.color,
      image: source.image,
      gradient: source.gradient,
      shadows: source.boxShadow,
      shape: shape,
    );
  }

  @override
  ShapeDecorationWithPremultipliedAlpha? lerpFrom(Decoration? a, double t) {
    if (a is BoxDecoration) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(a),
        this,
        t,
      );
    } else if (a == null || a is ShapeDecorationWithPremultipliedAlpha) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        a as ShapeDecorationWithPremultipliedAlpha?,
        this,
        t,
      );
    }

    return super.lerpFrom(a, t) as ShapeDecorationWithPremultipliedAlpha?;
  }

  @override
  ShapeDecorationWithPremultipliedAlpha? lerpTo(Decoration? b, double t) {
    if (b is BoxDecoration) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        this,
        ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(b),
        t,
      );
    } else if (b == null || b is ShapeDecorationWithPremultipliedAlpha) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        this,
        b as ShapeDecorationWithPremultipliedAlpha?,
        t,
      );
    }

    return super.lerpTo(b, t) as ShapeDecorationWithPremultipliedAlpha?;
  }

  static ShapeDecorationWithPremultipliedAlpha? lerp(
    ShapeDecorationWithPremultipliedAlpha? a,
    ShapeDecorationWithPremultipliedAlpha? b,
    double t,
  ) {
    if (a == null && b == null) return null;

    if (a != null && b != null) {
      if (t == 0.0) return a;
      if (t == 1.0) return b;
    }

    return ShapeDecorationWithPremultipliedAlpha(
      color: colorPremulLerp(a!.color, b!.color, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
      image: t < 0.5 ? a.image : b.image,
      shadows: BoxShadow.lerpList(a.shadows, b.shadows, t),
      shape: ShapeBorder.lerp(a.shape, b.shape, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ShapeDecorationWithPremultipliedAlpha &&
        other.color == color &&
        other.gradient == gradient &&
        other.image == image &&
        listEquals<BoxShadow>(other.shadows, shadows) &&
        other.shape == shape;
  }

  @override
  int get hashCode => Object.hash(
        color,
        gradient,
        image,
        shape,
        shadows == null ? null : Object.hashAll(shadows!),
      );

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(onChanged != null || image == null);

    return _ShapeDecorationPainter(this, onChanged!);
  }
}

/// An object that paints a [ShapeDecorationWithPremultipliedAlpha] into a canvas.
class _ShapeDecorationPainter extends BoxPainter {
  _ShapeDecorationPainter(this._decoration, VoidCallback onChanged)
      : super(onChanged);

  final ShapeDecorationWithPremultipliedAlpha _decoration;

  Rect? _lastRect;
  TextDirection? _lastTextDirection;
  late Path _outerPath;
  Path? _innerPath;
  Paint? _interiorPaint;
  int? _shadowCount;
  late List<Rect> _shadowBounds;
  late List<Path> _shadowPaths;
  late List<Paint> _shadowPaints;

  @override
  VoidCallback get onChanged => super.onChanged!;

  void _precache(Rect rect, TextDirection? textDirection) {
    if (rect == _lastRect && textDirection == _lastTextDirection) return;

    // This code path is reached either during the initial paint or when the
    // rectangle has changed. In the latter case, only features dependent on the
    // rectangle need to be updated.
    if (_interiorPaint == null &&
        (_decoration.color != null || _decoration.gradient != null)) {
      _interiorPaint = Paint();
      if (_decoration.color != null) {
        _interiorPaint!.color = _decoration.color!;
      }
    }

    if (_decoration.gradient != null) {
      _interiorPaint!.shader = _decoration.gradient!
          .createShader(rect, textDirection: textDirection);
    }

    if (_decoration.shadows != null) {
      if (_shadowCount == null) {
        _shadowCount = _decoration.shadows!.length;
        _shadowPaints = <Paint>[
          ..._decoration.shadows!.map((BoxShadow shadow) => shadow.toPaint()),
        ];
      }

      if (_decoration.shape.preferPaintInterior) {
        _shadowBounds = <Rect>[
          ..._decoration.shadows!.map((BoxShadow shadow) {
            return rect.shift(shadow.offset).inflate(shadow.spreadRadius);
          }),
        ];
      } else {
        _shadowPaths = <Path>[
          ..._decoration.shadows!.map((BoxShadow shadow) {
            return _decoration.shape.getOuterPath(
              rect.shift(shadow.offset).inflate(shadow.spreadRadius),
              textDirection: textDirection,
            );
          }),
        ];
      }
    }

    if (!_decoration.shape.preferPaintInterior &&
        (_interiorPaint != null || _shadowCount != null)) {
      _outerPath =
          _decoration.shape.getOuterPath(rect, textDirection: textDirection);
    }

    if (_decoration.image != null) {
      _innerPath =
          _decoration.shape.getInnerPath(rect, textDirection: textDirection);
    }

    _lastRect = rect;
    _lastTextDirection = textDirection;
  }

  void _paintShadows(Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_shadowCount != null) {
      if (_decoration.shape.preferPaintInterior) {
        for (int index = 0; index < _shadowCount!; index += 1) {
          _decoration.shape.paintInterior(
            canvas,
            _shadowBounds[index],
            _shadowPaints[index],
            textDirection: textDirection,
          );
        }
      } else {
        for (int index = 0; index < _shadowCount!; index += 1) {
          canvas.drawPath(_shadowPaths[index], _shadowPaints[index]);
        }
      }
    }
  }

  void _paintInterior(Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_interiorPaint != null) {
      if (_decoration.shape.preferPaintInterior) {
        _decoration.shape.paintInterior(
          canvas,
          rect,
          _interiorPaint!,
          textDirection: textDirection,
        );
      } else {
        canvas.drawPath(_outerPath, _interiorPaint!);
      }
    }
  }

  DecorationImagePainter? _imagePainter;

  void _paintImage(Canvas canvas, ImageConfiguration configuration) {
    if (_decoration.image == null) return;

    _imagePainter ??= _decoration.image!.createPainter(onChanged);
    _imagePainter!.paint(canvas, _lastRect!, _innerPath, configuration);
  }

  @override
  void dispose() {
    _imagePainter?.dispose();

    super.dispose();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = offset & configuration.size!;
    final TextDirection? textDirection = configuration.textDirection;

    _precache(rect, textDirection);
    _paintShadows(canvas, rect, textDirection);
    _paintInterior(canvas, rect, textDirection);
    _paintImage(canvas, configuration);

    _decoration.shape.paint(canvas, rect, textDirection: textDirection);
  }
}
