import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledDrawer extends StatelessWidget {
  const StyledDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverflowBox(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
        child: Scaffold(
          drawerScrimColor: Colors.black38,
          drawer: MoonRawDrawer(
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
                    return MoonRawButton(
                      style: Style(
                        $box.padding(8.0),
                        $box.borderRadius(8.0),
                        $box.color(Colors.blue),
                      ),
                      child: const Text("Close"),
                      onPress: () => Navigator.of(context).pop(),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Builder(
              builder: (BuildContext context) {
                return MoonRawButton(
                  style: Style(
                    $box.padding(8.0),
                    $box.borderRadius(8.0),
                    $box.color(Colors.blue),
                  ),
                  child: const Text("Tap me"),
                  onPress: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
