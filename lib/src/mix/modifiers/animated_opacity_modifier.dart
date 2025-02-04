import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'animated_opacity_modifier.g.dart';

/// A modifier that wraps a widget with the [AnimatedOpacity] widget.
///
/// The [AnimatedOpacity] widget is used to make a widget partially transparent.
@MixableSpec(skipUtility: true)
final class AnimatedOpacityModifierSpec
    extends WidgetModifierSpec<AnimatedOpacityModifierSpec>
    with _$AnimatedOpacityModifierSpec, Diagnosticable {
  /// The [opacity] argument must not be null and must be between 0.0 and 1.0 (inclusive).
  final double opacity;

  /// The duration over which opacity changes.
  final Duration? duration;

  /// The animation curve for the opacity transition.
  final Curve? curve;

  const AnimatedOpacityModifierSpec({
    double? opacity,
    this.duration,
    this.curve,
  }) : opacity = opacity ?? 1.0;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    _debugFillProperties(properties);
  }

  @override
  Widget build(Widget child) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration ?? const Duration(milliseconds: 200),
      curve: curve ?? Curves.linear,
      child: child,
    );
  }
}

final class AnimatedOpacityModifierSpecUtility<T extends Attribute>
    extends MixUtility<T, AnimatedOpacityModifierSpecAttribute> {
  const AnimatedOpacityModifierSpecUtility(super.builder);

  T call({required double opacity, Duration? duration, Curve? curve}) {
    return builder(
      AnimatedOpacityModifierSpecAttribute(
        opacity: opacity,
        duration: duration,
        curve: curve,
      ),
    );
  }
}
