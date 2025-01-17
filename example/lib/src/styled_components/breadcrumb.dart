import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledBreadcrumb extends StatefulWidget {
  const StyledBreadcrumb({super.key});

  @override
  State<StyledBreadcrumb> createState() => _StyledBreadcrumbState();
}

class _StyledBreadcrumbState extends State<StyledBreadcrumb> {
  Duration get _duration => const Duration(milliseconds: 150);
  int _pagesCount = 7;

  Style get _showMoreWidgetStyle => Style(
        $box.padding.horizontal(8),
        $icon.chain
          ..color(Colors.black54)
          ..size(14),
        ($on.hover | $on.focus)(
          $box.padding.horizontal(12),
          $icon.color(Colors.black),
        ),
      ).animate(duration: _duration);

  Style get _breadcrumbItemStyle => Style(
        $box.padding.horizontal(8),
        $text.style.color(Colors.black54),
        ($on.hover | $on.focus)(
          $text.style.color(Colors.black),
        ),
        SelectedState.selected(
          $text.style.color(Colors.black),
        ),
      ).animate(duration: _duration);

  Variant _getVariant(int index) => index == _pagesCount - 1
      ? SelectedState.selected
      : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    return MoonRawBreadcrumb(
      showMoreWidget: MoonRawBreadcrumbItem(
        style: _showMoreWidgetStyle,
        child: const StyledIcon(Icons.menu),
      ),
      items: List.generate(
        _pagesCount,
        (int index) {
          final String itemName = index == 0 ? "Home" : "Page $index";

          return MoonRawBreadcrumbItem(
            style: _breadcrumbItemStyle.applyVariant(_getVariant(index)),
            child: StyledText(itemName),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 400),
                  content: Center(
                    child: Text(itemName),
                  ),
                ),
              );
              setState(() => _pagesCount = index + 1);
            },
          );
        },
      ),
    );
  }
}
