import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledTextInput extends StatefulWidget {
  const StyledTextInput({super.key});

  @override
  State<StyledTextInput> createState() => _StyledTextInputState();
}

class _StyledTextInputState extends State<StyledTextInput> {
  late final TextEditingController _searchController;

  Style get _inputStyle => Style(
        $box.chain
          ..width(300)
          ..padding(4, 12)
          ..shapeDecoration.as(_getBorder(Colors.grey, width: 1)),
        $flex.gap(8),
        $on.hover($box.shapeDecoration.as(_getBorder(Colors.grey))),
        $on.focus($box.shapeDecoration.as(_getBorder(Colors.purple))),
        $on.disabled($with.opacity(0.5)),
      ).animate(duration: const Duration(milliseconds: 300));

  Style get _helperErrorStyle => Style(
        $box.chain
          ..padding.vertical(8)
          ..width(300),
        $text.chain
          ..textAlign.center()
          ..style.fontSize(10),
        $on.disabled($with.opacity(0.5)),
      ).animate(duration: const Duration(milliseconds: 300));

  ShapeDecoration _getBorder(Color color, {double width = 1.5}) =>
      ShapeDecorationWithPremultipliedAlpha(
        shape: MoonBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color, width: width),
        ),
      );

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MoonRawTextInput(
      textInputConfiguration: MoonTextInputConfiguration(
        hasFloatingLabel: true,
        textAlignVertical: TextAlignVertical.bottom,
        helperErrorStyle: _helperErrorStyle,
        inputStyle: _inputStyle,
        controller: _searchController,
        leading: MoonBaseInteractiveWidget(
          style: getIconButtonStyle(),
          onTap: () => _searchController.clear(),
          child: const Icon(Icons.close, size: 20),
        ),
        trailing: MoonBaseInteractiveWidget(
          style: getIconButtonStyle(),
          onTap: () => _searchController.clear(),
          child: const Icon(Icons.close, size: 20),
        ),
        helper: const StyledText("Text input field with floating label."),
        label: const Text(
          "Label",
          style: TextStyle(color: Colors.grey),
        ),
        hint: const Text(
          "Hint",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
