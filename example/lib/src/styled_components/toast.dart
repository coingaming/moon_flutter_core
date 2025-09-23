import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledToast extends StatelessWidget {
  const StyledToast({super.key});

  BoxStyler get _toastStyle => BoxStyler()
      .color(Colors.black87)
      .margin(EdgeInsetsGeometryMix.all(16))
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 16, vertical: 8),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.white70));

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      style: getButtonStyle(),
      onTap: () => MoonRawToast.show(
        context,
        style: _toastStyle,
        child: const StyledText("This is toast content!"),
      ),
      child: const StyledText("Show toast"),
    );
  }
}
