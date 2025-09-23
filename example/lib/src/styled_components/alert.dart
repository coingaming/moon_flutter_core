import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledAlert extends StatefulWidget {
  const StyledAlert({super.key});

  @override
  State<StyledAlert> createState() => _StyledAlertState();
}

class _StyledAlertState extends State<StyledAlert> {
  bool _show = true;

  Color _getThemeColor(int index) => index == 0
      ? Colors.black
      : index == 1
      ? Colors.red
      : Colors.green;

  Color _getBgColor(int index) => index == 0
      ? Colors.white
      : index == 1
      ? Colors.red.shade50
      : Colors.transparent;

  BoxStyler _alertStyle(Color themeColor, Color backgroundColor) => BoxStyler()
      .padding(EdgeInsetsGeometryMix.all(16))
      .constraints(BoxConstraintsMix(maxWidth: 400))
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(8)),
      )
      .border(
        BorderMix.all(
          BorderSideMix.value(BorderSide(color: themeColor, width: 1)),
        ),
      )
      .color(backgroundColor)
      .wrapDefaultTextStyle(
        TextStyleMix(color: Colors.grey.shade700),
      )
      .animate(AnimationConfig(duration: const Duration(milliseconds: 200)));

  BoxStyler get _triggerButtonStyle => BoxStyler()
      .padding(EdgeInsetsGeometryMix.symmetric(horizontal: 16, vertical: 8))
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(8)),
      )
      .color(Colors.purple)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.white))
      .onHovered(BoxStyler().color(Colors.purple.shade600))
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              BorderSide(color: Colors.purple.shade200, width: 2),
            ),
          ),
        ),
      )
      .animate(AnimationConfig(duration: const Duration(milliseconds: 150)));

  BoxStyler _iconButtonStyle(Color themeColor) => BoxStyler()
      .padding(EdgeInsetsGeometryMix.all(6))
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(32)),
      )
      .wrapDefaultTextStyle(TextStyleMix(color: themeColor))
      .onHovered(
        BoxStyler().color(themeColor.withOpacity(0.08)),
      )
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              BorderSide(color: themeColor.withOpacity(0.3), width: 2),
            ),
          ),
        ),
      )
      .animate(AnimationConfig(duration: const Duration(milliseconds: 150)));

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (BuildContext _, int index) {
        final Color themeColor = _getThemeColor(index);

        return Column(
          children: [
            MoonRawAlert(
              show: (index > 0) || index == 0 && _show,
              style: _alertStyle(themeColor, _getBgColor(index)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: themeColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'MoonAlert',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeColor,
                          ),
                        ),
                      ),
                      MoonBaseInteractiveWidget(
                        style: _iconButtonStyle(themeColor),
                        onTap: index == 0
                            ? () => setState(() => _show = !_show)
                            : null,
                        child: Icon(Icons.close, color: themeColor, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('This is a MoonAlert widget.'),
                ],
              ),
            ),
            if (index == 0)
              MoonBaseInteractiveWidget(
                style: _triggerButtonStyle.margin(
                  EdgeInsetsGeometryMix.symmetric(vertical: 16),
                ),
                onTap: () => setState(() => _show = !_show),
                child: const Text('Toggle Alert'),
              ),
          ],
        );
      },
      separatorBuilder: (BuildContext _, int __) =>
          const SizedBox(height: 16.0),
    );
  }
}
