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
  bool _showTappedTooltip2 = false;

  final int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          3,
          (int index) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return MoonRawTooltip(
                show: index == 0
                    ? _showHoveredTooltip
                    : index == 1
                        ? _showTappedTooltip
                        : _showTappedTooltip2,
                backgroundColor: Colors.white,
                tooltipMargin: 8,
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
                target: MouseRegion(
                  onEnter: index == 0
                      ? (_) => setState(() => _showHoveredTooltip = true)
                      : null,
                  onExit: index == 0
                      ? (_) => setState(() => _showHoveredTooltip = false)
                      : null,
                  child: MoonBaseInteractiveWidget(
                    style: getButtonStyle(),
                    onTap: () {
                      if (index > 0) {
                        setState(
                          () => index == 1
                              ? _showTappedTooltip = !_showTappedTooltip
                              : _showTappedTooltip2 = !_showTappedTooltip2,
                        );
                      }
                    },
                    child: StyledText(
                      index == 0 ? "Hover for tooltip" : "Tap for tooltip",
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("This is tooltip"),
                      if (index > 0)
                        MoonBaseInteractiveWidget(
                          style: getIconButtonStyle(),
                          onTap: () => setState(
                            () => index == 1
                                ? _showTappedTooltip = false
                                : _showTappedTooltip2 = false,
                          ),
                          child: const StyledIcon(Icons.close),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
