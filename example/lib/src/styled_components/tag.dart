import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledTag extends StatelessWidget {
  const StyledTag({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onTap: () {},
      style: Style(
        $box.color(Colors.white),
        $box.borderRadius(4.0),
        $box.padding(4.0, 8.0),
        $flex.gap(2.0),
        $flex.mainAxisSize.min(),
        $with.iconTheme.data(
          color: Colors.black,
          size: 12,
        ),
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
