import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/moon_squircle_border.dart';
import 'package:moon_core/src/widgets/text_input/text_input.dart';
import 'package:moon_core/src/widgets/text_input/text_input_configuration.dart';

class StyledTextInput extends StatefulWidget {
  const StyledTextInput({super.key});

  @override
  State<StyledTextInput> createState() => _StyledTextInputState();
}

class _StyledTextInputState extends State<StyledTextInput> {
  late final TextEditingController _searchController;

  ShapeDecoration _getBorder(Color color, {double width = 1.5}) =>
      ShapeDecoration(
        shape: MoonSquircleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color, width: width),
        ),
      );

  Style _getInputStyle() => Style(
        $box.chain
          ..width(300)
          ..padding(4, 12)
          ..shapeDecoration.as(_getBorder(Colors.grey, width: 1)),
        $flex.gap(8),
        $on.hover($box.shapeDecoration.as(_getBorder(Colors.grey))),
        $on.focus($box.shapeDecoration.as(_getBorder(Colors.purple))),
        $on.disabled($with.opacity(0.5)),
      ).animate(duration: const Duration(milliseconds: 300));

  Style _getHelperStyle() => Style(
        $box.chain
          ..padding.vertical(8)
          ..width(300),
        $text.chain
          ..textAlign.center()
          ..style.fontSize(10),
        $on.disabled($with.opacity(0.5)),
      ).animate(duration: const Duration(milliseconds: 300));

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
        helperStyle: _getHelperStyle(),
        inputStyle: _getInputStyle(),
        controller: _searchController,
        leading: const Icon(Icons.search, size: 20),
        trailing: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _searchController.clear(),
            child: const Icon(Icons.close, size: 20),
          ),
        ),
        helper: const StyledText("Text input field with floating label."),
        hint: const Text(
          "Search for something...",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
