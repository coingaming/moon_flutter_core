import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/breadcrumb/breadcrumb_item.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class MoonRawBreadcrumb extends StatefulWidget {
  /// The total number of breadcrumb [items] to display.
  final int visibleItemCount;

  /// Optional style overrides for the breadcrumb container.
  final FlexBoxStyler? style;

  /// Breadcrumb items displayed in sequence.
  final List<MoonRawBreadcrumbItem> items;

  /// Optional divider widget between items. Defaults to a locale-aware slash.
  final Widget? divider;

  /// Custom widget used when items are collapsed. Defaults to an ellipsis button.
  final MoonRawBreadcrumbItem? showMoreWidget;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: widget.style != null
          ? RowBox(
              style: widget.style!,
              children: _buildItems(),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildItems(),
            ),
    );
  }

  List<Widget> _buildItems() {
    final visibleItems = _getVisibleItems();
    final itemWidgets = visibleItems
        .map((item) => _buildBreadcrumbItem(item, item != visibleItems.last))
        .toList();

    if (_hasMoreItems() && !showFullPath) {
      itemWidgets.insert(1, _buildShowMoreItem());
    }

    return itemWidgets;
  }

  List<MoonRawBreadcrumbItem> _getVisibleItems() {
    final int count = showFullPath
        ? widget.items.length
        : widget.visibleItemCount;

    if (count == 0) return const [];

    if (widget.items.length <= count) {
      return widget.items;
    }

    return [
      widget.items.first,
      ...widget.items.sublist(widget.items.length - count + 1),
    ];
  }

  bool _hasMoreItems() => widget.items.length > widget.visibleItemCount;

  Widget _buildBreadcrumbItem(MoonRawBreadcrumbItem item, bool addDivider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _BreadcrumbItemBuilder(
          onTap:
              widget.showMoreWidget?.onTap ??
              () => setState(() => showFullPath = true),
          item:
              widget.showMoreWidget ??
              const MoonRawBreadcrumbItem(
                semanticLabel: 'Show full path',
                child: Text('...'),
              ),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    if (widget.divider != null) return widget.divider!;

    final bool isLtr = Directionality.of(context) == TextDirection.ltr;
    return Text(isLtr ? '/' : '\\');
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
      onTap: onTap,
      style: item.style,
      child: item.child,
    );
  }
}
