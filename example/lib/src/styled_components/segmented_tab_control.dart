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

  FlexBoxStyler get _pillTabContainerStyle => FlexBoxStyler()
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .padding(EdgeInsetsGeometryMix.all(4))
      .constraints(BoxConstraintsMix.height(40))
      .margin(EdgeInsetsGeometryMix.only(bottom: 4))
      .color(Colors.grey.shade300)
      .spacing(4)
      .mainAxisSize(MainAxisSize.min);

  BoxStyler get _pillTabStyle {
    final BoxStyler activeState = BoxStyler()
        .color(Colors.purple.shade400)
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.white));

    final BoxStyler disabledState = BoxStyler()
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
        .wrapOpacity(0.5);

    return BoxStyler()
        .borderRadius(BorderRadiusGeometryMix.circular(8))
        .padding(
          EdgeInsetsGeometryMix.symmetric(vertical: 8, horizontal: 16),
        )
        .constraints(BoxConstraintsMix.width(100))
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
        .onHovered(activeState)
        .onFocused(activeState)
        .onPressed(activeState)
        .onSelected(activeState)
        .onDisabled(disabledState)
        .animate(AnimationConfig.ease(_duration));
  }

  BoxStyler get _indicatorTabStyle {
    final BoxStyler activeText = BoxStyler()
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.deepPurple));

    final BoxStyler disabledText = BoxStyler()
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
        .wrapOpacity(0.5);

    return BoxStyler()
        .constraints(BoxConstraintsMix.height(32))
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
        .onHovered(activeText)
        .onFocused(activeText)
        .onPressed(activeText)
        .onSelected(activeText)
        .onDisabled(disabledText)
        .animate(AnimationConfig.ease(_duration));
  }

  BoxStyler getIndicatorStyle(double width) {
    final BoxStyler expandWidth =
        BoxStyler().constraints(BoxConstraintsMix.width(width));

    return BoxStyler()
        .constraints(BoxConstraintsMix.height(2))
        .constraints(BoxConstraintsMix.width(0))
        .color(Colors.deepPurple)
        .wrapAlign(Alignment.bottomLeft)
        .onHovered(expandWidth)
        .onFocused(expandWidth)
        .onPressed(expandWidth)
        .onSelected(expandWidth)
        .onDisabled(
          BoxStyler().constraints(BoxConstraintsMix.width(0)),
        )
        .animate(AnimationConfig.ease(_duration));
  }

  Color _getContentBgColor(int index) => index == 0
      ? Colors.purple.shade100
      : index == 1
      ? Colors.blue.shade100
      : Colors.pink.shade100;

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
              tabStyle: _pillTabStyle,
              child: Center(child: StyledText("Tab ${index + 1}")),
            ),
          ),
        ),
        ...List.generate(3, (int index) {
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
                child: Center(child: Text("Tab ${index + 1} content")),
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        MoonRawSegmentedTabControl(
          isExpanded: true,
          tabController: _tabController,
          style: FlexBoxStyler().spacing(4),
          onTabChanged: (int index) =>
              setState(() => _tabController.index = index),
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              tabStyle: _indicatorTabStyle,
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
                          style: getIndicatorStyle(constraints.maxWidth),
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
                    child: Center(child: Text("Tab ${index + 1} content")),
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
