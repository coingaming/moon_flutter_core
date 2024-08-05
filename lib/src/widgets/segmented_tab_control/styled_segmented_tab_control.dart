import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';
import 'package:moon_core/src/widgets/segmented_tab_control/segmented_tab.dart';
import 'package:moon_core/src/widgets/segmented_tab_control/segmented_tab_control.dart';

class StyledSegmentedTabControl extends StatefulWidget {
  const StyledSegmentedTabControl({super.key});

  @override
  State<StyledSegmentedTabControl> createState() =>
      _StyledSegmentedTabControlState();
}

class _StyledSegmentedTabControlState extends State<StyledSegmentedTabControl>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  final Duration _duration = const Duration(milliseconds: 200);

  int _selectedIndex = 1;

  SelectedState _getVariant(int index, {bool hasController = true}) =>
      index == (hasController ? tabController.index : _selectedIndex)
          ? SelectedState.selected
          : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    final Style pillTabContainerStyle = Style(
      $box.color(Colors.grey.shade300),
      $box.borderRadius(12),
      $box.padding(4),
      $flex.gap(4.0),
      $flex.mainAxisSize.min(),
    );

    final Style pillTabStyle = Style(
      $box.borderRadius(8),
      $box.padding(8.0, 16.0),
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
    );

    final Style indicatorTabStyle = Style(
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
    );

    Style getIndicatorStyle(double width) => Style(
          $box.width(0),
          $box.height(2),
          $box.color(Colors.deepPurple),
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
        );

    return Column(
      children: [
        MoonRawSegmentedTabControl(
          style: pillTabContainerStyle,
          initialIndex: _selectedIndex,
          onTabChanged: (int index) => setState(() => _selectedIndex = index),
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              tabStyle: pillTabStyle
                  .animate(duration: _duration)
                  .applyVariant(_getVariant(index, hasController: false)),
              child: StyledText('Tab ${index + 1}'),
            ),
          ),
        ),
        const SizedBox(height: 24),
        MoonRawSegmentedTabControl(
          isExpanded: true,
          tabController: tabController,
          style: Style(
            $flex.gap(4.0),
          ),
          onTabChanged: (int index) => setState(
            () => tabController.index = index,
          ),
          tabs: List.generate(
            3,
            (int index) => MoonRawSegmentedTab(
              tabStyle: indicatorTabStyle
                  .animate(duration: _duration)
                  .applyVariant(_getVariant(index)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  StyledText('Tab ${index + 1}'),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Box(
                          style: getIndicatorStyle(constraints.maxWidth)
                              .animate(duration: _duration)
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
            controller: tabController,
            children: List.generate(
              3,
              (int index) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => tabController.index = index == 0
                      ? 1
                      : index == 1
                          ? 2
                          : 0,
                  child: ColoredBox(
                    color: Colors.deepPurpleAccent.shade100,
                    child: Center(
                      child: Text('Tab ${index + 1} content'),
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
