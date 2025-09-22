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

  Style get _inputStyle {
    return Style(
      $box.chain
        ..width(300)
        ..padding(4, 12)
        ..minHeight(30),
      $flex.gap(8),
      $with.defaultTextStyle(
        style: TextStyleMix(color: Colors.grey),
        duration: const Duration(milliseconds: 400),
      ),
      $with.iconTheme(
        color: Colors.black,
        duration: const Duration(milliseconds: 400),
      ),
      $with.animatedShapeDecoration(
        bgColor: Colors.white,
        border: _getBorder(Colors.grey, width: 1),
        duration: const Duration(milliseconds: 400),
      ),
      $on.hover(
        $with.defaultTextStyle(style: TextStyleMix(color: Colors.purple)),
        $with.iconTheme(color: Colors.purple),
        $with.animatedShapeDecoration(
          hoverColor: Colors.black12,
          border: _getBorder(Colors.black, width: 1),
        ),
      ),
      $on.focus(
        $with.animatedShapeDecoration(
          hoverColor: Colors.white,
          border: _getBorder(Colors.purple),
        ),
      ),
      $on.error($with.animatedShapeDecoration(border: _getBorder(Colors.red))),
      $on.disabled(
        $with.animatedOpacity(
          opacity: 0.5,
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }

  Style get _helperErrorStyle => Style(
    $box.chain
      ..padding.vertical(8)
      ..width(300),
    $text.chain
      ..textAlign.center()
      ..style.fontSize(10),
    $on.disabled($with.opacity(0.5)),
  ).animate(duration: const Duration(milliseconds: 300));

  MoonBorder _getBorder(
    Color borderColor, {
    BorderRadius? radius,
    double? width,
  }) => MoonBorder(
    borderRadius: radius ?? BorderRadius.circular(8),
    side: BorderSide(color: borderColor, width: width ?? 2),
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
        label: const Text("Label"),
        hint: const Text("Hint"),
        helper: const StyledText("Text input field with floating label."),
      ),
    );
  }
}
