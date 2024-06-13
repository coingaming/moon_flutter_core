import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/utils/base_layout_widget.dart';
import 'package:moon_core/src/utils/methods.dart';

class StyledAlert extends StatelessWidget {
  const StyledAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final Style iconStyle = Style(
      $icon.size(16),
    );

    return Column(
      children: List.generate(
        3,
        (index) {
          final Color themeColor = index == 0
              ? Colors.black
              : index == 1
                  ? Colors.red
                  : Colors.green;

          final Color bgColor = index == 0
              ? Colors.white
              : index == 1
                  ? Colors.red.shade50
                  : Colors.transparent;

          return Column(
            children: [
              MoonRawAlert(
                style: Style(
                  $box.padding(16.0),
                  $box.width(400.0),
                  decorationToAttribute(
                    BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: index == 2 ? Border.all(color: themeColor) : null,
                    ),
                  ),
                ),
                child: BaseLayoutWidget(
                  defaultIconStyle: IconThemeData(color: themeColor),
                  defaultTextStyle: TextStyle(color: themeColor),
                  headerStyle: Style(
                    $flex.gap(12.0),
                  ),
                  verticalGapStyle: Style(
                    $box.height(12.0),
                  ),
                  leading: StyledIcon(
                    style: iconStyle,
                    Icons.info_outline,
                  ),
                  label: const Text("MoonAlert"),
                  trailing: StyledIcon(
                    style: iconStyle,
                    Icons.close,
                  ),
                  content: const Text("This is a MoonAlert widget."),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          );
        },
      ),
    );
  }
}
