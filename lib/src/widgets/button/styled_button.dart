import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/extensions.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Style activeStateStyle = Style(
      $box.color(Colors.grey.shade300),
      $with.iconTheme(data: const IconThemeData(color: Colors.blue, size: 14)),
      $with.defaultTextStyle(style: const TextStyle(color: Colors.blue)),
    );

    final Style buttonStyle = Style(
      // box
      $box.color(Colors.white),
      $box.borderRadius(8),
      $box.border(color: Colors.black38),
      $box.padding(8.0),
      // flex
      $flex.gap(8.0),
      $flex.mainAxisSize.min(),
      // with
      $with.scale(1),
      $with.opacity(1),
      $with.defaultTextStyle(style: const TextStyle(color: Colors.black)),
      $with.iconTheme(data: const IconThemeData(color: Colors.black, size: 24)),
      // states
      ($on.hover | $on.focus)(
        activeStateStyle(),
      ),
      ($on.press | $on.longPress)(
        activeStateStyle(),
        $with.scale(0.95),
      ),
    ).animate(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );

    return MoonBaseInteractiveWidget(
      onPress: () {},
      style: buttonStyle,
      child: const StyledRow(
        inherit: true,
        children: [
          Icon(Icons.widgets_outlined),
          Text("MoonButton"),
          Icon(Icons.widgets_outlined),
        ],
      ),
    );
  }
}
