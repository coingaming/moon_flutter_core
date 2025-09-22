import 'package:example/src/common_styles.dart';

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

  Style get _alertStyle => Style(
        $box.chain
          ..padding(16.0)
          ..width(400.0)
          ..borderRadius(8.0),
        $icon.size(16),
      );

  Style get _columnStyle => Style(
        $flex.chain
          ..crossAxisAlignment.start()
          ..gap(8),
        $with.defaultTextStyle(style: TextStyleMix(color: Colors.grey)),
      );

  Style get _rowStyle => Style(
        $flex.gap(12),
        $text.style(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );

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
              style: _alertStyle.add(
                $box.chain
                  ..color(_getBgColor(index))
                  ..border(color: themeColor),
                $icon.color(themeColor),
              ),
              child: StyledColumn(
                style: _columnStyle,
                children: [
                  StyledRow(
                    style: _rowStyle.add($text.style.color(themeColor)),
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: themeColor,
                      ),
                      const Expanded(
                        child: StyledText("MoonAlert"),
                      ),
                      MoonBaseInteractiveWidget(
                        style: getIconButtonStyle().add(
                          $icon.color(themeColor),
                        ),
                        onTap: () =>
                            index == 0 ? setState(() => _show = !_show) : null,
                        child: const StyledIcon(Icons.close),
                      ),
                    ],
                  ),
                  const Text("This is a MoonAlert widget."),
                ],
              ),
            ),
            if (index == 0)
              MoonBaseInteractiveWidget(
                style: getButtonStyle().add(
                  $box.margin.vertical(16),
                ),
                onTap: () => setState(() => _show = !_show),
                child: const StyledText('Toggle Alert'),
              ),
          ],
        );
      },
      separatorBuilder: (BuildContext _, int __) =>
          const SizedBox(height: 16.0),
    );
  }
}
