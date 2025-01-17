import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledToast extends StatelessWidget {
  const StyledToast({super.key});

  Style get _toastStyle => Style(
        $box.chain
          ..color(Colors.black87)
          ..margin(16)
          ..padding(8, 16)
          ..borderRadius(8),
        $flex.chain
          ..gap(8)
          ..mainAxisSize.min(),
        $text.style.color(Colors.white70),
      );

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
