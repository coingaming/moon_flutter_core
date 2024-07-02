import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/utils/extensions.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

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
        $flex.gap(2.0),
        // flex
        $flex.mainAxisSize.min(),
        // icon ($with.iconTheme gets fully supressed by this)
        //$icon.size(12),
        $with.iconTheme.data(
          color: Colors.black,
          size: 12,
        ),

        // text ($with.defaultTextStyle gets partially supressed by this)
        //$text.style.fontSize(12),

        $with.defaultTextStyle.style(
          color: Colors.black,
          fontSize: 12,
          height: 1.0,
        ),
      ),
      child: const StyledRow(
        inherit: true,
        children: [
          Text("MoonTag"),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
