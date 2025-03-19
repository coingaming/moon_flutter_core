import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledSwitch extends StatefulWidget {
  const StyledSwitch({super.key});

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool _switchValue = false;
  bool _switchTextValue = false;
  bool _switchIconValue = false;

  Style get _switchStyle => Style(
        $box.chain
          ..width(64)
          ..height(32),
      );

  Style get _customThumbStyle => Style(
        $box.chain
          ..width(20)
          ..height(20)
          ..color(_switchValue ? Colors.deepPurple : Colors.purple)
          ..borderRadius(_switchValue ? 6 : 14)
          ..border(
            color: Colors.transparent,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        $on.focus(
          $box.border(
            color: Colors.grey.shade400,
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ).animate();

  Style get _thumbStyle => Style(
        $box.chain
          ..width(16)
          ..height(16)
          ..color(Colors.white)
          ..borderRadius(32),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawSwitch(
          value: _switchValue,
          thumbAnimatesWithOvershoot: false,
          switchStyle: _switchStyle,
          thumbStyle: _customThumbStyle,
          onChanged: (bool newValue) => setState(() => _switchValue = newValue),
          trackDecorationTween: DecorationTween(
            begin: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple, width: 2),
            ),
            end: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.deepPurple, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),
        MoonRawSwitch(
          value: _switchTextValue,
          focusNode: FocusNode(skipTraversal: true),
          onChanged: (bool newValue) =>
              setState(() => _switchTextValue = newValue),
          activeThumbWidget: const Icon(Icons.check, size: 12),
          inactiveThumbWidget: const Icon(Icons.close, size: 12),
          thumbStyle: _thumbStyle,
          activeTrackWidget: const Text(
            "ON",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8, color: Colors.white),
          ),
          inactiveTrackWidget: const Text(
            "OFF",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8),
          ),
        ),
        const SizedBox(height: 32),
        MoonRawSwitch(
          value: _switchIconValue,
          focusNode: FocusNode(skipTraversal: true),
          onChanged: (bool newValue) =>
              setState(() => _switchIconValue = newValue),
          thumbStyle: _thumbStyle,
          activeTrackWidget: const Icon(
            Icons.nightlight_outlined,
            size: 12,
            color: Colors.white,
          ),
          inactiveTrackWidget: const Icon(
            Icons.wb_sunny_outlined,
            size: 12,
          ),
        ),
      ],
    );
  }
}
