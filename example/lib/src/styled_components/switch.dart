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

  BoxStyler get _switchTrackStyle => BoxStyler()
      .constraints(BoxConstraintsMix.width(64))
      .constraints(BoxConstraintsMix.height(32));

  BoxStyler _customThumbStyle(bool isActive) => BoxStyler()
      .constraints(BoxConstraintsMix.square(20))
      .color(isActive ? Colors.deepPurple : Colors.purple)
      .borderRadius(
        BorderRadiusGeometryMix.value(
          BorderRadius.circular(isActive ? 6 : 14),
        ),
      )
      .border(
        BorderMix.all(
          BorderSideMix.value(
            const BorderSide(
              color: Colors.transparent,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      )
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              BorderSide(
                color: Colors.grey.shade400,
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
        ),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  BoxStyler get _thumbStyle => BoxStyler()
      .constraints(BoxConstraintsMix.square(16))
      .color(Colors.white)
      .borderRadius(
        BorderRadiusGeometryMix.value(
          BorderRadius.circular(32),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawSwitch(
          value: _switchValue,
          thumbAnimatesWithOvershoot: false,
          switchStyle: _switchTrackStyle,
          thumbStyle: _customThumbStyle(_switchValue),
          onChanged: (bool newValue) => setState(() => _switchValue = newValue),
          trackDecorationTween: DecorationTween(
            begin: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple, width: 2),
            ),
            end: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.1),
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
          switchStyle: _switchTrackStyle,
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
          switchStyle: _switchTrackStyle,
          activeTrackWidget: const Icon(
            Icons.nightlight_outlined,
            size: 12,
            color: Colors.white,
          ),
          inactiveTrackWidget: const Icon(Icons.wb_sunny_outlined, size: 12),
        ),
      ],
    );
  }
}
