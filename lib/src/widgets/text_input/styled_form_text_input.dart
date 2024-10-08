import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/moon_squircle_border.dart';
import 'package:moon_core/src/widgets/text_input/form_text_input.dart';
import 'package:moon_core/src/widgets/text_input/text_input_configuration.dart';

class StyledFormTextInput extends StatefulWidget {
  const StyledFormTextInput({super.key});

  @override
  State<StyledFormTextInput> createState() => _StyledFormTextInputState();
}

class _StyledFormTextInputState extends State<StyledFormTextInput> {
  late final TextEditingController _textController;
  late final TextEditingController _passwordController;

  bool _hidePassword = true;

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
        $on.error($box.shapeDecoration.as(_getBorder(Colors.red))),
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
        $on.error(
          $text.style(color: Colors.red),
          $icon.color(Colors.red),
        ),
      ).animate(duration: const Duration(milliseconds: 300));

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonRawFormTextInput(
                  textInputConfiguration: MoonTextInputConfiguration(
                    expands: true,
                    maxLines: null,
                    inputStyle: _getInputStyle(),
                    helperStyle: _getHelperStyle(),
                    controller: _textController,
                    trailing: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _textController.clear(),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                    helper: const StyledText("Expanding text input field."),
                    hint: const Text(
                      "Enter text (over 3 characters)",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  validator: (String? value) =>
                      value != null && value.length < 3
                          ? "The text should be longer than 3 characters."
                          : null,
                ),
                const SizedBox(height: 16),
                MoonRawFormTextInput(
                  textInputConfiguration: MoonTextInputConfiguration(
                    obscureText: _hidePassword,
                    keyboardType: TextInputType.visiblePassword,
                    inputStyle: _getInputStyle(),
                    helperStyle: _getHelperStyle(),
                    controller: _passwordController,
                    leading: const Icon(Icons.pin_outlined, size: 20),
                    trailing: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _hidePassword = !_hidePassword),
                        child: Box(
                          style: Style(
                            $text.style.decoration.underline(),
                            $with.cursor.click(),
                            $with.intrinsicWidth(),
                            $with.align(alignment: Alignment.centerRight),
                          ),
                          child: StyledText(_hidePassword ? "Show" : "Hide"),
                        ),
                      ),
                    ),
                    hint: const Text(
                      "Enter password (abc)",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  validator: (String? value) =>
                      value != "abc" ? "Wrong password." : null,
                ),
                const SizedBox(height: 16),
                MoonRawFormTextInput(
                  textInputConfiguration: MoonTextInputConfiguration(
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(fontSize: 16),
                    helperStyle: _getHelperStyle(),
                    inputStyle: _getInputStyle().add(
                      $box.chain
                        ..height(200)
                        ..padding(16),
                    ),
                    hint: const Text(
                      "Enter your text here...",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  validator: (String? value) =>
                      value?.length != null && value!.trim().isEmpty
                          ? "The text area can't be empty."
                          : null,
                ),
                const SizedBox(height: 24),
                PressableBox(
                  style: Style(
                    $box.chain
                      ..padding(8)
                      ..borderRadius(8)
                      ..color(Colors.purpleAccent),
                  ),
                  onPress: () => Form.of(context).validate(),
                  child: const Text("Submit"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
