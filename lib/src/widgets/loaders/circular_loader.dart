import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/circular_progress_indicator.dart';

class MoonRawCircularLoader extends StatelessWidget {
  /// The color of the circular loader.
  final Color color;

  /// The background color of the circular loader.
  final Color backgroundColor;

  /// The custom size value of the circular loader.
  final double sizeValue;

  /// The width of the stroke for the circular loader.
  final double strokeWidth;

  /// The shape of the end of the stroke (stroke-cap) for the circular loader.
  final StrokeCap strokeCap;

  /// Creates a Moon Design circular loader.
  const MoonRawCircularLoader({
    super.key,
    this.color = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.sizeValue = 40,
    this.strokeWidth = 4,
    this.strokeCap = StrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeValue,
      width: sizeValue,
      child: MoonCircularProgressIndicator(
        color: color,
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
        strokeCap: strokeCap,
      ),
    );
  }
}
