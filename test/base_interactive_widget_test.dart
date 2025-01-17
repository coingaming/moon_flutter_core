import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _widgetKey = Key("widgetKey");

void main() {
  final Finder widget = find.byKey(_widgetKey);

  testWidgets("Widget 'onTap' callback works", (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      _BaseInteractiveTestWidget(
        onTap: () => tapped = true,
      ),
    );

    await tester.tap(widget);
    await tester.pumpAndSettle();

    expect(tapped, true);
  });

  testWidgets("Widget 'onLongPress' callback works", (tester) async {
    bool longPressed = false;

    await tester.pumpWidget(
      _BaseInteractiveTestWidget(
        onLongPress: () => longPressed = true,
      ),
    );

    await tester.longPress(widget);
    await tester.pumpAndSettle();

    expect(longPressed, true);
  });

  testWidgets("Widget is not interactive when 'enabled' is false",
      (tester) async {
    bool tapped = false;
    bool longPressed = false;

    await tester.pumpWidget(
      _BaseInteractiveTestWidget(
        enabled: false,
        onTap: () => tapped = true,
        onLongPress: () => longPressed = true,
      ),
    );

    await tester.tap(widget);
    await tester.longPress(widget);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(tapped, false);
    expect(longPressed, false);
  });

  testWidgets("Correct cursor is displayed for enabled and disabled states",
      (tester) async {
    await tester.pumpWidget(
      _BaseInteractiveTestWidget(
        onTap: () => {},
      ),
    );

    final TestGesture gesture = await tester.createGesture(
      kind: PointerDeviceKind.mouse,
    );

    await gesture.addPointer(location: Offset.zero);

    addTearDown(gesture.removePointer);

    await tester.pump();

    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      SystemMouseCursors.click,
    );

    await tester.pumpWidget(
      const _BaseInteractiveTestWidget(),
    );

    await tester.pump();

    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      SystemMouseCursors.forbidden,
    );
  });

  testWidgets("Widget has correct semantic label", (tester) async {
    const String semanticLabelText = "Semantic Label";
    final Finder semanticLabel =
        find.bySemanticsLabel(RegExp(semanticLabelText));

    await tester.pumpWidget(
      const _BaseInteractiveTestWidget(
        semanticLabel: semanticLabelText,
      ),
    );

    expect(semanticLabel, findsOneWidget);
  });
}

class _BaseInteractiveTestWidget extends StatelessWidget {
  final bool enabled;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _BaseInteractiveTestWidget({
    this.enabled = true,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonBaseInteractiveWidget(
          key: _widgetKey,
          enabled: enabled,
          semanticLabel: semanticLabel,
          onTap: onTap,
          onLongPress: onLongPress,
          child: const Text("Label"),
        ),
      ),
    );
  }
}
