import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledSegmentedTabControl extends StatefulWidget {
  const StyledSegmentedTabControl({super.key});

  @override
  State<StyledSegmentedTabControl> createState() =>
      _StyledSegmentedTabControlState();
}

class _StyledSegmentedTabControlState extends State<StyledSegmentedTabControl>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final Duration _duration = const Duration(milliseconds: 200);

  int _selectedIndex = 1;

  Style get _pillTabContainerStyle => Style(
        $box.chain
          ..borderRadius(8)
          ..padding(4)
          ..height(40)
          ..margin.bottom(4)
          ..color(Colors.grey.shade300),
        $flex.chain
          ..gap(4.0)
          ..mainAxisSize.min(),
      );

  Style get _pillTabStyle => Style(
        $box.chain
          ..borderRadius(8)
          ..padding(8.0, 16.0)
          ..width(100),
        $text.style.color(Colors.black),
        ($on.hover | $on.focus | $on.press | $on.longPress)(
          $box.color(Colors.purple.shade400),
          $text.style.color(Colors.white),
        ),
        $on.disabled(
          $box.color(Colors.transparent),
          $text.style.color(Colors.black),
          $with.opacity(0.5),
        ),
        SelectedState.selected(
          $box.color(Colors.purple.shade400),
          $text.style.color(Colors.white),
        ),
      ).animate(duration: _duration);

  Style get _indicatorTabStyle => Style(
        $box.height(32),
        $text.style.color(Colors.black),
        ($on.hover | $on.focus | $on.press | $on.longPress)(
          $text.style.color(Colors.deepPurple),
        ),
        $on.disabled(
          $with.opacity(0.5),
          $text.style.color(Colors.black),
        ),
        SelectedState.selected(
          $text.style.color(Colors.deepPurple),
        ),
      ).animate(duration: _duration);

  Style getIndicatorStyle(double width) => Style(
        $box.chain
          ..width(0)
          ..height(2)
          ..color(Colors.deepPurple),
        $with.align(alignment: Alignment.bottomLeft),
        ($on.hover | $on.focus | $on.press | $on.longPress)(
          $box.width(width),
        ),
        $on.disabled(
          $box.width(0),
        ),
        SelectedState.selected(
          $box.width(width),
        ),
      ).animate(duration: _duration);

  Color _getContentBgColor(int index) => index == 0
      ? Colors.purple.shade100
      : index == 1
          ? Colors.blue.shade100
          : Colors.pink.shade100;

  SelectedState _getVariant(int index, {bool hasController = true}) =>
      index == (hasController ? _tabController.index : _selectedIndex)
          ? SelectedState.selected
          : SelectedState.unselected;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawSegmentedTabControl(
          style: _pillTabContainerStyle,
          initialIndex: _selectedIndex,
          onTabChanged: (int index) => setState(() => _selectedIndex = index),
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              tabStyle: _pillTabStyle.applyVariant(
                _getVariant(index, hasController: false),
              ),
              child: Center(
                child: StyledText("Tab ${index + 1}"),
              ),
            ),
          ),
        ),
        ...List.generate(
          3,
          (int index) {
            return Offstage(
              offstage: index != _selectedIndex,
              child: KeyedSubtree(
                key: Key(index.toString()),
                child: Container(
                  height: 100,
                  width: 316,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: _getContentBgColor(index),
                  ),
                  child: Center(
                    child: Text("Tab ${index + 1} content"),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        MoonRawSegmentedTabControl(
          isExpanded: true,
          tabController: _tabController,
          style: Style($flex.gap(4.0)),
          onTabChanged: (int index) => setState(
            () => _tabController.index = index,
          ),
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              tabStyle: _indicatorTabStyle.applyVariant(_getVariant(index)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  StyledText("Tab ${index + 1}"),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Box(
                          style: getIndicatorStyle(constraints.maxWidth)
                              .applyVariant(_getVariant(index)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: TabBarView(
            controller: _tabController,
            children: List.generate(
              3,
              (int index) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _tabController.index = index == 0
                      ? 1
                      : index == 1
                          ? 2
                          : 0,
                  child: ColoredBox(
                    color: Colors.deepPurpleAccent.shade100,
                    child: Center(
                      child: Text("Tab ${index + 1} content"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
