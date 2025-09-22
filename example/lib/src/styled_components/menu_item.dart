import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledMenuItem extends StatelessWidget {
  const StyledMenuItem({super.key});

  Style get _menuItemStyle => Style(
    $box.chain
      ..color(Colors.white)
      ..borderRadius(8)
      ..padding(16.0),
    $flex.gap(16.0),
    $with.defaultTextStyle(
      style: TextStyleMix(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    $with.iconTheme(color: Colors.grey, size: 24),
  ).merge(getEffects()).animate();

  Style get _descriptionStyle => Style(
    $text.style(
      color: Colors.grey,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
  );

  Style get _columnStyle => Style(
    $flex.chain
      ..crossAxisAlignment.start()
      ..gap(4.0),
  );

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onTap: () {},
      style: _menuItemStyle,
      child: StyledRow(
        inherit: true,
        children: [
          const Icon(Icons.account_circle_outlined),
          Expanded(
            child: StyledColumn(
              style: _columnStyle,
              children: [
                const StyledText("Menu item"),
                StyledText(style: _descriptionStyle, "This is a menu item"),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
