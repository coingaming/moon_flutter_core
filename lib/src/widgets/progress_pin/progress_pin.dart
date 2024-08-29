import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/progress_pin/pin_style.dart';
import 'package:moon_core/src/widgets/progress_pin/progress_pin_painter.dart';

class MoonProgressPin extends StatelessWidget {
  final double progressValue;
  final PinStyle? pinStyle;
  final String pinText;
  final Widget child;

  /// Creates a Moon Design raw progress pin.
  const MoonProgressPin({
    super.key,
    required this.progressValue,
    this.pinStyle,
    required this.pinText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ProgressPinPainter(
        showShadow: pinStyle?.showShadow ?? true,
        pinColor: pinStyle?.pinColor ?? Colors.black,
        thumbColor: pinStyle?.thumbColor ?? Colors.white,
        shadowColor: pinStyle?.shadowColor ?? Colors.black,
        pinBorderColor: pinStyle?.pinBorderColor ?? Colors.white,
        pinBorderWidth: pinStyle?.pinBorderWidth ?? 2,
        arrowHeight: pinStyle?.arrowHeight ?? 6,
        arrowWidth: pinStyle?.arrowWidth ?? 8,
        pinDistance: pinStyle?.pinDistance ?? 4,
        pinWidth: pinStyle?.pinWidth ?? 36,
        thumbSizeValue: pinStyle?.thumbSizeValue,
        progressValue: progressValue,
        shadowElevation: pinStyle?.shadowElevation ?? 6,
        pinText: pinText,
        textDirection: Directionality.of(context),
        textStyle: pinStyle?.textStyle ?? const TextStyle(color: Colors.white),
      ),
      child: child,
    );
  }
}
