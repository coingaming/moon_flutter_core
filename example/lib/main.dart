import 'package:example/text_divider.dart';
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextDivider(text: 'MoonRawToast'),
                StyledToast(),
                TextDivider(text: 'MoonRawSegmentedTabControl'),
                StyledSegmentedTabControl(),
                TextDivider(text: 'MoonRawDotIndicator'),
                StyledDotIndicator(),
                TextDivider(text: 'MoonRawBreadcrumb'),
                StyledBreadcrumb(),
                TextDivider(text: 'MoonRawChip'),
                StyledChip(),
                TextDivider(text: 'MoonRawRadio'),
                StyledRadio(),
                TextDivider(text: 'MoonRawCheckbox'),
                StyledCheckbox(),
                TextDivider(text: 'MoonRawMenuItem'),
                StyledMenuItem(),
                TextDivider(text: 'MoonRawButton'),
                StyledButton(),
                TextDivider(text: 'MoonRawAlert'),
                StyledAlert(),
                TextDivider(text: 'MoonRawTag'),
                StyledTag(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
