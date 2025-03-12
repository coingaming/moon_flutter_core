import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/src/mix/attributes/icon_theme_data_dto.dart';
import 'package:moon_core/src/utils/color/color_tween_premul.dart';

part 'icon_theme_modifier.g.dart';

/// A modifier that wraps a widget with the [IconTheme] widget.
/// If [animate] properties are provided, the icon color will be animated using
/// the specified [duration] and [curve].
@MixableSpec()
final class IconThemeModifierSpec
    extends WidgetModifierSpec<IconThemeModifierSpec>
    with _$IconThemeModifierSpec {
  final IconThemeData? data;

  /// Returns an [IconTheme] with an animated icon color, using the specified
  /// [duration] and [curve].
  final AnimatedData? animate;

  const IconThemeModifierSpec({
    this.data,
    this.animate,
  });

  bool get _shouldAnimate => animate != null;

  @override
  Widget build(Widget child) {
    return _shouldAnimate
        ? _IconThemeAnimated(
            modifier: this,
            child: child,
          )
        : IconTheme(
            data: data ?? const IconThemeData(),
            child: child,
          );
  }
}

class _IconThemeAnimated extends StatefulWidget {
  final IconThemeModifierSpec modifier;
  final Widget child;

  const _IconThemeAnimated({required this.modifier, required this.child});

  @override
  State<_IconThemeAnimated> createState() => _IconThemeAnimatedState();
}

class _IconThemeAnimatedState extends State<_IconThemeAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<Color?> _iconColor;

  final ColorTweenWithPremultipliedAlpha _iconColorTween =
      ColorTweenWithPremultipliedAlpha();

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      duration: widget.modifier.animate?.duration,
      vsync: this,
    );

    _iconColor = _iconController.drive(
      _iconColorTween.chain(
        CurveTween(
          curve: widget.modifier.animate?.curve ?? Curves.easeInOutCubic,
        ),
      ),
    );

    _iconColorTween.begin = widget.modifier.data?.color;
  }

  @override
  void didUpdateWidget(_IconThemeAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    final Color? newColor = widget.modifier.data?.color;
    final Color? oldColor = oldWidget.modifier.data?.color;

    if (newColor != oldColor) {
      _iconColorTween
        ..begin = _iconColorTween.end ?? oldColor ?? Colors.black
        ..end = newColor ?? Colors.black;

      _iconController
        ..stop()
        ..forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _iconController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _iconController,
      builder: (BuildContext context, Widget? child) {
        return IconTheme(
          data: (widget.modifier.data ?? const IconThemeData())
              .copyWith(color: _iconColor.value),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
