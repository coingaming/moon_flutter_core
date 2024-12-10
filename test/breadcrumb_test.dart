import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const String _showMoreButtonText = "...";
const String _breadcrumbItem = "breadcrumb item";
const IconData _breadcrumbLeadingIcon = Icons.person;
const IconData _breadcrumbDividerIcon = Icons.chevron_right;

void main() {
  final Finder collapsedItem = find.textContaining("1");
  final Finder showMoreButton = find.text(_showMoreButtonText);
  final Finder breadcrumbItem = find.textContaining(_breadcrumbItem);

  testWidgets(
      "Tapping on a 'show more' button expands collapsed items, and the button becomes hidden",
      (tester) async {
    await tester.pumpWidget(const _BreadCrumbTestWidget());

    expect(showMoreButton, findsOneWidget);
    expect(collapsedItem, findsNothing);

    await tester.tap(showMoreButton);
    await tester.pumpAndSettle();

    expect(collapsedItem, findsOneWidget);
    expect(showMoreButton, findsNothing);
  });

  testWidgets("Breadcrumb displays content correctly", (tester) async {
    final Finder leading = find.byIcon(_breadcrumbLeadingIcon);
    final Finder divider = find.byIcon(_breadcrumbDividerIcon);

    await tester.pumpWidget(
      const _BreadCrumbTestWidget(),
    );

    expect(breadcrumbItem, findsWidgets);
    expect(leading, findsWidgets);
    expect(divider, findsWidgets);
  });

  testWidgets(
      "Only N items are shown, where N is defined by the value of 'itemsToShow'",
      (tester) async {
    await tester.pumpWidget(
      const _BreadCrumbTestWidget(
        itemsToShow: 3,
      ),
    );

    expect(showMoreButton, findsOneWidget);
    expect(breadcrumbItem, findsNWidgets(3));
    expect(find.textContaining("0"), findsOneWidget);
    expect(find.textContaining("1"), findsNothing);
    expect(find.textContaining("2"), findsOneWidget);
    expect(find.textContaining("3"), findsOneWidget);

    await tester.tap(showMoreButton);
    await tester.pumpAndSettle();

    expect(breadcrumbItem, findsNWidgets(4));
    expect(find.textContaining("0"), findsOneWidget);
    expect(find.textContaining("1"), findsOneWidget);
    expect(find.textContaining("2"), findsOneWidget);
    expect(find.textContaining("3"), findsOneWidget);
  });

  testWidgets("Breadcrumb item callback works", (tester) async {
    int value = 0;

    await tester.pumpWidget(
      _BreadCrumbTestWidget(
        onTap: (int index) => value = index,
      ),
    );

    await tester.tap(find.textContaining("2"));
    await tester.pumpAndSettle();

    expect(value, 2);

    await tester.tap(find.textContaining("0"));
    await tester.pumpAndSettle();

    expect(value, 0);
    expect(showMoreButton, findsOneWidget);

    await tester.tap(showMoreButton);
    await tester.pumpAndSettle();

    await tester.tap(collapsedItem);
    await tester.pumpAndSettle();

    expect(value, 1);
    expect(showMoreButton, findsNothing);
  });

  testWidgets("Uses custom 'showMoreWidget' when provided", (tester) async {
    const String expand = "Expand";
    final Finder customShowMoreButton = find.text(expand);

    await tester.pumpWidget(
      const _BreadCrumbTestWidget(
        showMoreWidget: MoonRawBreadcrumbItem(
          child: Text(expand),
        ),
      ),
    );

    expect(customShowMoreButton, findsOneWidget);
    expect(showMoreButton, findsNothing);
  });
}

class _BreadCrumbTestWidget extends StatelessWidget {
  final int? itemsToShow;
  final void Function(int)? onTap;
  final MoonRawBreadcrumbItem? showMoreWidget;

  const _BreadCrumbTestWidget({
    this.itemsToShow,
    this.onTap,
    this.showMoreWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MoonRawBreadcrumb(
            visibleItemCount: itemsToShow ?? 3,
            divider: const Icon(_breadcrumbDividerIcon),
            showMoreWidget: showMoreWidget,
            items: [
              ...List.generate(4, (int i) => i).map(
                (int index) {
                  return MoonRawBreadcrumbItem(
                    child: Row(
                      children: [
                        const Icon(_breadcrumbLeadingIcon),
                        Text('$_breadcrumbItem $index'),
                      ],
                    ),
                    onTap: () => onTap?.call(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
