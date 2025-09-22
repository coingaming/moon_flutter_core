import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _switchKey = Key("switchKey");
const String activeWidgetText = 'ON';
const String inactiveWidgetText = 'OFF';
const IconData activeWidgetIcon = Icons.sunny;
const IconData inactiveWidgetIcon = Icons.shield_moon_rounded;

void main() {
  final Finder switchX = find.byKey(_switchKey);

  testWidgets("Initial state of the switch is correct", (tester) async {
    await tester.pumpWidget(const _SwitchTestWidget());

    final Finder switchValue = find.byWidgetPredicate(
      (Widget widget) => widget is MoonRawSwitch && widget.value == true,
    );

    expect(switchValue, findsOneWidget);
  });

  testWidgets("Tapping on a switch changes its value", (tester) async {
    final Finder switchValue = find.byWidgetPredicate(
      (Widget widget) => widget is MoonRawSwitch && widget.value == true,
    );

    await tester.pumpWidget(const _SwitchTestWidget());

    expect(switchValue, findsOneWidget);

    await tester.tap(switchX);
    await tester.pumpAndSettle();

    expect(switchValue, findsNothing);

    await tester.tap(switchX);
    await tester.pumpAndSettle();

    expect(switchValue, findsOneWidget);
  });

  testWidgets("Active and inactive widgets are displayed correctly", (
    tester,
  ) async {
    Finder textIsVisible(String textWidget) {
      return find.byWidgetPredicate(
        (Widget widget) =>
            widget is FadeTransition &&
            widget.opacity.value == 1.0 &&
            widget.child is Text &&
            (widget.child! as Text).data == textWidget,
      );
    }

    Finder iconIsVisible(IconData iconWidget) {
      return find.byWidgetPredicate(
        (Widget widget) =>
            widget is FadeTransition &&
            widget.child is Icon &&
            (widget.child! as Icon).icon == iconWidget,
      );
    }

    await tester.pumpWidget(const _SwitchTestWidget());

    expect(textIsVisible(activeWidgetText), findsOneWidget);
    expect(iconIsVisible(activeWidgetIcon), findsOneWidget);

    expect(textIsVisible(inactiveWidgetText), findsNothing);
    expect(iconIsVisible(inactiveWidgetIcon), findsNothing);

    await tester.tap(switchX);
    await tester.pumpAndSettle();

    expect(textIsVisible(activeWidgetText), findsNothing);
    expect(iconIsVisible(activeWidgetIcon), findsNothing);

    expect(textIsVisible(inactiveWidgetText), findsOneWidget);
    expect(iconIsVisible(inactiveWidgetIcon), findsOneWidget);
  });
}

class _SwitchTestWidget extends StatefulWidget {
  const _SwitchTestWidget();

  @override
  State<_SwitchTestWidget> createState() => _SwitchTestWidgetState();
}

class _SwitchTestWidgetState extends State<_SwitchTestWidget> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawSwitch(
          key: _switchKey,
          value: _switchValue,
          onChanged: (bool newValue) => setState(() => _switchValue = newValue),
          activeTrackWidget: const Text(activeWidgetText),
          activeThumbWidget: const Icon(activeWidgetIcon),
          inactiveTrackWidget: const Text(inactiveWidgetText),
          inactiveThumbWidget: const Icon(inactiveWidgetIcon),
        ),
      ),
    );
  }
}
