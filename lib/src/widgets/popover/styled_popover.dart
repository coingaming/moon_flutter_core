import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';
import 'package:moon_core/src/widgets/common/base_overlay_widget.dart';

class StyledPopover extends StatefulWidget {
  const StyledPopover({super.key});

  @override
  State<StyledPopover> createState() => _StyledPopoverState();
}

class _StyledPopoverState extends State<StyledPopover> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      show: _show,
      onTapOutside: () => setState(() => _show = false),
      target: MoonBaseInteractiveWidget(
        onPress: () => setState(() => _show = !_show),
        style: Style(
          $box.color(Colors.deepPurpleAccent),
          $box.padding(8, 16),
          $box.borderRadius(8),
          $text.style.color(Colors.white),
        ),
        child: const StyledText("Show popover"),
      ),
      child: Box(
        style: Style(
          $box.height(100),
          $box.width(150),
          $box.borderRadius(16),
          $box.color(Colors.deepPurple.shade200),
        ),
        child: Center(
          child: MoonBaseInteractiveWidget(
            style: Style(
              $box.color(Colors.white),
              $box.padding(8, 16),
              $box.borderRadius(8),
            ),
            child: const Text("Close popover"),
            onPress: () => setState(() => _show = false),
          ),
        ),
      ),
    );
  }
}
