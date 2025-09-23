import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledMenuItem extends StatelessWidget {
  const StyledMenuItem({super.key});

  BoxStyler get _menuItemStyle {
    final BoxStyler hoverFocusStyle = BoxStyler()
        .color(Colors.grey.shade100)
        .wrapDefaultTextStyle(
          TextStyleMix(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
        .wrapIconTheme(
          const IconThemeData(color: Colors.blue, size: 24),
        );

    final BoxStyler pressedStyle =
        BoxStyler().wrapScale(x: 0.98, y: 0.98);

    return BoxStyler()
        .color(Colors.white)
        .borderRadius(BorderRadiusGeometryMix.circular(8))
        .padding(EdgeInsetsGeometryMix.all(16))
        .wrapDefaultTextStyle(
          TextStyleMix(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
        .wrapIconTheme(
          const IconThemeData(color: Colors.grey, size: 24),
        )
        .onHovered(hoverFocusStyle)
        .onFocused(hoverFocusStyle)
        .onPressed(pressedStyle)
        .animate(AnimationConfig.ease(const Duration(milliseconds: 200)));
  }

  FlexBoxStyler get _contentStyle =>
      FlexBoxStyler().spacing(16).mainAxisAlignment(MainAxisAlignment.start);

  FlexBoxStyler get _columnStyle => FlexBoxStyler()
      .spacing(4)
      .crossAxisAlignment(CrossAxisAlignment.start);

  static const TextStyle _descriptionTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onTap: () {},
      style: _menuItemStyle,
      child: RowBox(
        style: _contentStyle,
        children: [
          const Icon(Icons.account_circle_outlined),
          Expanded(
            child: ColumnBox(
              style: _columnStyle,
              children: [
                const Text("Menu item"),
                Text("This is a menu item", style: _descriptionTextStyle),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
