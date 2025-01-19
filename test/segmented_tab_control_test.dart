import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const String _firstTabLabel = "Tab 1";
const String _secondTabLabel = "Tab 2";
const String _thirdTabLabel = "tab 3";

void main() {
  final Finder firstTab = find.text(_firstTabLabel);
  final Finder secondTab = find.text(_secondTabLabel);
  final Finder thirdTab = find.text(_thirdTabLabel);

  testWidgets("Segmented tab control applies 'initialIndex' correctly",
      (tester) async {
    final List<bool> states = [false, false, false];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MoonRawSegmentedTabControl(
            initialIndex: 2,
            tabs: List.generate(
              3,
              (int index) => MoonRawSegmentedTab(
                isSelected: (bool isSelected) => states[index] = isSelected,
                child: Text(
                  switch (index) {
                    0 => _firstTabLabel,
                    1 => _secondTabLabel,
                    2 => _thirdTabLabel,
                    _ => '',
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(states, [false, false, true]);
  });

  testWidgets(
      "Segmented tab control calls 'onTabChanged' callback with correct index",
      (tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      _SegmentedTabControlTestWidget(
        onTabChanged: (int index) => selectedIndex = index,
      ),
    );

    await tester.tap(firstTab);
    await tester.pumpAndSettle();
    expect(selectedIndex, 0);

    // await tester.tap(secondTab);
    // await tester.pumpAndSettle();
    // expect(selectedIndex, 1);

    await tester.tap(thirdTab);
    await tester.pumpAndSettle();
    expect(selectedIndex, 2);
  });

  testWidgets(
      "Segmented tab control is not interactable when 'enabled' is set to false",
      (tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      _SegmentedTabControlTestWidget(
        enabled: false,
        onTabChanged: (int index) => selectedIndex = index,
      ),
    );

    await tester.tap(secondTab);
    await tester.pumpAndSettle();

    expect(selectedIndex, 0);

    await tester.tap(thirdTab);
    await tester.pumpAndSettle();

    expect(selectedIndex, 0);
  });

  testWidgets(
      "Tab can not be selected when 'disabled' for the tab has been set to true",
      (tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      _SegmentedTabControlTestWidget(
        secondTabDisabled: true,
        onTabChanged: (int index) => selectedIndex = index,
      ),
    );

    await tester.tap(secondTab);
    await tester.pumpAndSettle();

    expect(selectedIndex, 0);
    expect(selectedIndex, isNot(1));

    await tester.tap(thirdTab);
    await tester.pumpAndSettle();

    expect(selectedIndex, 2);
  });

  testWidgets(
      "Segmented tab control is expanded when 'isExpanded' is set to true",
      (tester) async {
    await tester.pumpWidget(
      const _SegmentedTabControlTestWidget(
        isExpanded: true,
      ),
    );

    final firstTab = tester.widget<Expanded>(find.byType(Expanded).first);

    expect(firstTab.child, isA<MoonBaseInteractiveWidget>());
  });

  testWidgets("Segmented tab control applies 'axisDirection' correctly",
      (tester) async {
    await tester.pumpWidget(
      const _SegmentedTabControlTestWidget(),
    );

    final tab1Position = tester.getTopLeft(firstTab);
    final tab2Position = tester.getTopLeft(secondTab);
    final thirdTabPosition = tester.getTopLeft(thirdTab);

    expect(tab1Position.dy, equals(tab2Position.dy));
    expect(tab2Position.dy, equals(thirdTabPosition.dy));
    expect(tab1Position.dx, lessThan(tab2Position.dx));
    expect(tab2Position.dx, lessThan(thirdTabPosition.dx));

    await tester.pumpWidget(
      const _SegmentedTabControlTestWidget(
        axisDirection: Axis.vertical,
      ),
    );

    final tab1VerticalPosition = tester.getTopLeft(firstTab);
    final tab2VerticalPosition = tester.getTopLeft(secondTab);
    final tab3VerticalPosition = tester.getTopLeft(thirdTab);

    expect(tab1VerticalPosition.dx, equals(tab2VerticalPosition.dx));
    expect(tab2VerticalPosition.dx, equals(tab3VerticalPosition.dx));
    expect(tab1VerticalPosition.dy, lessThan(tab2VerticalPosition.dy));
    expect(tab2VerticalPosition.dy, lessThan(tab3VerticalPosition.dy));
  });

  testWidgets("Segmented tab control calls 'isSelected' callback for each tab",
      (tester) async {
    final List<bool> states = [false, false, false];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MoonRawSegmentedTabControl(
            tabs: List.generate(
              3,
              (int index) => MoonRawSegmentedTab(
                isSelected: (bool isSelected) => states[index] = isSelected,
                child: Text(
                  switch (index) {
                    0 => _firstTabLabel,
                    1 => _secondTabLabel,
                    2 => _thirdTabLabel,
                    _ => '',
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(states, [true, false, false]);

    await tester.tap(secondTab);
    await tester.pumpAndSettle();

    expect(states, [false, true, false]);

    await tester.tap(thirdTab);
    await tester.pumpAndSettle();

    expect(states, [false, false, true]);

    await tester.tap(firstTab);
    await tester.pumpAndSettle();

    expect(states, [true, false, false]);
  });

  testWidgets(
      "The initialIndex of 'tabController' takes precedence over the segmented control's 'initialIndex'",
      (tester) async {
    final TabController tabController =
        TabController(length: 3, vsync: tester, initialIndex: 2);

    final List<bool> states = [false, false, false];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MoonRawSegmentedTabControl(
            initialIndex: 1,
            tabController: tabController,
            tabs: List.generate(
              3,
              (int index) => MoonRawSegmentedTab(
                isSelected: (bool isSelected) => states[index] = isSelected,
                child: Text(
                  switch (index) {
                    0 => _firstTabLabel,
                    1 => _secondTabLabel,
                    2 => _thirdTabLabel,
                    _ => '',
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(states, [false, false, true]);
  });

  testWidgets("Segmented tab control uses passed in 'tabController'",
      (tester) async {
    final TabController tabController = TabController(length: 3, vsync: tester);

    int selectedIndex = 0;

    await tester.pumpWidget(
      _SegmentedTabControlTestWidget(
        tabController: tabController,
        onTabChanged: (int index) => selectedIndex = index,
      ),
    );

    tabController.index = 1;

    await tester.pumpAndSettle();

    expect(selectedIndex, 1);

    tabController.index = 2;

    await tester.pumpAndSettle();

    expect(selectedIndex, 2);
  });
}

class _SegmentedTabControlTestWidget extends StatelessWidget {
  final Axis axisDirection;
  final bool isExpanded;
  final bool enabled;
  final bool secondTabDisabled;
  final TabController? tabController;
  final void Function(int)? onTabChanged;

  const _SegmentedTabControlTestWidget({
    this.axisDirection = Axis.horizontal,
    this.isExpanded = false,
    this.enabled = true,
    this.secondTabDisabled = false,
    this.tabController,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawSegmentedTabControl(
          axisDirection: axisDirection,
          enabled: enabled,
          isExpanded: isExpanded,
          tabController: tabController,
          onTabChanged: onTabChanged,
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              enabled: index != 1 || !secondTabDisabled,
              child: Text(
                switch (index) {
                  0 => _firstTabLabel,
                  1 => _secondTabLabel,
                  2 => _thirdTabLabel,
                  _ => '',
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
