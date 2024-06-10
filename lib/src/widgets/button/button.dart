import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MoonRawButton extends StatelessWidget {
  final double? height;
  final Style? style;

  const MoonRawButton({
    super.key,
    this.height,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Style(
      $box.height(height ?? 100),
      $box.margin.vertical(10),
      $box.elevation(0),
      $box.borderRadius(10),
      $box.color(Colors.blue),
      $text.style(color: Colors.black),
      $with.scale(1),
      $on.hover(
        $box.elevation(2),
        $box.padding(10),
        $with.scale(1.1),
        $box.color(Colors.red),
        $text.style(color: Colors.grey),
      ),
    ).merge(style);
    return PressableBox(
      onPress: () {
        // do something
      },
      style: defaultStyle,
      child: const StyledText('Custom Widget'),
    );
  }
}
