import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

typedef MoonDotBuilder = Widget Function(int index, Color color);

class MoonRawDotIndicator extends StatefulWidget {
  /// The color of the selected dot.
  final Color? selectedColor;

  /// The color of the unselected dots.
  final Color? unselectedColor;

  /// The duration of the dot indicator transition animation.
  final Duration transitionDuration;

  /// The curve of the dot indicator transition animation.
  final Curve transitionCurve;

  /// The builder for the indicator dots.
  final MoonDotBuilder dotBuilder;

  /// The index of the currently selected dot.
  final int selectedDot;

  /// The total number of dots to build for the indicator.
  final int dotCount;

  /// Style for the dot indicator.
  final Style? dotIndicatorStyle;

  /// Creates a Moon Design raw dot indicator.
  const MoonRawDotIndicator({
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.grey,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    required this.selectedDot,
    required this.dotCount,
    required this.dotBuilder,
    this.dotIndicatorStyle,
  });

  @override
  _MoonRawDotIndicatorState createState() => _MoonRawDotIndicatorState();
}

class _MoonRawDotIndicatorState extends State<MoonRawDotIndicator>
    with TickerProviderStateMixin {
  final ColorTweenWithPremultipliedAlpha _dotColorTween =
      ColorTweenWithPremultipliedAlpha();

  late List<AnimationController> _animationControllers;
  late List<Animation<Color?>> _animations;

  @override
  void initState() {
    super.initState();

    _animationControllers = List.generate(
      widget.dotCount,
      (int index) => AnimationController(
        duration: widget.transitionDuration,
        vsync: this,
      ),
    );

    _animations = List.generate(
      widget.dotCount,
      (int index) => _animationControllers[index].drive(
        _dotColorTween.chain(
          CurveTween(curve: widget.transitionCurve),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      _animationControllers[widget.selectedDot].forward();
    });
  }

  @override
  void didUpdateWidget(MoonRawDotIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedDot != oldWidget.selectedDot) {
      _animationControllers[oldWidget.selectedDot].reverse();
      _animationControllers[widget.selectedDot].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dotColorTween
      ..begin = widget.unselectedColor
      ..end = widget.selectedColor;

    return RepaintBoundary(
      child: StyledRow(
        style: widget.dotIndicatorStyle,
        children: List<Widget>.generate(
          widget.dotCount,
          (int index) => AnimatedBuilder(
            animation: _animations[index],
            builder: (BuildContext context, Widget? _) {
              return widget.dotBuilder(index, _animations[index].value!);
            },
          ),
        ),
      ),
    );
  }
}
