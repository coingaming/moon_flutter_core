import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/mix/modifiers/animated_opacity_modifier.dart';
import 'package:moon_core/src/mix/modifiers/animated_shape_decoration_modifier.dart';

void main() {
  testWidgets('Animated opacity modifier applies configuration', (
    tester,
  ) async {
    const key = Key('animated-opacity-target');

    final style = BoxStyler().wrap(
      WidgetModifierConfig.modifier(
        AnimatedOpacityModifierMix(
          opacity: 0.5,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeIn,
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MixScope.empty(
          child: Center(
            child: Box(
              style: style,
              child: const SizedBox(key: key, height: 10, width: 10),
            ),
          ),
        ),
      ),
    );

    final animatedOpacityFinder = find.byType(AnimatedOpacity);
    expect(animatedOpacityFinder, findsOneWidget);

    final animatedOpacityWidget = tester.widget<AnimatedOpacity>(
      animatedOpacityFinder,
    );

    expect(animatedOpacityWidget.opacity, closeTo(0.5, 1e-6));
    expect(animatedOpacityWidget.duration, const Duration(milliseconds: 120));
    expect(animatedOpacityWidget.curve, Curves.easeIn);
  });

  testWidgets('Animated shape decoration modifier animates shape properties', (
    tester,
  ) async {
    const key = Key('animated-shape-target');

    final border = MoonBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(width: 1, color: Colors.deepPurple),
    );

    final style = BoxStyler().wrap(
      WidgetModifierConfig.modifier(
        AnimatedShapeDecorationModifierMix(
          bgColor: Colors.white,
          hoverColor: Colors.blueAccent,
          border: border,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MixScope.empty(
          child: Center(
            child: Box(
              style: style,
              child: const SizedBox(key: key, height: 12, width: 12),
            ),
          ),
        ),
      ),
    );

    final decoratedBoxFinder = find.byWidgetPredicate(
      (widget) =>
          widget is DecoratedBox && widget.decoration is ShapeDecoration,
    );

    expect(decoratedBoxFinder, findsWidgets);

    final decoratedBox = tester.firstWidget<DecoratedBox>(decoratedBoxFinder);
    final decoration = decoratedBox.decoration as ShapeDecoration;

    expect(decoration.shape, border);
    expect(decoration.color, Colors.white);
  });
}
