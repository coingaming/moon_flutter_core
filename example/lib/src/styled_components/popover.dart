import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledPopover extends StatefulWidget {
  const StyledPopover({super.key});

  @override
  State<StyledPopover> createState() => _StyledPopoverState();
}

class _StyledPopoverState extends State<StyledPopover> {
  bool _show = false;

  Style get _popoverStyle => Style(
        $box.chain
          ..height(100)
          ..width(150)
          ..borderRadius(16)
          ..color(Colors.deepPurple.shade200),
      );

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      show: _show,
      onTapOutside: () => setState(() => _show = false),
      target: MoonBaseInteractiveWidget(
        onTap: () => setState(() => _show = !_show),
        style: getButtonStyle(),
        child: const StyledText("Show popover"),
      ),
      child: Box(
        style: _popoverStyle,
        child: Center(
          child: MoonBaseInteractiveWidget(
            style: getButtonStyle(),
            child: const Text("Close popover"),
            onTap: () => setState(() => _show = false),
          ),
        ),
      ),
    );
  }
}
