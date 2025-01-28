import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _targetKey = Key("targetKey");
const Key _childKey = Key("childKey");

const double _distanceToTarget = 4.0;
const String _content = "Content";
const String _close = "Close";

void main() {
  final Finder overlay = find.byKey(_childKey);
  final Finder target = find.byKey(_targetKey);

  testWidgets("Overlay is displayed when the 'target' is tapped",
      (tester) async {
    await tester.pumpWidget(
      const _BaseOverlayTestWidget(),
    );

    expect(target, findsOneWidget);

    await tester.tap(target);
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);
  });

  testWidgets("Overlay closes when the 'close' button is tapped",
      (tester) async {
    final Finder closeButton = find.text(_close);

    await tester.pumpWidget(
      const _BaseOverlayTestWidget(),
    );

    expect(target, findsOneWidget);

    await tester.tap(target);
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);

    await tester.pumpAndSettle();
    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(overlay, findsNothing);
  });

  testWidgets(
      "Overlay closes when a tap occurs outside its content, if 'dismissible'",
      (tester) async {
    await tester.pumpWidget(
      const _BaseOverlayTestWidget(),
    );

    expect(target, findsOneWidget);

    await tester.tap(target);
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(overlay, findsNothing);
  });

  testWidgets(
      "Overlay stays visible when a tap occurs outside its content, if not 'dismissible'",
      (tester) async {
    await tester.pumpWidget(
      const _BaseOverlayTestWidget(
        isDismissible: false,
      ),
    );

    expect(target, findsOneWidget);

    await tester.tap(target);
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(overlay, findsOneWidget);
  });

  testWidgets("Overlay calls 'onTap' callback when overlay 'child' is tapped",
      (WidgetTester tester) async {
    final Finder content = find.text(_content);

    bool onTapCalled = false;

    await tester.pumpWidget(
      _BaseOverlayTestWidget(
        onTap: () => onTapCalled = true,
      ),
    );

    await tester.tap(target);
    await tester.pumpAndSettle();

    await tester.tap(content);
    await tester.pumpAndSettle();

    expect(onTapCalled, isTrue);
  });

  testWidgets("Overlay calls 'onTapOutside' callback when tapped outside",
      (WidgetTester tester) async {
    bool onTapOutsideCalled = false;

    await tester.pumpWidget(
      _BaseOverlayTestWidget(
        onTapOutside: () => onTapOutsideCalled = true,
      ),
    );

    await tester.tap(target);
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(onTapOutsideCalled, isTrue);
  });

  testWidgets("Overlay has correct semantic label when displayed",
      (WidgetTester tester) async {
    const String semanticLabel = "Test Semantic Label";

    await tester.pumpWidget(
      const _BaseOverlayTestWidget(
        semanticLabel: semanticLabel,
      ),
    );

    await tester.tap(target);
    await tester.pumpAndSettle();

    final Finder overlay = find.bySemanticsLabel(RegExp(semanticLabel));

    expect(overlay, findsOneWidget);
  });

  testWidgets(
      "Overlay is positioned correctly relative to target based on 'overlayAnchorPosition' and 'distanceToTarget'",
      (tester) async {
    final List<OverlayAnchorPosition> anchorPositions = [
      OverlayAnchorPosition.top,
      OverlayAnchorPosition.bottom,
      OverlayAnchorPosition.left,
      OverlayAnchorPosition.right,
    ];

    for (final position in anchorPositions) {
      await tester.pumpWidget(
        _BaseOverlayTestWidget(
          overlayAnchorPosition: position,
          distanceToTarget: _distanceToTarget,
        ),
      );
      expect(target, findsOneWidget);

      await tester.tap(target);
      await tester.pump();
      await tester.pumpAndSettle();

      final RenderBox targetWidget = tester.renderObject<RenderBox>(target);
      final RenderBox childWidget = tester.renderObject<RenderBox>(overlay);
      final Offset targetPosition = targetWidget.localToGlobal(Offset.zero);
      final Offset childPosition = childWidget.localToGlobal(Offset.zero);

      final double childHeight = childWidget.size.height;
      final double childWidth = childWidget.size.width;
      final double targetHeight = targetWidget.size.height;
      final double targetWidth = targetWidget.size.width;

      if (position == OverlayAnchorPosition.top) {
        expect(
          childPosition.dy + childHeight,
          equals(targetPosition.dy - _distanceToTarget),
        );
      } else if (position == OverlayAnchorPosition.bottom) {
        expect(
          childPosition.dy,
          equals(targetHeight + targetPosition.dy + _distanceToTarget),
        );
      } else if (position == OverlayAnchorPosition.left) {
        expect(
          childPosition.dx + childWidth,
          equals(targetPosition.dx - _distanceToTarget),
        );
      } else if (position == OverlayAnchorPosition.right) {
        expect(
          childPosition.dx,
          equals(targetWidth + targetPosition.dx + _distanceToTarget),
        );
      }

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
    }
  });
}

class _BaseOverlayTestWidget extends StatefulWidget {
  final bool isDismissible;
  final double distanceToTarget;
  final String? semanticLabel;
  final OverlayAnchorPosition overlayAnchorPosition;
  final void Function()? onTap;
  final void Function()? onTapOutside;

  const _BaseOverlayTestWidget({
    this.isDismissible = true,
    this.distanceToTarget = 8.0,
    this.semanticLabel,
    this.overlayAnchorPosition = OverlayAnchorPosition.bottom,
    this.onTap,
    this.onTapOutside,
  });

  @override
  State<_BaseOverlayTestWidget> createState() => _BaseOverlayTestWidgetState();
}

class _BaseOverlayTestWidgetState extends State<_BaseOverlayTestWidget> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MoonBaseOverlay(
            show: _show,
            distanceToTarget: widget.distanceToTarget,
            semanticLabel: widget.semanticLabel,
            overlayAnchorPosition: widget.overlayAnchorPosition,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside ??
                () => setState(() => _show = !widget.isDismissible),
            target: MoonBaseInteractiveWidget(
              key: _targetKey,
              onTap: () => setState(() => _show = !_show),
              child: const Text("Show"),
            ),
            child: ConstrainedBox(
              key: _childKey,
              constraints: const BoxConstraints(maxWidth: 190),
              child: Column(
                children: [
                  const Text(_content),
                  MoonBaseInteractiveWidget(
                    onTap: () => setState(() => _show = false),
                    child: const Text(_close),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
