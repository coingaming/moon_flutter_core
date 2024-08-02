import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/breadcrumb/breadcrumb_item.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class MoonRawBreadcrumb extends StatefulWidget {
  /// The total number of the breadcrumb [items] to display.
  final int visibleItemCount;

  /// The style to apply to the breadcrumb.
  final Style? style;

  /// The list of breadcrumb items to display as a sequence of steps.
  final List<MoonRawBreadcrumbItem> items;

  /// The separating widget to display between the breadcrumb items.
  /// If not provided, a [Text] widget with a '/' character is used.
  final Widget? divider;

  /// The single custom widget to replace all the breadcrumb collapsed items with.
  /// If not provided, a [Text] widget with '...' is used.
  final MoonRawBreadcrumbItem? showMoreWidget;

  /// Creates a Moon Design raw breadcrumb.
  const MoonRawBreadcrumb({
    super.key,
    this.visibleItemCount = 3,
    this.style,
    required this.items,
    this.divider,
    this.showMoreWidget,
  });

  @override
  State<MoonRawBreadcrumb> createState() => _MoonBreadcrumbState();
}

class _MoonBreadcrumbState extends State<MoonRawBreadcrumb> {
  bool showFullPath = false;

  List<Widget> _buildItems() {
    final int resolvedItemCountToShow =
        showFullPath ? widget.items.length : widget.visibleItemCount;

    final List<MoonRawBreadcrumbItem> visibleItemsList = _getVisibleItems();

    final List<Widget> customizedVisibleItemsList = visibleItemsList
        .map(
          (MoonRawBreadcrumbItem item) => Row(
            children: [
              _BreadcrumbItemBuilder(
                onTap: item.onTap,
                item: item,
              ),
              if (item != visibleItemsList.last) _buildDivider(),
            ],
          ),
        )
        .toList();

    if (widget.items.length > resolvedItemCountToShow &&
        resolvedItemCountToShow > 1) {
      customizedVisibleItemsList.insert(
        1,
        Row(
          children: [
            _BreadcrumbItemBuilder(
              onTap: widget.showMoreWidget?.onTap ??
                  () => setState(() => showFullPath = true),
              item: widget.showMoreWidget ??
                  const MoonRawBreadcrumbItem(
                    semanticLabel: 'Show full path',
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('...'),
                    ),
                  ),
            ),
            _buildDivider(),
          ],
        ),
      );
    }

    // Restores the breadcrumb's initial collapsed state during every rebuild.
    showFullPath = false;

    return customizedVisibleItemsList;
  }

  List<MoonRawBreadcrumbItem> _getVisibleItems() {
    final int resolvedItemCountToShow =
        showFullPath ? widget.items.length : widget.visibleItemCount;

    final List<MoonRawBreadcrumbItem> visibleItems =
        resolvedItemCountToShow == 0
            ? []
            : widget.items.length > resolvedItemCountToShow
                ? [
                    widget.items[0],
                    ...List.generate(
                      resolvedItemCountToShow - 1,
                      (int index) => widget.items.length - index,
                    ).reversed.map((int index) => widget.items[index - 1]),
                  ]
                : widget.items;

    return visibleItems;
  }

  Widget _buildDivider() =>
      widget.divider ??
      Text(
        Directionality.of(context) == TextDirection.ltr ? '/' : '\\',
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: HBox(
        style: widget.style,
        children: _buildItems(),
      ),
    );
  }
}

class _BreadcrumbItemBuilder extends StatelessWidget {
  final VoidCallback? onTap;
  final MoonRawBreadcrumbItem item;

  const _BreadcrumbItemBuilder({required this.onTap, required this.item});

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      semanticLabel: item.semanticLabel,
      style: item.style,
      onPress: onTap,
      child: item.child,
    );
  }
}
