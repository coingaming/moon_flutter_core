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
        backgroundColor: Colors.grey.shade200,
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextDivider(text: 'MoonRawAlert'),
                StyledAlert(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// TextDivider(text: 'MoonRawButton'),
// StyledButton(),
// TextDivider(text: 'MoonRawTag'),
// StyledTag(),
// TextDivider(text: 'MoonRawAvatar'),
// StyledAvatar(),
