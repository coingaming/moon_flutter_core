import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

class StyledBottomSheet extends StatelessWidget {
  const StyledBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Future<dynamic> bottomSheetBuilder(BuildContext context) {
      return showMoonModalRawBottomSheet(
        context: context,
        transitionDuration: const Duration(milliseconds: 2350),
        bottomSheetStyle: Style(
          $box.height(MediaQuery.of(context).size.height * 0.8),
          $box.borderRadius.top(32),
          $box.color(Colors.white),
        ),
        builder: (BuildContext context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: const ShapeDecoration(
                color: Colors.grey,
                shape: StadiumBorder(),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 48),
                const Expanded(
                  child: Center(
                    child: Text('Pick your choice!'),
                  ),
                ),
                MoonBaseInteractiveWidget(
                  style: Style(
                    $box.width(48),
                    $box.height(48),
                  ),
                  child: const Icon(Icons.close),
                  onPress: () => Navigator.of(context).pop(),
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
                itemBuilder: (BuildContext _, int index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item nr:"),
                      Text("$index"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Builder(
      builder: (BuildContext context) {
        return MoonBaseInteractiveWidget(
          style: Style(
            $box.color(Colors.deepPurpleAccent),
            $box.padding(8, 16),
            $box.borderRadius(8),
            $text.style.color(Colors.white),
          ),
          child: const StyledText("Show bottom sheet"),
          onPress: () => bottomSheetBuilder(context),
        );
      },
    );
  }
}
