import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/linear_progress_indicator.dart';

class MoonRawLinearLoader extends StatelessWidget {
  /// The border radius of the linear loader.
  final BorderRadiusGeometry borderRadius;

  /// The color of the linear loader.
  final Color color;

  /// The background color of the linear loader.
  final Color backgroundColor;

  /// The height of the linear loader.
  final double height;

  /// Creates a Moon Design linear loader.
  const MoonRawLinearLoader({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return MoonLinearProgressIndicator(
      color: color,
      backgroundColor: backgroundColor,
      containerRadius: borderRadius,
      progressRadius: borderRadius,
      minHeight: height,
    );
  }
}
