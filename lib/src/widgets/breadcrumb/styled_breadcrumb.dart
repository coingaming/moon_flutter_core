import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/breadcrumb/breadcrumb.dart';
import 'package:moon_core/src/widgets/breadcrumb/breadcrumb_item.dart';
import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';

class StyledBreadcrumb extends StatefulWidget {
  const StyledBreadcrumb({super.key});

  @override
  State<StyledBreadcrumb> createState() => _StyledBreadcrumbState();
}

class _StyledBreadcrumbState extends State<StyledBreadcrumb> {
  Duration get _duration => const Duration(milliseconds: 150);
  int _pagesCount = 7;

  Variant _getVariant(int index) => index == _pagesCount - 1
      ? SelectedState.selected
      : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    return MoonRawBreadcrumb(
      showMoreWidget: MoonRawBreadcrumbItem(
        style: Style(
          $box.padding.horizontal(8),
          $icon.color(Colors.black54),
          $icon.size(14),
          ($on.hover | $on.focus)(
            $box.padding.horizontal(12),
            $icon.color(Colors.black),
          ),
        ).animate(duration: _duration),
        child: const StyledIcon(Icons.menu),
      ),
      items: List.generate(
        _pagesCount,
        (int index) {
          final String itemName = index == 0 ? 'Home' : 'Page $index';

          return MoonRawBreadcrumbItem(
            style: Style(
              $box.padding.horizontal(8),
              $text.style.color(Colors.black54),
              ($on.hover | $on.focus)(
                $text.style.color(Colors.black),
              ),
              SelectedState.selected(
                $text.style.color(Colors.black),
              ),
            ).applyVariant(_getVariant(index)).animate(duration: _duration),
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
