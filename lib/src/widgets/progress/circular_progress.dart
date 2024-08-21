import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/circular_progress_indicator.dart';

class MoonRawCircularProgress extends StatelessWidget {
  /// The color of the circular progress.
  final Color color;

  /// The background color of the circular progress.
  final Color backgroundColor;

  /// The size value of the circular progress.
  final double sizeValue;

  /// The width of the stroke for the circular progress.
  final double strokeWidth;

  /// The progress value of the circular progress.
  final double value;

  /// The semantic label for the circular progress.
  final String? semanticLabel;

  /// The shape of the end of the stroke (stroke-cap) for the circular progress.
  final StrokeCap strokeCap;

  /// Creates a Moon Design raw circular progress.
  const MoonRawCircularProgress({
    super.key,
    this.color = Colors.black,
    this.backgroundColor = Colors.grey,
    this.sizeValue = 40,
    this.strokeWidth = 4,
    required this.value,
    this.semanticLabel,
    this.strokeCap = StrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: SizedBox(
        height: sizeValue,
        width: sizeValue,
        child: MoonCircularProgressIndicator(
          color: color,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
          value: value,
          strokeCap: strokeCap,
        ),
      ),
    );
  }
}
