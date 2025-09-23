import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _carouselKey = Key("carouselKey");

const Duration _autoPlayDelay = Duration(seconds: 2);
const double _itemExtent = 100;

void main() {
  final Finder carousel = find.byKey(_carouselKey);

  final Finder item0 = find.text("0");
  final Finder item1 = find.text("1");
  final Finder item2 = find.text("2");
  final Finder item3 = find.text("3");
  final Finder item4 = find.text("4");

  testWidgets("Carousel initializes correctly", (tester) async {
    await tester.pumpWidget(const _CarouselTestWidget());

    expect(item0, findsOneWidget);
    expect(item1, findsOneWidget);
    expect(item2, findsNothing);
  });

  testWidgets("Carousel items visibility changes on scroll", (tester) async {
    await tester.pumpWidget(const _CarouselTestWidget());

    expect(item0, findsOneWidget);
    expect(item1, findsOneWidget);
    expect(item2, findsNothing);

    await tester.drag(carousel, const Offset(-150, 0));
    await tester.pumpAndSettle();

    expect(item0, findsNothing);
    expect(item1, findsOneWidget);
    expect(item2, findsOneWidget);
    expect(item3, findsOneWidget);
    expect(item4, findsNothing);
  });

  testWidgets(
    "Carousel 'autoPlay' works correctly if set to true with custom 'autoPlayDelay'",
    (tester) async {
      await tester.pumpWidget(const _CarouselTestWidget(autoPlay: true));

      expect(item0, findsOneWidget);
      expect(item1, findsOneWidget);
      expect(item2, findsNothing);

      await tester.pump(_autoPlayDelay);
      await tester.pumpAndSettle();

      expect(item0, findsOneWidget);
      expect(item1, findsOneWidget);
      expect(item2, findsOneWidget);
      expect(item3, findsNothing);

      await tester.pump(_autoPlayDelay);
      await tester.pumpAndSettle();

      expect(item0, findsNothing);
      expect(item1, findsOneWidget);
      expect(item2, findsOneWidget);
      expect(item3, findsOneWidget);
      expect(item4, findsNothing);
    },
  );

  testWidgets("Carousel 'loop' works correctly if set to true", (tester) async {
    await tester.pumpWidget(const _CarouselTestWidget(loop: true));

    await tester.drag(carousel, const Offset(-1000, 0));
    await tester.pumpAndSettle();

    expect(item0, findsOneWidget);
    expect(item1, findsOneWidget);
  });

  testWidgets("'onIndexChanged' callback is called when index changes", (
    tester,
  ) async {
    int? changedIndex;

    await tester.pumpWidget(
      _CarouselTestWidget(onIndexChanged: (int index) => changedIndex = index),
    );

    await tester.drag(carousel, const Offset(-150, 0));
    await tester.pumpAndSettle();

    expect(changedIndex, 2);
  });

  testWidgets(
    "Carousel scrolls horizontally when 'axisDirection' is Axis.horizontal",
    (tester) async {
      await tester.pumpWidget(const _CarouselTestWidget());

      expect(item0, findsOneWidget);
      expect(item1, findsOneWidget);
      expect(item2, findsNothing);

      await tester.drag(carousel, const Offset(-150, 0));
      await tester.pumpAndSettle();

      expect(item0, findsNothing);
      expect(item1, findsOneWidget);
      expect(item2, findsOneWidget);
    },
  );

  testWidgets(
    "Carousel scrolls vertically when 'axisDirection' is Axis.vertical",
    (tester) async {
      await tester.pumpWidget(
        const _CarouselTestWidget(axisDirection: Axis.vertical),
      );

      expect(item0, findsOneWidget);
      expect(item1, findsOneWidget);
      expect(item2, findsNothing);

      await tester.drag(carousel, const Offset(0, -150));
      await tester.pumpAndSettle();

      expect(item0, findsNothing);
      expect(item1, findsOneWidget);
      expect(item2, findsOneWidget);
    },
  );

  testWidgets("Passed in controller works correctly", (tester) async {
    final MoonCarouselScrollController controller =
        MoonCarouselScrollController();

    await tester.pumpWidget(_CarouselTestWidget(controller: controller));

    expect(item0, findsOneWidget);
    expect(item1, findsOneWidget);
    expect(item2, findsNothing);

    controller.jumpToItem(4);
    await tester.pumpAndSettle();

    expect(item0, findsNothing);
    expect(item1, findsNothing);
    expect(item2, findsNothing);
    expect(item3, findsOneWidget);
    expect(item4, findsOneWidget);
  });

  testWidgets(
    "Carousel with 'isCentered' set to true starts with the first item visually centered",
    (tester) async {
      await tester.pumpWidget(const _CarouselTestWidget());

      final Rect carouselRect = tester.getRect(carousel);
      final double carouselCenterX = carouselRect.left + carouselRect.width / 2;

      final Rect item0Rect = tester.getRect(item0);
      final double item0CenterX = item0Rect.left + item0Rect.width / 2;

      expect(item0CenterX, carouselCenterX);
    },
  );

  testWidgets(
    "Carousel with 'isCentered' set to false starts with the first item at the beginning of the screen",
    (tester) async {
      await tester.pumpWidget(const _CarouselTestWidget(isCentered: false));

      final Rect carouselRect = tester.getRect(carousel);

      final Rect item0Rect = tester.getRect(item0);
      final double itemOffset = (_itemExtent - item0Rect.width) / 2;

      expect(item0Rect.left - itemOffset, carouselRect.left);
    },
  );

  testWidgets(
    "Carousel with 'anchor' set to 0.25 starts with the first item at 25% of the carousel width",
    (tester) async {
      const double anchor = 0.25;

      await tester.pumpWidget(
        const _CarouselTestWidget(isCentered: false, anchor: anchor),
      );

      final Rect carouselRect = tester.getRect(carousel);
      final double expectedPosition = carouselRect.width * anchor;

      final Rect item0Rect = tester.getRect(item0);
      final double itemOffset = (_itemExtent - item0Rect.width) / 2;
      final double itemContainerLeft = item0Rect.left - itemOffset;

      expect(itemContainerLeft, expectedPosition);
    },
  );
}

class _CarouselTestWidget extends StatelessWidget {
  final Axis axisDirection;
  final bool autoPlay;
  final bool loop;
  final bool isCentered;
  final double anchor;
  final MoonCarouselScrollController? controller;
  final void Function(int)? onIndexChanged;

  const _CarouselTestWidget({
    this.axisDirection = Axis.horizontal,
    this.autoPlay = false,
    this.loop = false,
    this.isCentered = true,
    this.anchor = 0.0,
    this.controller,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 114,
          width: 200,
          child: MoonRawCarousel(
            key: _carouselKey,
            gap: 0,
            itemCount: 10,
            itemExtent: _itemExtent,
            loop: loop,
            anchor: anchor,
            autoPlay: autoPlay,
            autoPlayDelay: _autoPlayDelay,
            axisDirection: axisDirection,
            isCentered: isCentered,
            controller: controller,
            onIndexChanged: onIndexChanged,
            itemBuilder: (BuildContext _, int itemIndex, int __) =>
                Center(child: Text("$itemIndex")),
          ),
        ),
      ),
    );
  }
}
