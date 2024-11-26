import 'package:example/src/styled_components/accordion.dart';
import 'package:example/src/styled_components/alert.dart';
import 'package:example/src/styled_components/auth_code.dart';
import 'package:example/src/styled_components/avatar.dart';
import 'package:example/src/styled_components/breadcrumb.dart';
import 'package:example/src/styled_components/button.dart';
import 'package:example/src/styled_components/button_demo.dart';
import 'package:example/src/styled_components/carousel.dart';
import 'package:example/src/styled_components/checkbox.dart';
import 'package:example/src/styled_components/chip.dart';
import 'package:example/src/styled_components/circular_loader.dart';
import 'package:example/src/styled_components/circular_progress.dart';
import 'package:example/src/styled_components/dot_indicator.dart';
import 'package:example/src/styled_components/dropdown.dart';
import 'package:example/src/styled_components/form_text_input.dart';
import 'package:example/src/styled_components/linear_loader.dart';
import 'package:example/src/styled_components/linear_progress.dart';
import 'package:example/src/styled_components/menu_item.dart';
import 'package:example/src/styled_components/modal.dart';
import 'package:example/src/styled_components/modal_bottom_sheet.dart';
import 'package:example/src/styled_components/popover.dart';
import 'package:example/src/styled_components/radio.dart';
import 'package:example/src/styled_components/segmented_tab_control.dart';
import 'package:example/src/styled_components/switch.dart';
import 'package:example/src/styled_components/tag.dart';
import 'package:example/src/styled_components/text_input.dart';
import 'package:example/src/styled_components/toast.dart';
import 'package:example/src/styled_components/tooltip.dart';
import 'package:example/src/text_divider.dart';

import 'package:flutter/material.dart';

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
                const TextDivider(text: 'MoonRawAuthCode'),
                const StyledAuthCode(),
                const TextDivider(text: 'MoonRawTextInput'),
                const StyledTextInput(),
                const TextDivider(text: 'MoonRawFormTextInput'),
                const StyledFormTextInput(),
                const TextDivider(text: 'MoonRawCarousel'),
                const StyledCarousel(),
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
                const TextDivider(text: 'MoonRawSwitch'),
                const StyledSwitch(),
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
