import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledBreadcrumb extends StatefulWidget {
  const StyledBreadcrumb({super.key});

  @override
  State<StyledBreadcrumb> createState() => _StyledBreadcrumbState();
}

class _StyledBreadcrumbState extends State<StyledBreadcrumb> {
  static const Duration _duration = Duration(milliseconds: 150);
  int _pagesCount = 7;

  BoxStyler get _showMoreStyle => BoxStyler()
      .padding(EdgeInsetsGeometryMix.symmetric(horizontal: 8, vertical: 4))
      .borderRadius(
        BorderRadiusGeometryMix.value(
          BorderRadius.circular(8),
        ),
      )
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black54))
      .onHovered(
        BoxStyler()
            .color(Colors.grey.shade200)
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.black)),
      )
      .onFocused(
        BoxStyler()
            .color(Colors.grey.shade300)
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.black)),
      )
      .animate(AnimationConfig(duration: _duration));

  BoxStyler get _breadcrumbBaseStyle => BoxStyler()
      .padding(EdgeInsetsGeometryMix.symmetric(horizontal: 8, vertical: 4))
      .borderRadius(
        BorderRadiusGeometryMix.value(
          BorderRadius.circular(6),
        ),
      )
      .onHovered(
        BoxStyler().wrapDefaultTextStyle(TextStyleMix(color: Colors.black)),
      )
      .animate(AnimationConfig(duration: _duration));

  BoxStyler get _breadcrumbInactiveStyle =>
      BoxStyler().wrapDefaultTextStyle(TextStyleMix(color: Colors.black54));

  BoxStyler get _breadcrumbActiveStyle =>
      BoxStyler().wrapDefaultTextStyle(TextStyleMix(color: Colors.black));

  @override
  Widget build(BuildContext context) {
    return MoonRawBreadcrumb(
      style: FlexBoxStyler()
          .mainAxisSize(MainAxisSize.min)
          .crossAxisAlignment(CrossAxisAlignment.center)
          .spacing(8),
      divider: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text('/'),
      ),
      showMoreWidget: MoonRawBreadcrumbItem(
        style: _showMoreStyle,
        child: const Icon(Icons.menu, size: 14, color: Colors.black54),
      ),
      items: List.generate(_pagesCount, (int index) {
        final String itemName = index == 0 ? "Home" : "Page $index";
        final bool isActive = index == _pagesCount - 1;
        final BoxStyler itemStyle = _breadcrumbBaseStyle.merge(
          isActive ? _breadcrumbActiveStyle : _breadcrumbInactiveStyle,
        );

        return MoonRawBreadcrumbItem(
          style: itemStyle,
          child: Text(itemName),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 400),
                content: Center(child: Text(itemName)),
              ),
            );
            setState(() => _pagesCount = index + 1);
          },
        );
      }),
    );
  }
}
