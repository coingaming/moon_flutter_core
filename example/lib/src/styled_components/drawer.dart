import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledDrawer extends StatelessWidget {
  const StyledDrawer({super.key});

  Style get _drawerStyle => Style(
        $box.chain
          ..color(Colors.lime)
          ..borderRadiusDirectional.topEnd(16.0)
          ..borderRadiusDirectional.bottomEnd(16.0)
          ..width(300),
      );

  @override
  Widget build(BuildContext context) {
    return Box(
      style: _drawerStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("MoonRawDrawer"),
          const SizedBox(height: 32),
          Builder(
            builder: (BuildContext context) {
              return MoonBaseInteractiveWidget(
                style: getButtonStyle(),
                onTap: () => Navigator.of(context).pop(),
                child: const StyledText("Close"),
              );
            },
          ),
        ],
      ),
    );
  }
}
