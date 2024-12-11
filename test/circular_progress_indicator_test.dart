import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/src/widgets/common/progress_indicators/circular_progress_indicator.dart';
import 'package:moon_core/src/widgets/common/progress_indicators/painters/circular_progress_indicator_painter.dart';

void main() {
  final Finder progressIndicator = find.byType(MoonCircularProgressIndicator);
  final Finder customPainterFinder = find.descendant(
    of: progressIndicator,
    matching: find.byType(CustomPaint),
  );

  testWidgets(
    "Indicator is continuously animating in indeterminate state",
    (WidgetTester tester) async {
      double getRotationValue() {
        final CustomPaint customPaint = tester.widget(customPainterFinder);
        return (customPaint.painter! as MoonCircularProgressIndicatorPainter)
            .rotationValue;
      }

      await tester.pumpWidget(
        const _CircularProgressIndicatorTestWidget(),
      );

      expect(getRotationValue(), 0.0);

      await tester.pump(const Duration(milliseconds: 500));

      final firstRotationValue = getRotationValue();
      expect(firstRotationValue, greaterThan(0.0));

      await tester.pump(const Duration(milliseconds: 500));

      expect(getRotationValue(), greaterThan(firstRotationValue));
    },
  );

  testWidgets(
    "Indicator is not continuously animating in determinate state",
    (WidgetTester tester) async {
      double getRotationValue() {
        final CustomPaint customPaint = tester.widget(customPainterFinder);
        return (customPaint.painter! as MoonCircularProgressIndicatorPainter)
            .rotationValue;
      }

      await tester.pumpWidget(
        const _CircularProgressIndicatorTestWidget(value: 0.5),
      );

      expect(getRotationValue(), 0.0);

      await tester.pump(const Duration(milliseconds: 500));

      expect(getRotationValue(), 0.0);

      await tester.pump(const Duration(milliseconds: 500));

      expect(getRotationValue(), 0.0);
    },
  );

  testWidgets("Indicator has correct progress value", (tester) async {
    await tester.pumpWidget(
      const _CircularProgressIndicatorTestWidget(
        value: 0.5,
      ),
    );

    final MoonCircularProgressIndicator indicator =
        tester.widget(progressIndicator);

    expect(indicator.value, 0.5);
  });

  testWidgets("Stroke width and stroke cap properties are correct",
      (tester) async {
    await tester.pumpWidget(
      const _CircularProgressIndicatorTestWidget(
        strokeWidth: 12.0,
        strokeCap: StrokeCap.square,
      ),
    );

    final MoonCircularProgressIndicator indicator =
        tester.widget(progressIndicator);

    expect(indicator.strokeWidth, 12.0);
    expect(indicator.strokeCap, StrokeCap.square);
  });
}

class _CircularProgressIndicatorTestWidget extends StatelessWidget {
  final double? value;
  final double strokeWidth;
  final StrokeCap strokeCap;

  const _CircularProgressIndicatorTestWidget({
    this.value,
    this.strokeWidth = 4.0,
    this.strokeCap = StrokeCap.round,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonCircularProgressIndicator(
          backgroundColor: Colors.grey,
          color: Colors.blue,
          strokeWidth: strokeWidth,
          strokeCap: strokeCap,
          value: value,
        ),
      ),
    );
  }
}
