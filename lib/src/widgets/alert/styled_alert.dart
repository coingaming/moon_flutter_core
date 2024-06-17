import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/alert/alert.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_widget.dart';

class StyledAlert extends StatelessWidget {
  const StyledAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext _, int index) {
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
                $box.color(bgColor),
                $box.borderRadius(8.0),
                index == 2 ? $box.border(color: themeColor) : null,
              ),
              child: BaseLayoutWidget(
                style: Style(
                  $baseLayout.horizontalGap(12),
                  $baseLayout.verticalGap(8),
                  $baseLayout.labelTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  $baseLayout.contentTextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  // Applies to regular icons
                  $baseLayout.defaultIconStyle(
                    IconThemeData(
                      color: themeColor,
                      size: 24,
                    ),
                  ),
                  // Applies to styled icons
                  $icon.size(16),
                  $icon.color(themeColor),
                ),
                leading: const Icon(Icons.info_outline),
                label: const Expanded(
                  child: Text("MoonAlert"),
                ),
                trailing: const StyledIcon(Icons.close),
                content: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "This is a MoonAlert widget.",
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext _, int __) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
