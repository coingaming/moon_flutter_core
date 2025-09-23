import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledTag extends StatelessWidget {
  const StyledTag({super.key});

  BoxStyler get _tagStyle => BoxStyler()
      .color(Colors.white)
      .borderRadius(BorderRadiusGeometryMix.circular(4))
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 8, vertical: 4),
      )
      .wrapDefaultTextStyle(TextStyleMix(fontSize: 12, height: 1))
      .wrapIconTheme(const IconThemeData(size: 12))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 120)),
      );

  FlexBoxStyler get _tagContentStyle => FlexBoxStyler()
      .spacing(4)
      .mainAxisSize(MainAxisSize.min)
      .crossAxisAlignment(CrossAxisAlignment.center);

  IconStyler get _iconStyle => IconStyler().size(12);

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      focusNode: FocusNode(skipTraversal: true),
      onTap: () {},
      style: _tagStyle,
      child: RowBox(
        style: _tagContentStyle,
        children: [
          const StyledText("MoonTag"),
          StyledIcon(icon: Icons.close, style: _iconStyle),
        ],
      ),
    );
  }
}
