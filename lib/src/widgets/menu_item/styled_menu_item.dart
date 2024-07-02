import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/utils/extensions.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

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
      $flex.gap(16.0),
      // default
      $with.defaultTextStyle.style(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      $with.iconTheme.data(
        color: Colors.grey,
        size: 24,
      ),

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
      child: StyledRow(
        inherit: true,
        children: [
          const Icon(Icons.account_circle_outlined),
          Expanded(
            child: StyledColumn(
              style: Style(
                $flex.crossAxisAlignment.start(),
                $flex.gap(4.0),
              ),
              children: [
                const Text("Menu item"),
                SpecBuilder(
                  style: Style(
                    $with.defaultTextStyle(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  builder: (context) {
                    return const Text("This is a menu item");
                  },
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
