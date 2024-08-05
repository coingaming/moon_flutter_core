import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/extensions.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class DemoButton extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  const DemoButton({
    super.key,
    this.leading,
    this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final Style activeStateStyle = Style(
      $box.color(Colors.grey.shade300),
      $with.iconTheme.data(
        color: Colors.blue,
        size: 16,
      ),
      $with.defaultTextStyle.style(color: Colors.blue),
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
      $with.defaultTextStyle.style(color: Colors.black),
      $with.iconTheme.data(
        color: Colors.black,
        size: 16,
      ),
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
      child: StyledRow(
        inherit: true,
        children: [
          if (leading != null) leading!,
          if (title != null) title!,
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
