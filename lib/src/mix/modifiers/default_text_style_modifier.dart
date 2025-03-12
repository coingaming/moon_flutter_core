import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

import 'package:moon_core/src/utils/color/color_tween_premul.dart';

part 'default_text_style_modifier.g.dart';

/// A modifier that wraps a widget with the [DefaultTextStyle] widget.
/// If [animate] properties are provided, the text color will be animated using
/// the specified [duration] and [curve].
@MixableSpec()
final class DefaultTextStyleModifierSpec
    extends WidgetModifierSpec<DefaultTextStyleModifierSpec>
    with _$DefaultTextStyleModifierSpec {
  final TextStyle? style;
  final bool? softWrap;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;

  @MixableProperty(dto: MixableFieldDto(type: TextHeightBehaviorDto))
  final TextHeightBehavior? textHeightBehavior;

  /// Returns a [DefaultTextStyle] with an animated text color, using the
  /// specified [duration] and [curve].
  final AnimatedData? animate;

  const DefaultTextStyleModifierSpec({
    this.style,
    this.softWrap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.animate,
  });

  bool get _shouldAnimate => animate != null;

  @override
  Widget build(Widget child) {
    return _shouldAnimate
        ? _DefaultTextStyleAnimated(
            modifier: this,
            child: child,
          )
        : DefaultTextStyle.merge(
            style: style,
            softWrap: softWrap,
            maxLines: maxLines,
            textAlign: textAlign,
            overflow: overflow,
            textWidthBasis: textWidthBasis,
            child: child,
          );
  }
}

class _DefaultTextStyleAnimated extends StatefulWidget {
  final DefaultTextStyleModifierSpec modifier;
  final Widget child;

  const _DefaultTextStyleAnimated({
    required this.modifier,
    required this.child,
  });

  @override
  State<_DefaultTextStyleAnimated> createState() =>
      _DefaultTextStyleAnimatedState();
}

class _DefaultTextStyleAnimatedState extends State<_DefaultTextStyleAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<Color?> _textColor;

  final ColorTweenWithPremultipliedAlpha _textColorTween =
      ColorTweenWithPremultipliedAlpha();

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      duration: widget.modifier.animate?.duration,
      vsync: this,
    );
    _textColor = _textController.drive(
      _textColorTween.chain(
        CurveTween(
          curve: widget.modifier.animate?.curve ?? Curves.easeInOutCubic,
        ),
      ),
    );
    _textColorTween.begin ??= widget.modifier.style?.color ?? Colors.black;
  }

  @override
  void didUpdateWidget(_DefaultTextStyleAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    final Color? newColor = widget.modifier.style?.color;
    final Color? oldColor = oldWidget.modifier.style?.color;

    if (newColor != oldColor) {
      _textColorTween
        ..begin = _textColorTween.end ?? oldColor ?? Colors.black
        ..end = newColor ?? Colors.black;

      _textController
        ..stop()
        ..forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (BuildContext context, Widget? child) {
        return DefaultTextStyle.merge(
          style: widget.modifier.style?.copyWith(color: _textColor.value),
          softWrap: widget.modifier.softWrap,
          maxLines: widget.modifier.maxLines,
          textAlign: widget.modifier.textAlign,
          overflow: widget.modifier.overflow,
          textWidthBasis: widget.modifier.textWidthBasis,
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
