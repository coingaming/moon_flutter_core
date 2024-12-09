import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const String _alertLabel = "Alert";
const IconData _closeAlertIcon = Icons.close;

void main() {
  final Finder alert = find.text(_alertLabel);
  final Finder closeButton = find.byIcon(_closeAlertIcon);

  testWidgets("Alert is visible when 'show' is true", (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(),
    );

    expect(alert, findsOneWidget);
  });

  testWidgets("Alert is not visible when 'show' is false", (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(show: false),
    );

    expect(alert, findsNothing);
  });

  testWidgets("Alert disappears when the 'close' button is tapped",
      (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(),
    );

    expect(closeButton, findsOneWidget);
    expect(alert, findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(alert, findsNothing);
  });

  testWidgets(
      "When alert's visibility changes, 'onVisibilityChanged' callback is called",
      (tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      _AlertTestWidget(
        onVisibilityChanged: (bool newValue) => callbackTriggered = true,
      ),
    );

    expect(closeButton, findsOneWidget);
    expect(alert, findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(callbackTriggered, isTrue);
    expect(alert, findsNothing);
  });
}

class _AlertTestWidget extends StatefulWidget {
  final bool show;
  final ValueChanged<bool>? onVisibilityChanged;

  const _AlertTestWidget({this.show = true, this.onVisibilityChanged});

  @override
  State<_AlertTestWidget> createState() => _AlertTestWidgetState();
}

class _AlertTestWidgetState extends State<_AlertTestWidget> {
  bool _show = true;

  @override
  void initState() {
    super.initState();

    _show = widget.show;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawAlert(
          show: _show,
          onVisibilityChanged: widget.onVisibilityChanged,
          child: Row(
            children: [
              const Expanded(child: Text(_alertLabel)),
              IconButton(
                onPressed: () => setState(() => _show = !_show),
                icon: const Icon(_closeAlertIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
