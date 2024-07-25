import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

class StyledToast extends StatelessWidget {
  const StyledToast({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      style: Style(
        $box.color(Colors.deepPurpleAccent),
        $box.padding(8, 16),
        $box.borderRadius(8),
        $text.style.color(Colors.white),
      ),
      onPress: () => MoonRawToast.show(
        context,
        style: Style(
          $box.color(Colors.black87),
          $box.margin(16),
          $box.padding(8, 16),
          $box.borderRadius(8),
          $text.style.color(Colors.white70),
          $flex.gap(8),
          $flex.mainAxisSize.min(),
        ),
        child: const StyledText('This is toast content!'),
      ),
      child: const StyledText('Show toast'),
    );
  }
}
