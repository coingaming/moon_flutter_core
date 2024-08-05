import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';
import 'package:moon_core/src/widgets/modal/modal.dart';

class StyledModal extends StatelessWidget {
  const StyledModal({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      style: Style(
        $box.color(Colors.deepPurpleAccent),
        $box.padding(8, 16),
        $box.borderRadius(8),
        $text.style.color(Colors.white),
      ),
      onPress: () => showMoonRawModal<void>(
        context: context,
        transitionDuration: const Duration(milliseconds: 300),
        builder: (BuildContext context) {
          return Box(
            style: Style(
              $box.height(200),
              $box.width(300),
              $box.borderRadius(16),
              $box.color(Colors.deepPurple.shade200),
              $with.align(),
            ),
            child: Center(
              child: MoonBaseInteractiveWidget(
                style: Style(
                  $box.color(Colors.white),
                  $box.padding(8, 16),
                  $box.borderRadius(8),
                ),
                child: const Text("Close modal"),
                onPress: () => Navigator.of(context).pop(),
              ),
            ),
          );
        },
      ),
      child: const StyledText('Show modal'),
    );
  }
}
