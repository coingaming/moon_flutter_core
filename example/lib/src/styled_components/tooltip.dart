import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledTooltip extends StatefulWidget {
  const StyledTooltip({super.key});

  @override
  State<StyledTooltip> createState() => _StyledTooltipState();
}

class _StyledTooltipState extends State<StyledTooltip> {
  bool _showHoveredTooltip = false;
  bool _showTappedTooltip = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            2,
            (int index) => MoonRawTooltip(
              show: index == 0 ? _showHoveredTooltip : _showTappedTooltip,
              onTap: index == 0
                  ? null
                  : () => setState(() => _showTappedTooltip = false),
              onTargetHover: index == 0
                  ? () =>
                      setState(() => _showHoveredTooltip = !_showHoveredTooltip)
                  : null,
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              tooltipShadows: const [
                BoxShadow(
                  color: Color(0x8E000000),
                  blurRadius: 1,
                ),
                BoxShadow(
                  color: Color(0xA3000000),
                  blurRadius: 6,
                  offset: Offset(0, 6),
                  spreadRadius: -6,
                ),
              ],
              target: MoonBaseInteractiveWidget(
                style: getButtonStyle(),
                onTap: () {
                  if (index == 1) {
                    setState(() => _showTappedTooltip = !_showTappedTooltip);
                  }
                },
                child: StyledText(
                  index == 0 ? "Hover for tooltip" : "Tap for tooltip",
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("This is tooltip"),
                    if (index == 1)
                      MoonBaseInteractiveWidget(
                        style: getIconButtonStyle(),
                        onTap: () => setState(
                          () => _showTappedTooltip = !_showTappedTooltip,
                        ),
                        child: const StyledIcon(Icons.close),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
