import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Duration _displayDuration = Duration(seconds: 2);
const String _toastLabel = "Toast";
const String _showToastButtonLabel = "Show Toast";

void main() {
  final Finder toast = find.text(_toastLabel);
  final Finder showToastButton = find.text(_showToastButtonLabel);

  testWidgets(
    "Toast is displayed when the 'show' button is tapped and dismissed after 'displayDuration'",
    (tester) async {
      await tester.pumpWidget(const _ToastTestWidget());

      expect(showToastButton, findsOneWidget);

      await tester.tap(showToastButton);
      await tester.pumpAndSettle();

      expect(toast, findsOneWidget);

      await tester.pump(_displayDuration);

      expect(toast, findsNothing);
    },
  );

  testWidgets("Only one toast is shown at a time, even with multiple taps", (
    tester,
  ) async {
    await tester.pumpWidget(const _ToastTestWidget());

    expect(showToastButton, findsOneWidget);

    await tester.tap(showToastButton);
    await tester.tap(showToastButton);
    await tester.pumpAndSettle();

    expect(toast, findsOneWidget);

    await tester.pump(_displayDuration);
    await tester.pumpAndSettle();

    expect(toast, findsOneWidget);

    await tester.pumpAndSettle(_displayDuration);

    expect(toast, findsNothing);
  });

  testWidgets("Toast queue is cleared after showing multiple toasts", (
    tester,
  ) async {
    await tester.pumpWidget(const _ToastTestWidget());

    expect(showToastButton, findsOneWidget);

    await tester.tap(showToastButton);
    await tester.tap(showToastButton);
    await tester.tap(showToastButton);

    await tester.pumpAndSettle(const Duration(seconds: 7));

    expect(toast, findsNothing);
  });

  testWidgets("Toast handles invalid context", (tester) async {
    final globalKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: globalKey,
          body: MoonBaseInteractiveWidget(
            onTap: () {
              MoonRawToast.show(
                globalKey.currentContext!,
                child: const Text(_toastLabel),
              );
            },
            child: const Text(_showToastButtonLabel),
          ),
        ),
      ),
    );

    expect(showToastButton, findsOneWidget);

    await tester.tap(showToastButton);
    await tester.tap(showToastButton);
    await tester.tap(showToastButton);

    await tester.pumpAndSettle(_displayDuration);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(_displayDuration);

    expect(toast, findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets("No toasts are displayed after 'clearQueue' is called", (
    tester,
  ) async {
    await tester.pumpWidget(const _ToastTestWidget());

    expect(showToastButton, findsOneWidget);

    await tester.tap(showToastButton);
    await tester.tap(showToastButton);
    await tester.tap(showToastButton);
    await tester.pumpAndSettle();

    MoonRawToast.clearQueue();

    await tester.pumpAndSettle();

    expect(toast, findsOneWidget);

    await tester.pump(_displayDuration);

    expect(toast, findsNothing);
  });

  testWidgets(
    "Toast appears in the correct position based on 'toastAlignment'",
    (tester) async {
      final List<Alignment> toastAlignment = [
        Alignment.topCenter,
        Alignment.bottomCenter,
        Alignment.centerLeft,
        Alignment.centerRight,
      ];

      final Size screenSize =
          tester.view.physicalSize / tester.view.devicePixelRatio;
      final double screenHeight = screenSize.height;
      final double screenWidth = screenSize.width;

      for (final position in toastAlignment) {
        await tester.pumpWidget(_ToastTestWidget(toastAlignment: position));

        expect(showToastButton, findsOneWidget);

        await tester.tap(showToastButton);
        await tester.pumpAndSettle();

        expect(toast, findsOneWidget);

        final RenderBox toastWidget = tester.renderObject<RenderBox>(toast);
        final Offset toastPosition = toastWidget.localToGlobal(Offset.zero);
        final Offset toastCenter = tester.getCenter(toast);

        switch (position) {
          case Alignment.topCenter:
            expect(toastPosition.dy, 0);
            expect(toastCenter.dx, screenWidth / 2);
          case Alignment.bottomCenter:
            expect(toastPosition.dy, screenHeight - toastWidget.size.height);
            expect(toastCenter.dx, screenWidth / 2);
          case Alignment.centerLeft:
            expect(toastPosition.dx, 0);
            expect(toastCenter.dy, screenHeight / 2);
          case Alignment.centerRight:
            expect(toastPosition.dx, screenWidth - toastWidget.size.width);
            expect(toastCenter.dy, screenHeight / 2);
        }

        await tester.pump(_displayDuration);
      }
    },
  );
}

class _ToastTestWidget extends StatelessWidget {
  final AlignmentGeometry? toastAlignment;

  const _ToastTestWidget({this.toastAlignment = Alignment.bottomCenter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return MoonBaseInteractiveWidget(
              onTap: () {
                MoonRawToast.show(
                  context,
                  toastAlignment: toastAlignment!,
                  displayDuration: _displayDuration,
                  child: const Text(_toastLabel),
                );
              },
              child: const Text(_showToastButtonLabel),
            );
          },
        ),
      ),
    );
  }
}
