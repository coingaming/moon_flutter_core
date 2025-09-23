import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _showBottomSheetButtonKey = Key("showButtonKey");

const String _bottomSheetContent = "Content";

final navigatorObserver = _TestNavigatorObserver();

void main() {
  final Finder bottomSheet = find.text(_bottomSheetContent);
  final Finder showBottomSheetButton = find.byKey(_showBottomSheetButtonKey);
  final Finder sheetContainer = find.byType(MoonRawBottomSheet);

  testWidgets(
    "Bottom sheet is displayed when the 'show' showBottomSheetButton is tapped",
    (tester) async {
      await tester.pumpWidget(const _BottomSheetTestWidget());

      expect(showBottomSheetButton, findsOneWidget);

      await tester.tap(showBottomSheetButton);
      await tester.pumpAndSettle();

      expect(bottomSheet, findsOneWidget);
    },
  );

  testWidgets(
    "If 'dismissible', bottom sheet closes when a tap occurs outside its content",
    (tester) async {
      await tester.pumpWidget(const _BottomSheetTestWidget());

      expect(showBottomSheetButton, findsOneWidget);

      await tester.tap(showBottomSheetButton);
      await tester.pumpAndSettle();

      expect(bottomSheet, findsOneWidget);
      expect(sheetContainer, findsOneWidget);

      final Route<dynamic>? route = navigatorObserver.pushedRoute;
      expect(route, isA<ModalRoute<dynamic>>());
      final ModalRoute<dynamic> modalRoute =
          route! as ModalRoute<dynamic>;
      expect(modalRoute.barrierDismissible, isTrue);
  },
  );

  testWidgets(
    "If not 'dismissible', bottom sheet stays visible when a tap occurs outside its content",
    (tester) async {
      await tester.pumpWidget(
        const _BottomSheetTestWidget(isDismissible: false),
      );

      expect(showBottomSheetButton, findsOneWidget);

      await tester.tap(showBottomSheetButton);
      await tester.pumpAndSettle();

      expect(bottomSheet, findsOneWidget);
      expect(sheetContainer, findsOneWidget);

      final Route<dynamic>? route = navigatorObserver.pushedRoute;
      expect(route, isA<ModalRoute<dynamic>>());
      final ModalRoute<dynamic> modalRoute =
          route! as ModalRoute<dynamic>;
      expect(modalRoute.barrierDismissible, isFalse);
  },
  );

  testWidgets("Barrier color matches the specified color", (tester) async {
    const Color customBarrierColor = Colors.red;

    await tester.pumpWidget(
      const _BottomSheetTestWidget(barrierColor: customBarrierColor),
    );

    expect(showBottomSheetButton, findsOneWidget);

    await tester.tap(showBottomSheetButton);
    await tester.pumpAndSettle();

    final barrierFinder = find.byWidgetPredicate((widget) {
      return widget is ModalBarrier && widget.color == customBarrierColor;
    });

    expect(barrierFinder, findsOneWidget);
  });

  testWidgets("Scrollable content inside bottom sheet scrolls correctly", (
    tester,
  ) async {
    final Finder listViewContent = find.byType(ListView);

    await tester.pumpWidget(const _BottomSheetTestWidget());

    expect(showBottomSheetButton, findsOneWidget);

    await tester.tap(showBottomSheetButton);
    await tester.pumpAndSettle();

    expect(sheetContainer, findsOneWidget);

    await tester.drag(listViewContent, const Offset(0, -200));
    await tester.pump();

    final ScrollableState scrollableState = tester.state<ScrollableState>(
      find.byType(Scrollable).last,
    );

    expect(scrollableState.position.pixels, greaterThan(0));
  });

  testWidgets("Custom animation controller is used", (tester) async {
    final AnimationController customController = AnimationController(
      vsync: tester,
      duration: const Duration(seconds: 1),
    );

    await tester.pumpWidget(
      _BottomSheetTestWidget(animationController: customController),
    );

    expect(showBottomSheetButton, findsOneWidget);

    await tester.tap(showBottomSheetButton);
    await tester.pump();

    customController.forward();

    await tester.pump(const Duration(milliseconds: 100));

    expect(customController.status, AnimationStatus.forward);

    await tester.pumpAndSettle();

    expect(customController.status, AnimationStatus.completed);
  });

  testWidgets("Custom route 'settings' for bottom sheet apply correctly", (
    tester,
  ) async {
    const String customRouteName = 'bottomSheet';
    const String customRouteArguments = 'arguments';

    const RouteSettings testSettings = RouteSettings(
      name: customRouteName,
      arguments: customRouteArguments,
    );

    await tester.pumpWidget(
      const _BottomSheetTestWidget(routeSettings: testSettings),
    );

    expect(showBottomSheetButton, findsOneWidget);

    await tester.tap(showBottomSheetButton);
    await tester.pumpAndSettle();

    final RouteSettings? routeSettings = navigatorObserver.pushedRouteSettings;

    expect(routeSettings?.name, customRouteName);
    expect(routeSettings?.arguments, customRouteArguments);
  });
}

class _BottomSheetTestWidget extends StatelessWidget {
  final bool isDismissible;
  final Color? barrierColor;
  final AnimationController? animationController;
  final RouteSettings? routeSettings;

  const _BottomSheetTestWidget({
    this.isDismissible = true,
    this.barrierColor,
    this.animationController,
    this.routeSettings,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [navigatorObserver],
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return MoonBaseInteractiveWidget(
              key: _showBottomSheetButtonKey,
              onTap: () => bottomSheetBuilder(context),
              child: const Text("Show"),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetBuilder(BuildContext context) {
    return showMoonRawModalBottomSheet(
      useRootNavigator: true,
      context: context,
      settings: routeSettings,
      animationController: animationController,
      barrierColor: barrierColor ?? Colors.black54,
      isDismissible: isDismissible,
      builder: (BuildContext context) => SizedBox(
        height: 320,
        child: ListView(
          children: List.generate(
            50,
            (index) => index == 0
                ? const Text(_bottomSheetContent)
                : Text("Item $index"),
          ),
        ),
      ),
    );
  }
}

class _TestNavigatorObserver extends NavigatorObserver {
  RouteSettings? pushedRouteSettings;
  Route<dynamic>? pushedRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRouteSettings = route.settings;
    pushedRoute = route;

    super.didPush(route, previousRoute);
  }
}
