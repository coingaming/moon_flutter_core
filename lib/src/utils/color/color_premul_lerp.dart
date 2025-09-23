import 'dart:ui';

Color _scaleAlpha(Color a, double factor) {
  final double scaledAlpha = (a.a * factor).clamp(0, 1);

  return a.withValues(alpha: scaledAlpha);
}

/// Workaround for Flutter's use of straight alpha instead of premultiplied alpha for color lerping.
Color? colorPremulLerp(Color? a, Color? b, double t) {
  if (b == null) {
    if (a == null) {
      return null;
    } else {
      return _scaleAlpha(a, 1.0 - t);
    }
  } else {
    if (a == null) {
      return _scaleAlpha(b, t);
    } else {
      final weight1 = (1 - t) * a.a;
      final weight2 = t * b.a;
      final summedWeight = weight1 + weight2;
      final w = summedWeight > 0.000001 ? weight2 / summedWeight : 0.5;

      return Color.fromARGB(
        ((lerpDouble(a.a, b.a, t) ?? 0).clamp(0, 1) * 255)
            .round()
            .clamp(0, 255),
        ((lerpDouble(a.r, b.r, w) ?? 0).clamp(0, 1) * 255)
            .round()
            .clamp(0, 255),
        ((lerpDouble(a.g, b.g, w) ?? 0).clamp(0, 1) * 255)
            .round()
            .clamp(0, 255),
        ((lerpDouble(a.b, b.b, w) ?? 0).clamp(0, 1) * 255)
            .round()
            .clamp(0, 255),
      );
    }
  }
}
