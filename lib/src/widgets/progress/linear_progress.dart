import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/linear_progress_indicator.dart';
import 'package:moon_core/src/widgets/progress_pin/pin_style.dart';
import 'package:moon_core/src/widgets/progress_pin/progress_pin.dart';

class MoonRawLinearProgress extends StatelessWidget {
  /// Whether to show the thumb and the pin for the linear progress.
  final bool showPin;

  /// Whether to show the [minLabel] widget for the linear progress.
  final bool showMinLabel;

  /// Whether to show the [maxLabel] widget for the linear progress.
  final bool showMaxLabel;

  /// Whether the pin height is added to the linear progress height.
  /// Applies only when both this and [showPin] are true.
  /// Otherwise, the pin acts as an overlay without affecting the linear
  /// progress height.
  final bool pinAffectsHeight;

  /// The border radius of the linear progress.
  final BorderRadiusGeometry borderRadius;

  /// The color of the linear progress.
  final Color color;

  /// The background color of the linear progress.
  final Color backgroundColor;

  /// The height of the linear progress.
  final double height;

  /// The vertical gap between the linear progress and the [minLabel] and
  /// [maxLabel] widgets.
  ///
  /// Has effect only if [showMinLabel] and [showMaxLabel] are true.
  final double verticalGap;

  /// The progress value of the linear progress.
  final double value;

  /// The styling options for the linear progress pin.
  final PinStyle? pinStyle;

  /// The semantic label for the linear progress.
  final String? semanticLabel;

  /// The widget to display the minimum progress value of the linear progress.
  final Widget? minLabel;

  /// The widget to display the maximum progress value of the linear progress.
  final Widget? maxLabel;

  /// Creates a Moon Design raw linear progress.
  const MoonRawLinearProgress({
    super.key,
    this.showPin = false,
    this.showMinLabel = false,
    this.showMaxLabel = false,
    this.pinAffectsHeight = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.color = Colors.black,
    this.backgroundColor = Colors.grey,
    this.height = 8,
    this.verticalGap = 6,
    required this.value,
    this.pinStyle,
    this.semanticLabel,
    this.minLabel,
    this.maxLabel,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = borderRadius;

    // This is used to ensure that the corners of the progress bar properly
    // touch the thumb with bigger bar variants.
    final BorderRadiusGeometry progressRadius = switch (effectiveBorderRadius) {
      BorderRadiusDirectional() when showPin == true =>
        BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topStart,
          bottomStart: effectiveBorderRadius.bottomStart,
        ),
      BorderRadius() when showPin == true => BorderRadiusDirectional.only(
          topStart: effectiveBorderRadius.topLeft,
          bottomStart: effectiveBorderRadius.bottomLeft,
        ),
      _ => borderRadius,
    };

    final double effectiveThumbSizeValue = pinStyle?.thumbSizeValue ?? 12;

    final double effectivePinWidth = pinStyle?.pinWidth ?? 36;

    final double effectivePinDistance = pinStyle?.pinDistance ?? 4;

    final double effectivePinArrowHeight = pinStyle?.arrowHeight ?? 6;

    final double resolvedPaddingValue = effectiveThumbSizeValue - height > 0
        ? effectiveThumbSizeValue / 2 - height / 2
        : 0;

    final double heightWithPin = effectivePinWidth +
        effectivePinArrowHeight +
        effectivePinDistance +
        effectiveThumbSizeValue;

    Widget child = MoonLinearProgressIndicator(
      value: value,
      color: color,
      backgroundColor: backgroundColor,
      containerRadius: borderRadius,
      progressRadius: showPin ? progressRadius : borderRadius,
      minHeight: height,
    );

    if (showPin) {
      child = MoonProgressPin(
        progressValue: value,
        pinText: '${(value * 100).round()}%',
        pinStyle: pinStyle?.copyWith(thumbSizeValue: effectiveThumbSizeValue),
        child: child,
      );
    }

    if (showMinLabel || showMaxLabel) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showMinLabel)
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: minLabel ?? const Text("0%"),
                  ),
                ),
              if (showMaxLabel)
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: maxLabel ?? const Text("100%"),
                  ),
                ),
            ],
          ),
          SizedBox(height: verticalGap),
          child,
        ],
      );
    }

    if (showPin && pinAffectsHeight) {
      child = Container(
        height: heightWithPin,
        padding: EdgeInsets.only(bottom: resolvedPaddingValue),
        alignment: Alignment.bottomCenter,
        child: child,
      );
    }

    return Semantics(
      label: semanticLabel,
      value: "${value * 100}%",
      child: child,
    );
  }
}
