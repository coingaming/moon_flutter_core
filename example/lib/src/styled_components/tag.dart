import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledTag extends StatelessWidget {
  const StyledTag({super.key});

  Style get _tagStyle => Style(
    $box.chain
      ..color(Colors.white)
      ..borderRadius(4.0)
      ..padding(4.0, 8.0),
    $flex.chain
      ..gap(2.0)
      ..mainAxisSize.min(),
    $icon.size(12),
    $text.style(fontSize: 12, height: 1.0),
  );

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      focusNode: FocusNode(skipTraversal: true),
      onTap: () {},
      style: _tagStyle,
      child: const StyledRow(
        inherit: true,
        children: const [
          StyledText("MoonTag"),
          StyledIcon(icon: Icons.close),
        ],
      ),
    );
  }
}
