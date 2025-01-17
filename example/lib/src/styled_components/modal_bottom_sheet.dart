import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledBottomSheet extends StatelessWidget {
  const StyledBottomSheet({super.key});

  Style get _bottomSheetStyle => Style(
        $box.chain
          ..borderRadius.top(24)
          ..color(Colors.purple.shade50),
      );

  Style get _menuItemStyle => Style(
        $box.padding(16.0),
        $flex.mainAxisAlignment.spaceBetween(),
        ($on.focus | $on.hover)(
          $box.color(Colors.purple.shade100),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Future<dynamic> bottomSheetBuilder(BuildContext context) {
      return showMoonRawModalBottomSheet(
        context: context,
        bottomSheetStyle: _bottomSheetStyle,
        builder: (BuildContext context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: const ShapeDecoration(
                color: Colors.purple,
                shape: StadiumBorder(),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 48),
                const Expanded(
                  child: Center(
                    child: Text("Pick your choice!"),
                  ),
                ),
                MoonBaseInteractiveWidget(
                  style: getIconButtonStyle(),
                  child: const StyledIcon(Icons.close),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(
              height: 0,
              color: Colors.purple,
            ),
            Flexible(
              child: ListView.builder(
                primary: true,
                itemCount: 20,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext _, int index) {
                  return MoonBaseInteractiveWidget(
                    style: _menuItemStyle,
                    onTap: () {},
                    child: StyledRow(
                      inherit: true,
                      children: [
                        const Text("Item nr:"),
                        Text("$index"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Builder(
      builder: (BuildContext context) {
        return MoonBaseInteractiveWidget(
          style: getButtonStyle(),
          child: const StyledText("Show bottom sheet"),
          onTap: () => bottomSheetBuilder(context),
        );
      },
    );
  }
}
