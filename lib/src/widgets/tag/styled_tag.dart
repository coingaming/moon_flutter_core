import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_widget.dart';
import 'package:moon_core/src/widgets/tag/tag.dart';

class StyledTag extends StatelessWidget {
  const StyledTag({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonRawTag(
      onPress: () {},
      style: Style(
        $box.color(Colors.white),
        $box.borderRadius(4.0),
        $box.padding(4.0, 8.0),
        $flex.mainAxisSize.min(),
        $text.style.fontSize(12),
        $icon.size(12),
        $baseLayout.horizontalGap(2),
      ),
      child: const BaseLayoutWidget(
        inherit: true,
        label: StyledText("MoonTag"),
        trailing: StyledIcon(Icons.close),
      ),
    );
  }
}
