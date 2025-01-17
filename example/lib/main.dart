import 'package:example/src/common_styles.dart';
import 'package:example/src/styled_components/accordion.dart';
import 'package:example/src/styled_components/alert.dart';
import 'package:example/src/styled_components/auth_code.dart';
import 'package:example/src/styled_components/avatar.dart';
import 'package:example/src/styled_components/breadcrumb.dart';
import 'package:example/src/styled_components/button.dart';
import 'package:example/src/styled_components/carousel.dart';
import 'package:example/src/styled_components/checkbox.dart';
import 'package:example/src/styled_components/chip.dart';
import 'package:example/src/styled_components/circular_loader.dart';
import 'package:example/src/styled_components/circular_progress.dart';
import 'package:example/src/styled_components/combobox.dart';
import 'package:example/src/styled_components/dot_indicator.dart';
import 'package:example/src/styled_components/drawer.dart';
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

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget _drawerButton() {
    return Builder(
      builder: (BuildContext context) {
        return MoonBaseInteractiveWidget(
          style: getButtonStyle(),
          child: const StyledText("Show drawer"),
          onTap: () => Scaffold.of(context).openDrawer(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        drawerScrimColor: Colors.black54,
        drawer: const StyledDrawer(),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextDivider(text: 'MoonRawAccordion'),
                const StyledAccordion(),
                const TextDivider(text: 'MoonRawAlert'),
                const StyledAlert(),
                const TextDivider(text: 'MoonRawMenuItem'),
                const StyledMenuItem(),
                const TextDivider(text: 'MoonRawBreadcrumb'),
                const StyledBreadcrumb(),
                const TextDivider(text: 'MoonRawAuthCode'),
                const StyledAuthCode(),
                const TextDivider(text: 'MoonRawAvatar'),
                const StyledAvatar(),
                const TextDivider(text: 'MoonRawButton'),
                const StyledButton(),
                const TextDivider(text: 'MoonRawChip'),
                const StyledChip(),
                const TextDivider(text: 'MoonRawTag'),
                const StyledTag(),
                const TextDivider(text: 'MoonRawSegmentedTabControl'),
                const StyledSegmentedTabControl(),
                const TextDivider(text: 'MoonRawCarousel'),
                const StyledCarousel(),
                const TextDivider(text: 'MoonRawDotIndicator'),
                const StyledDotIndicator(),
                const TextDivider(text: 'MoonRawCheckbox'),
                const StyledCheckbox(),
                const TextDivider(text: 'MoonRawRadio'),
                const StyledRadio(),
                const TextDivider(text: 'MoonRawSwitch'),
                const StyledSwitch(),
                const TextDivider(text: 'MoonRawDrawer'),
                _drawerButton(),
                const TextDivider(text: 'MoonRawModal'),
                const StyledModal(),
                const TextDivider(text: 'MoonRawModalBottomSheet'),
                const StyledBottomSheet(),
                const TextDivider(text: 'MoonRawPopover'),
                const StyledPopover(),
                const TextDivider(text: 'MoonRawToast'),
                const StyledToast(),
                const TextDivider(text: 'MoonRawTooltip'),
                const StyledTooltip(),
                const TextDivider(text: 'MoonRawDropdown'),
                const StyledDropdown(),
                const TextDivider(text: 'MoonRawCombobox'),
                const StyledCombobox(),
                const TextDivider(text: 'MoonRawTextInput'),
                const StyledTextInput(),
                const TextDivider(text: 'MoonRawFormTextInput'),
                const StyledFormTextInput(),
                const TextDivider(text: 'MoonRawCircularLoader'),
                const StyledCircularLoader(),
                const TextDivider(text: 'MoonRawCircularProgress'),
                const StyledCircularProgress(),
                const TextDivider(text: 'MoonRawLinearLoader'),
                const StyledLinearLoader(),
                const TextDivider(text: 'MoonRawLinearProgress'),
                const StyledLinearProgress(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
