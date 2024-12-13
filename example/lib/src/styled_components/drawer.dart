import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledDrawer extends StatelessWidget {
  const StyledDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Box(
      style: Style(
        $box.color(Colors.lime),
        $box.borderRadiusDirectional.topEnd(16.0),
        $box.borderRadiusDirectional.bottomEnd(16.0),
        $box.width(MediaQuery.of(context).size.width * 0.75),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("MoonRawDrawer"),
          const SizedBox(height: 32),
          Builder(
            builder: (BuildContext context) {
              return MoonBaseInteractiveWidget(
                style: Style(
                  $box.padding(8.0),
                  $box.borderRadius(8.0),
                  $box.color(Colors.deepPurpleAccent),
                  $text.style.color(Colors.white),
                ),
                child: const StyledText("Close"),
                onTap: () => Navigator.of(context).pop(),
              );
            },
          ),
        ],
      ),
    );
  }
}
