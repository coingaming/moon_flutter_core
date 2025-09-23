import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledDrawer extends StatelessWidget {
  const StyledDrawer({super.key});

  BoxStyler get _drawerStyle => BoxStyler()
      .color(Colors.lime)
      .borderRadius(
        BorderRadiusGeometryMix.value(
          const BorderRadiusDirectional.only(
            topEnd: Radius.circular(16),
            bottomEnd: Radius.circular(16),
          ),
        ),
      )
      .width(300)
      .padding(EdgeInsetsGeometryMix.all(24))
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black87))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 180)),
      );

  @override
  Widget build(BuildContext context) {
    return Box(
      style: _drawerStyle,
      child: ColumnBox(
        style: FlexBoxStyler()
            .spacing(24)
            .mainAxisAlignment(MainAxisAlignment.center)
            .crossAxisAlignment(CrossAxisAlignment.center),
        children: [
          const StyledText("MoonRawDrawer"),
          Builder(
            builder: (BuildContext context) {
              return MoonBaseInteractiveWidget(
                style: getButtonStyle(),
                onTap: () => Navigator.of(context).pop(),
                child: const StyledText("Close"),
              );
            },
          ),
        ],
      ),
    );
  }
}
