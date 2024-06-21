import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/modifiers/modifiers_utility.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_widget.dart';

class StyledTag extends StatelessWidget {
  const StyledTag({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onPress: () {},
      style: Style(
        // box
        $box.color(Colors.white),
        $box.borderRadius(4.0),
        $box.padding(4.0, 8.0),
        // $baseLayout
        $baseLayout.horizontalGap(2.0),
        // flex
        $flex.mainAxisSize.min(),
        // icon
        $icon.size(12),
        // text
        $text.style.fontSize(12),
      ),
      child: const BaseLayoutWidget(
        inherit: true,
        label: StyledText("MoonTag"),
        trailing: StyledIcon(Icons.close),
      ),
    );
  }
}
