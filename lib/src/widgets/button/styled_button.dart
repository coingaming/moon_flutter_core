import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/modifiers/modifiers_utility.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_widget.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Style activeStateStyle = Style(
      $box.color(Colors.grey.shade300),
      $default.icon.theme(color: Colors.blue, size: 14),
      $default.text.style(color: Colors.blue),
    );

    final Style buttonStyle = Style(
      // box
      $box.color(Colors.white),
      $box.borderRadius(8),
      $box.border(color: Colors.black38),
      $box.padding(8.0),
      // $baseLayout
      $baseLayout.horizontalGap(8.0),
      // flex
      $flex.mainAxisSize.min(),
      // default
      $default.icon.theme(color: Colors.black, size: 14),
      $default.text.style(color: Colors.black),
      // with
      $with.scale(1),
      $with.opacity(1),
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
      child: const BaseLayoutWidget(
        inherit: true,
        leading: Icon(Icons.widgets_outlined),
        label: Text("MoonButton"),
        trailing: Icon(Icons.widgets_outlined),
      ),
    );
  }
}
