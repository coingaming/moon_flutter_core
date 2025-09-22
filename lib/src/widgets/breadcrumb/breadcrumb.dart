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
    final List<MoonRawBreadcrumbItem> visibleItems = _getVisibleItems();
    final List<Widget> itemWidgets = visibleItems
        .map((item) => _buildBreadcrumbItem(item, item != visibleItems.last))
        .toList();

    if (_hasMoreItems() && !showFullPath) {
      itemWidgets.insert(1, _buildShowMoreItem());
    }

    return itemWidgets;
  }

  List<MoonRawBreadcrumbItem> _getVisibleItems() {
    final int itemCount = showFullPath
        ? widget.items.length
        : widget.visibleItemCount;

    if (itemCount == 0) return [];

    return widget.items.length > itemCount
        ? [
            widget.items.first,
            ...widget.items.sublist(widget.items.length - itemCount + 1),
          ]
        : widget.items;
  }

  bool _hasMoreItems() => widget.items.length > widget.visibleItemCount;

  Widget _buildBreadcrumbItem(MoonRawBreadcrumbItem item, bool addDivider) {
    return Row(
      children: [
        _BreadcrumbItemBuilder(
          onTap: () {
            setState(() => showFullPath = false);
            item.onTap?.call();
          },
          item: item,
        ),
        if (addDivider) _buildDivider(),
      ],
    );
  }

  Widget _buildShowMoreItem() {
    return Row(
      children: [
        _BreadcrumbItemBuilder(
          onTap:
              widget.showMoreWidget?.onTap ??
              () => setState(() => showFullPath = true),
          item:
              widget.showMoreWidget ??
              const MoonRawBreadcrumbItem(
                semanticLabel: "Show full path",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("..."),
                ),
              ),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() =>
      widget.divider ??
      Text(Directionality.of(context) == TextDirection.ltr ? "/" : "\\");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: RowBox(style: widget.style, children: _buildItems()),
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
      onTap: onTap,
      child: item.child,
    );
  }
}
