import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _showButtonKey = Key("showButtonKey");
const Key _closeButtonKey = Key("closeButtonKey");

const String _modalContent = "Modal";

void main() {
  final Finder showModalButton = find.byKey(_showButtonKey);
  final Finder modal = find.text(_modalContent);

  testWidgets("Modal is displayed when the 'show' button is tapped", (
    tester,
  ) async {
    await tester.pumpWidget(const _ModalTestWidget());

    expect(showModalButton, findsOneWidget);

    await tester.tap(showModalButton);
    await tester.pumpAndSettle();

    expect(modal, findsOneWidget);
  });

  testWidgets("Modal stays visible when tapped inside its content", (
    tester,
  ) async {
    await tester.pumpWidget(const _ModalTestWidget());

    expect(showModalButton, findsOneWidget);

    await tester.tap(showModalButton);
    await tester.pumpAndSettle();

    expect(modal, findsOneWidget);

    final RenderBox modalBox = tester.renderObject(modal);
    final Offset modalCenter = modalBox.localToGlobal(
      modalBox.size.center(Offset.zero),
    );

    await tester.tapAt(modalCenter);
    await tester.pumpAndSettle();

    expect(modal, findsOneWidget);
  });

  testWidgets(
    "Modal closes when a tap occurs outside its content, if 'barrierDismissible'",
    (tester) async {
      await tester.pumpWidget(const _ModalTestWidget());

      expect(showModalButton, findsOneWidget);

      await tester.tap(showModalButton);
      await tester.pumpAndSettle();

      expect(modal, findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(modal, findsNothing);
    },
  );

  testWidgets(
    "Modal stays visible when a tap occurs outside its content, if not 'barrierDismissible'",
    (tester) async {
      await tester.pumpWidget(const _ModalTestWidget(isDismissible: false));

      expect(showModalButton, findsOneWidget);

      await tester.tap(showModalButton);
      await tester.pumpAndSettle();

      expect(modal, findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(modal, findsOneWidget);
    },
  );

  testWidgets("Modal closes when the 'close' button is tapped", (tester) async {
    final Finder closeButton = find.byKey(_closeButtonKey);

    await tester.pumpWidget(const _ModalTestWidget());

    expect(showModalButton, findsOneWidget);

    await tester.tap(showModalButton);
    await tester.pumpAndSettle();

    expect(modal, findsOneWidget);

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(modal, findsNothing);
  });

  testWidgets("Custom route settings are applied", (tester) async {
    const String routeName = "/customModal";

    await tester.pumpWidget(
      const _ModalTestWidget(routeSettings: RouteSettings(name: routeName)),
    );

    await tester.tap(showModalButton);
    await tester.pumpAndSettle();

    final modalRoute = ModalRoute.of(tester.element(modal));

    expect(modalRoute?.settings.name, routeName);
  });

  testWidgets("Custom transition builder is applied", (tester) async {
    final Finder scaleTransition = find.byType(ScaleTransition);

    ScaleTransition customTransition(
      _,
      Animation<double> animation,
      __,
      Widget child,
    ) {
      return ScaleTransition(scale: animation, child: child);
    }

    await tester.pumpWidget(
      _ModalTestWidget(customTransitionBuilder: customTransition),
    );

    await tester.tap(showModalButton);
    await tester.pumpAndSettle();

    final modalTransitionFinder = find.ancestor(
      of: modal,
      matching: scaleTransition,
    );

    expect(modalTransitionFinder, findsOneWidget);
  });
}

class _ModalTestWidget extends StatelessWidget {
  final bool isDismissible;
  final RouteTransitionsBuilder? customTransitionBuilder;
  final RouteSettings? routeSettings;

  const _ModalTestWidget({
    this.isDismissible = true,
    this.customTransitionBuilder,
    this.routeSettings,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return MoonBaseInteractiveWidget(
                key: _showButtonKey,
                onTap: () => showMoonRawModal<void>(
                  context: context,
                  barrierDismissible: isDismissible,
                  routeSettings: routeSettings,
                  customTransitionBuilder: customTransitionBuilder,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        const Text(_modalContent),
                        MoonBaseInteractiveWidget(
                          key: _closeButtonKey,
                          child: const Text("Close modal"),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                ),
                child: const Text("Show Modal"),
              );
            },
          ),
        ),
      ),
    );
  }
}
