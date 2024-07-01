import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/extensions.dart';
import 'package:moon_core/src/widgets/alert/alert.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class StyledAlert extends StatefulWidget {
  const StyledAlert({super.key});

  @override
  State<StyledAlert> createState() => _StyledAlertState();
}

class _StyledAlertState extends State<StyledAlert> {
  bool show = true;

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

        final Style alertStyle = Style(
          $box.padding(16.0),
          $box.width(400.0),
          $box.color(bgColor),
          $box.borderRadius(8.0),
          index == 2 ? $box.border(color: themeColor) : null,
          $icon.size(16),
          $icon.color(themeColor),
        );

        return Column(
          children: [
            MoonRawAlert(
              show: index == 0 && show,
              style: alertStyle,
              child: StyledColumn(
                style: Style(
                  $flex.crossAxisAlignment.start(),
                  $flex.gap(8),
                  $with.defaultTextStyle(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                children: [
                  StyledRow(
                    style: Style(
                      $flex.gap(12),
                      $with.defaultTextStyle(
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    children: const [
                      Icon(Icons.info_outline),
                      Expanded(child: Text("MoonAlert")),
                      Icon(Icons.close),
                    ],
                  ),
                  const Text("This is a MoonAlert widget."),
                ],
              ),
            ),
            if (index == 0)
              MoonBaseInteractiveWidget(
                style: Style(
                  $box.color(Colors.orange),
                  $box.borderRadius(8),
                  $box.margin(8),
                  $box.padding(8.0, 16.0),
                ),
                onPress: () => setState(() => show = !show),
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
