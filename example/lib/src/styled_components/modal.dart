import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledModal extends StatelessWidget {
  const StyledModal({super.key});

  Style get _modalStyle => Style(
    $box.chain
      ..height(200)
      ..width(300)
      ..borderRadius(16)
      ..color(Colors.deepPurple.shade200),
    $with.align(),
  );

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      style: getButtonStyle(),
      onTap: () => showMoonRawModal<void>(
        context: context,
        transitionDuration: const Duration(milliseconds: 300),
        builder: (BuildContext context) {
          return Box(
            style: _modalStyle,
            child: Center(
              child: MoonBaseInteractiveWidget(
                style: getButtonStyle(),
                child: const StyledText("Close modal"),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          );
        },
      ),
      child: const StyledText("Show modal"),
    );
  }
}
