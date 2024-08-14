import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_core/src/widgets/common/base_overlay_widget.dart';

class StyledDropdown extends StatefulWidget {
  const StyledDropdown({super.key});

  @override
  State<StyledDropdown> createState() => _MoonRawSwitchState();
}

class _MoonRawSwitchState extends State<StyledDropdown> {
  bool _showChoices = false;

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      overlayAnchorPosition: OverlayPosition.bottom,
      show: _showChoices,
      onTapOutside: () => setState(() => _showChoices = false),
      target: MoonBaseInteractiveWidget(
        onPress: () => setState(() => _showChoices = !_showChoices),
        child: HBox(
          style: Style(
            $box.width(200),
            $box.height(40),
            $box.padding(8, 16),
            $box.borderRadius(8),
            $box.color(Colors.white),
            $box.border(color: Colors.purple),
            $flex.mainAxisAlignment.spaceBetween(),
          ),
          children: [
            const Text("Choose an option"),
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _showChoices ? -0.5 : 0,
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: VBox(
          style: Style(
            $box.width(200),
            $box.color(Colors.white),
            $box.borderRadius(8),
            $box.border(color: Colors.purple),
            $box.padding(16),
            $flex.crossAxisAlignment.start(),
          ),
          children: List.generate(
            3,
            (int index) => Text('Choose menu item nr ${index + 1}.'),
          ),
        ),
      ),
    );
  }
}
