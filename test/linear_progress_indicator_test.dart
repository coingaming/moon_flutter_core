import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/linear_progress_indicator.dart';
import 'package:moon_core/src/widgets/common/progress_indicators/painters/linear_progress_indicator_painter.dart';

void main() {
  final Finder progressIndicator = find.byType(MoonLinearProgressIndicator);
  final Finder customPainterFinder = find.descendant(
    of: progressIndicator,
    matching: find.byType(CustomPaint),
  );

  testWidgets("Indicator is continuously animating in indeterminate state", (
    WidgetTester tester,
  ) async {
    double getAnimationValue() {
      final CustomPaint customPaint = tester.widget(customPainterFinder);
      return (customPaint.painter! as MoonLinearProgressIndicatorPainter)
          .animationValue;
    }

    await tester.pumpWidget(const _LinearProgressIndicatorTestWidget());

    expect(getAnimationValue(), 0.0);

    await tester.pump(const Duration(milliseconds: 500));

    final firstRotationValue = getAnimationValue();
    expect(firstRotationValue, greaterThan(0.0));

    await tester.pump(const Duration(milliseconds: 500));

    expect(getAnimationValue(), greaterThan(firstRotationValue));
  });

  testWidgets("Indicator is not continuously animating in determinate state", (
    WidgetTester tester,
  ) async {
    double getAnimationValue() {
      final CustomPaint customPaint = tester.widget(customPainterFinder);
      return (customPaint.painter! as MoonLinearProgressIndicatorPainter)
          .animationValue;
    }

    await tester.pumpWidget(
      const _LinearProgressIndicatorTestWidget(value: 0.5),
    );

    expect(getAnimationValue(), 0.0);

    await tester.pump(const Duration(milliseconds: 500));

    expect(getAnimationValue(), 0.0);

    await tester.pump(const Duration(milliseconds: 500));

    expect(getAnimationValue(), 0.0);
  });

  testWidgets("Indicator has correct progress value", (tester) async {
    await tester.pumpWidget(
      const _LinearProgressIndicatorTestWidget(value: 0.5),
    );

    final MoonLinearProgressIndicator indicator = tester.widget(
      progressIndicator,
    );

    expect(indicator.value, 0.5);
  });
}

class _LinearProgressIndicatorTestWidget extends StatelessWidget {
  final double? value;

  const _LinearProgressIndicatorTestWidget({this.value});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonLinearProgressIndicator(
          backgroundColor: Colors.grey,
          color: Colors.blue,
          value: value,
        ),
      ),
    );
  }
}
