import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';
import 'package:moon_core/src/widgets/segmented_tab_control/segmented_tab.dart';

class MoonRawSegmentedTabControl extends StatefulWidget {
  /// Axis direction of the segmented tab control.
  final Axis axisDirection;

  /// Whether the segmented tab control is disabled.
  final bool isDisabled;

  /// Whether the segmented tab control is expanded to its full available width
  /// horizontally.
  final bool isExpanded;

  /// The index of the initially selected segmented tab.
  /// This property is overridden by the [tabController]'s initial index if the
  /// [tabController] is provided.
  /// For external updates to the segmented tab index, use [tabController].
  final int initialIndex;

  /// Style of the segmented tab control container.
  final Style? style;

  /// The external controller for managing segmented tab selection and animation
  /// in segmented tab control. If [tabController] is provided, then [initialIndex]
  /// is ignored and [tabController]'s index is used instead.
  final TabController? tabController;

  /// The callback that returns the index of the currently selected segmented tab.
  final ValueChanged<int>? onTabChanged;

  /// The list of segmented tabs to display as the children of the segmented
  /// tab control. At least one child is required.
  final List<MoonRawSegmentedTab> tabs;

  /// Creates a Moon Design raw segmented tab control.
  const MoonRawSegmentedTabControl({
    super.key,
    this.axisDirection = Axis.horizontal,
    this.isDisabled = false,
    this.isExpanded = false,
    this.initialIndex = 0,
    this.style,
    this.tabController,
    this.onTabChanged,
    required this.tabs,
  }) : assert(tabs.length > 0);

  @override
  State<MoonRawSegmentedTabControl> createState() =>
      _MoonRawSegmentedTabControlState();
}

class _MoonRawSegmentedTabControlState extends State<MoonRawSegmentedTabControl>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late TabController? _controller;

  void _handleTabChange() {
    final int animationValue =
        widget.tabController?.animation?.value.round() ?? 0;

    if (animationValue != _selectedIndex) _updateTabs(animationValue);
  }

  void _updateTabsSelectedStatus(int newIndex) {
    widget.tabs.asMap().forEach((int index, MoonRawSegmentedTab tab) {
      tab.isSelected?.call(index == _selectedIndex);
    });
  }

  void _updateTabs(int newIndex) {
    if (newIndex >= 0 &&
        newIndex < widget.tabs.length &&
        newIndex != _selectedIndex) {
      _selectedIndex = newIndex;

      widget.onTabChanged?.call(newIndex);
      _updateTabsSelectedStatus(newIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.tabController ?? DefaultTabController.maybeOf(context);

    _controller?.animation?.addListener(_handleTabChange);

    _selectedIndex = _controller?.index ?? widget.initialIndex;
  }

  @override
  void dispose() {
    _controller?.animation?.removeListener(_handleTabChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = List.generate(
      widget.tabs.length,
      (int index) {
        final child = MoonBaseInteractiveWidget(
          enabled: !widget.isDisabled && !widget.tabs[index].disabled,
          enableFeedback: widget.tabs[index].enableFeedback,
          autofocus: widget.tabs[index].autoFocus,
          focusNode: widget.tabs[index].focusNode,
          semanticLabel: widget.tabs[index].semanticLabel,
          style: widget.tabs[index].tabStyle,
          onFocusChange: widget.tabs[index].onFocusChange,
          onPress: () => _updateTabs(index),
          child: widget.tabs[index].child!,
        );

        return widget.isExpanded ? Expanded(child: child) : child;
      },
    );

    return widget.axisDirection == Axis.horizontal
        ? HBox(
            style: widget.style,
            children: children,
          )
        : VBox(
            style: widget.style,
            children: children,
          );
  }
}
