import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_widget.dart';

class StyledMenuItem extends StatelessWidget {
  const StyledMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Style menuItemStyle = Style(
      // box
      $box.color(Colors.white.withOpacity(0)),
      $box.borderRadius(8),
      $box.padding(16.0),
      $box.border(color: Colors.grey),
      // flex
      $flex.gap(8.0),
      // default
      $baseLayout.leadingIconThemeData.size(24),
      // mix styled icon
      $icon.size(40),
      $icon.color(Colors.grey),
      // states
      ($on.hover | $on.focus | $on.press | $on.longPress)(
        $box.color(Colors.grey.withOpacity(0.2)),
      ),
    ).animate(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );

    return MoonBaseInteractiveWidget(
      onPress: () {},
      style: menuItemStyle,
      child: const BaseLayoutWidget(
        inherit: true,
        leading: StyledIcon(Icons.account_circle_outlined),
        trailing: Icon(Icons.arrow_forward_ios),
        label: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu item"),
              Text("This is a menu item"),
            ],
          ),
        ),
      ),
    );
  }
}
