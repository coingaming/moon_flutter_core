import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/widgets/tooltip/tooltip_shape.dart';

const String _tooltipContent = "Tooltip Content";
const String _target = "Target";

const double arrowLength = 4.0;

void main() {
  final Finder overlay = find.text(_tooltipContent);
  final Finder target = find.text(_target);

  testWidgets("Tapping on target opens tooltip", (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(show: false),
    );

    expect(target, findsOneWidget);

    await tester.tap(target);
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);
  });

  testWidgets("Renders tooltip correctly when 'show' is true",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);
  });

  testWidgets("Does not render tooltip when 'show' is false",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(show: false),
    );

    expect(target, findsOneWidget);
    expect(overlay, findsNothing);
  });

  testWidgets("Renders tooltip with arrow when 'hasArrow' is true",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    final TooltipShape tooltipShape = (tester
            .widget<DecoratedBox>(find.byType(DecoratedBox))
            .decoration as ShapeDecoration)
        .shape as TooltipShape;

    expect(tooltipShape.arrowLength, greaterThan(0));
  });

  testWidgets("Renders tooltip without an arrow when 'hasArrow' is false",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(hasArrow: false),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    final TooltipShape tooltipShape = (tester
            .widget<DecoratedBox>(find.byType(DecoratedBox))
            .decoration as ShapeDecoration)
        .shape as TooltipShape;

    expect(tooltipShape.arrowLength, equals(0));
  });

  testWidgets("Tooltip triggers 'onTap' callback when tapped",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    await tester.tap(overlay);
    await tester.pumpAndSettle();

    expect(overlay, findsNothing);
  });

  testWidgets(
      "Tooltip distance to target is correct when 'distanceToTarget' is set",
      (WidgetTester tester) async {
    const double distanceToTarget = 32.0;

    await tester.pumpWidget(
      const _TooltipTestWidget(
        distanceToTarget: distanceToTarget,
      ),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    final RenderBox targetWidget = tester.renderObject<RenderBox>(target);
    final RenderBox tooltipChild = tester.renderObject<RenderBox>(overlay);

    await tester.pumpAndSettle();

    final double targetTop = targetWidget.localToGlobal(Offset.zero).dy;
    final double tooltipChildBottom =
        tooltipChild.localToGlobal(Offset.zero).dy +
            tooltipChild.size.height +
            arrowLength;

    expect(
      (tooltipChildBottom - targetTop).abs(),
      equals(distanceToTarget),
    );
  });

  testWidgets(
    "Tooltip is positioned correctly relative to target based on 'tooltipAnchorPosition'",
    (WidgetTester tester) async {
      const double distanceToTarget = 8.0;

      final List<OverlayPosition> anchorPositions = [
        OverlayPosition.top,
        OverlayPosition.bottom,
        OverlayPosition.left,
        OverlayPosition.right,
      ];

      for (final position in anchorPositions) {
        await tester.pumpWidget(
          _TooltipTestWidget(
            tooltipAnchorPosition: position,
          ),
        );

        await tester.pumpAndSettle();

        expect(target, findsOneWidget);
        expect(overlay, findsOneWidget);

        await tester.tap(target);
        await tester.pumpAndSettle();

        final RenderBox targetWidget = tester.renderObject<RenderBox>(target);
        final RenderBox tooltipChild = tester.renderObject<RenderBox>(overlay);
        final Offset targetPosition = targetWidget.localToGlobal(Offset.zero);
        final Offset tooltipPosition = tooltipChild.localToGlobal(Offset.zero);

        if (position == OverlayPosition.top) {
          expect(
            tooltipPosition.dy + tooltipChild.size.height,
            equals(targetPosition.dy - distanceToTarget - arrowLength),
          );
        } else if (position == OverlayPosition.bottom) {
          expect(
            tooltipPosition.dy,
            equals(
              targetWidget.size.height +
                  targetPosition.dy +
                  distanceToTarget +
                  arrowLength,
            ),
          );
        } else if (position == OverlayPosition.left) {
          expect(
            tooltipPosition.dx + tooltipChild.size.width,
            equals(targetPosition.dx - distanceToTarget - arrowLength),
          );
        } else if (position == OverlayPosition.right) {
          expect(
            tooltipPosition.dx,
            equals(
              targetWidget.size.width +
                  targetPosition.dx +
                  distanceToTarget +
                  arrowLength,
            ),
          );
        }
      }
    },
  );

  testWidgets(
      "Default tooltip shape is used when 'useDefaultTooltipShape' is true",
      (tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    final bool tooltipShapeUsed =
        tester.allWidgets.whereType<DecoratedBox>().where((decoratedBox) {
      return (decoratedBox.decoration as ShapeDecoration).shape is TooltipShape;
    }).isNotEmpty;

    expect(tooltipShapeUsed, isTrue);
  });

  testWidgets(
      "Default tooltip shape is not used when 'useDefaultTooltipShape' is false",
      (tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(useDefaultTooltipShape: false),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);

    final bool tooltipShapeUsed =
        tester.allWidgets.whereType<DecoratedBox>().where((decoratedBox) {
      return (decoratedBox.decoration as ShapeDecoration).shape is TooltipShape;
    }).isNotEmpty;

    expect(tooltipShapeUsed, isFalse);
  });

  testWidgets("Provided background color is used.", (tester) async {
    await tester.pumpWidget(
      const _TooltipTestWidget(color: Colors.blue),
    );

    await tester.pumpAndSettle();

    expect(target, findsOneWidget);
    expect(overlay, findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is MoonRawTooltip && widget.backgroundColor == Colors.blue,
      ),
      findsOneWidget,
    );
  });
}

class _TooltipTestWidget extends StatefulWidget {
  final bool show;
  final bool hasArrow;
  final bool useDefaultTooltipShape;
  final Color color;
  final double distanceToTarget;
  final OverlayPosition tooltipAnchorPosition;

  const _TooltipTestWidget({
    this.show = true,
    this.hasArrow = true,
    this.useDefaultTooltipShape = true,
    this.color = Colors.white,
    this.distanceToTarget = 8.0,
    this.tooltipAnchorPosition = OverlayPosition.top,
  });

  @override
  State<_TooltipTestWidget> createState() => _TooltipTestWidgetState();
}

class _TooltipTestWidgetState extends State<_TooltipTestWidget> {
  bool _show = false;

  @override
  void initState() {
    super.initState();

    _show = widget.show;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: MoonRawTooltip(
                show: _show,
                useDefaultTooltipShape: widget.useDefaultTooltipShape,
                hasArrow: widget.hasArrow,
                backgroundColor: widget.color,
                arrowLength: arrowLength,
                distanceToTarget: widget.distanceToTarget,
                tooltipAnchorPosition: widget.tooltipAnchorPosition,
                onTap: () => setState(() => _show = false),
                target: MoonBaseInteractiveWidget(
                  child: const Text(_target),
                  onPress: () => setState(() => _show = true),
                ),
                child: const Text(_tooltipContent),
              ),
            );
          },
        ),
      ),
    );
  }
}
