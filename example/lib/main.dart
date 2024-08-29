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
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                // Demo button
                //
                DemoButton(
                  leading: const Icon(Icons.widgets_outlined),
                  title: const SizedBox(
                    width: 100,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("MoonButton"),
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const SizedBox(
                      height: 48,
                      width: 48,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Icon(
                            Icons.person,
                            size: 24,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text("JD"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //
                const TextDivider(text: 'MoonRawAccordion'),
                const StyledAccordion(),
                const TextDivider(text: 'MoonRawLinearProgress'),
                const StyledLinearProgress(),
                const TextDivider(text: 'MoonRawCircularProgress'),
                const StyledCircularProgress(),
                const TextDivider(text: 'MoonRawLinearLoader'),
                const StyledLinearLoader(),
                const TextDivider(text: 'MoonRawCircularLoader'),
                const StyledCircularLoader(),
                const TextDivider(text: 'MoonRawAvatar'),
                const StyledAvatar(),
                const TextDivider(text: 'MoonRawDropdown'),
                const StyledDropdown(),
                const TextDivider(text: 'MoonRawTooltip'),
                const StyledTooltip(),
                const TextDivider(text: 'MoonRawBottomSheet'),
                const StyledBottomSheet(),
                const TextDivider(text: 'MoonRawPopover'),
                const StyledPopover(),
                const TextDivider(text: 'MoonRawModal'),
                const StyledModal(),
                const TextDivider(text: 'MoonRawToast'),
                const StyledToast(),
                const TextDivider(text: 'MoonRawSegmentedTabControl'),
                const StyledSegmentedTabControl(),
                const TextDivider(text: 'MoonRawDotIndicator'),
                const StyledDotIndicator(),
                const TextDivider(text: 'MoonRawBreadcrumb'),
                const StyledBreadcrumb(),
                const TextDivider(text: 'MoonRawChip'),
                const StyledChip(),
                const TextDivider(text: 'MoonRawRadio'),
                const StyledRadio(),
                const TextDivider(text: 'MoonRawCheckbox'),
                const StyledCheckbox(),
                const TextDivider(text: 'MoonRawMenuItem'),
                const StyledMenuItem(),
                const TextDivider(text: 'MoonRawButton'),
                const StyledButton(),
                const TextDivider(text: 'MoonRawAlert'),
                const StyledAlert(),
                const TextDivider(text: 'MoonRawTag'),
                const StyledTag(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
