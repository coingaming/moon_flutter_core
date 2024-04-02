import 'package:flutter/material.dart';
import 'package:moon_core/moon_core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Hello World!'),
              MoonCoreButton(),
            ],
          ),
        ),
      ),
    );
  }
}
