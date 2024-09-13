import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

class StyledSwitch extends StatefulWidget {
  const StyledSwitch({super.key});

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool switchValue = false;
  bool switchTextValue = false;
  bool switchIconValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawSwitch(
          value: switchValue,
          thumbAnimatesWithOvershoot: false,
          switchStyle: Style(
            $box.width(64),
            $box.height(32),
          ),
          thumbStyle: Style(
            $box.width(24),
            $box.height(24),
            $box.color(switchValue ? Colors.deepPurple : Colors.purple),
            $box.borderRadius(switchValue ? 6 : 14),
            $on.focus(
              $box.border(
                color: Colors.grey.shade400,
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
          onChanged: (bool newValue) => setState(() => switchValue = newValue),
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
          value: switchTextValue,
          onChanged: (bool newValue) =>
              setState(() => switchTextValue = newValue),
          activeThumbWidget: const Icon(Icons.check, size: 12),
          inactiveThumbWidget: const Icon(Icons.close, size: 12),
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
          value: switchIconValue,
          onChanged: (bool newValue) =>
              setState(() => switchIconValue = newValue),
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
