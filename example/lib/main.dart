import 'package:flutter/material.dart';
import 'package:moon_core/moon_core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Column(
            children: [
              MoonRawButton(
                height: 40,
                style: Style($box.borderRadius.all(16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
