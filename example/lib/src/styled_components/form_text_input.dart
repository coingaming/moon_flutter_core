import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledFormTextInput extends StatefulWidget {
  const StyledFormTextInput({super.key});

  @override
  State<StyledFormTextInput> createState() => _StyledFormTextInputState();
}

class _StyledFormTextInputState extends State<StyledFormTextInput> {
  late final TextEditingController _textController;
  late final TextEditingController _passwordController;

  bool _hidePassword = true;

  Style get _inputStyle => Style(
        $box.chain
          ..width(300)
          ..padding(4, 12),
        $flex.gap(8),
        $text.color(Colors.black),
        $with.defaultTextStyle(style: TextStyleMix(color: Colors.grey)),
        $with.iconTheme(color: Colors.black),
        $with.animatedShapeDecoration(
          bgColor: Colors.white,
          border: _getBorder(Colors.grey, width: 1),
          duration: const Duration(milliseconds: 400),
        ),
        $on.hover(
          $with.animatedShapeDecoration(hoverColor: Colors.black12),
        ),
        $on.focus(
          $with.animatedShapeDecoration(
            hoverColor: Colors.white,
            border: _getBorder(Colors.purple),
          ),
        ),
        $on.error(
          $with.animatedShapeDecoration(border: _getBorder(Colors.red)),
        ),
        $on.disabled($with.opacity(0.5)),
      );

  Style get _helperErrorStyle => Style(
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

  Style get _trailingStyle => Style(
        $text.chain
          ..style.decoration.underline()
          ..color(Colors.black),
        $with.cursor.click(),
        $with.align(alignment: Alignment.centerRight),
      );

  MoonBorder _getBorder(Color borderColor, {double? width}) => MoonBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: width ?? 2),
      );

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
                    inputStyle: _inputStyle,
                    helperErrorStyle: _helperErrorStyle,
                    controller: _textController,
                    trailing: MoonBaseInteractiveWidget(
                      style: getIconButtonStyle(),
                      onTap: () => _textController.clear(),
                      child: const Icon(Icons.close, size: 20),
                    ),
                    label: const Text("Label"),
                    hint: const Text("Enter text (over 3 characters)"),
                    helper: const StyledText("Expanding text input field."),
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
                    inputStyle: _inputStyle,
                    helperErrorStyle: _helperErrorStyle,
                    controller: _passwordController,
                    leading: const Icon(Icons.pin_outlined, size: 20),
                    trailing: MoonBaseInteractiveWidget(
                      style: _trailingStyle,
                      onTap: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      child: StyledText(_hidePassword ? "Show" : "Hide"),
                    ),
                    label: const Text("Label"),
                    hint: const Text("Enter password (abc)"),
                  ),
                  validator: (String? value) =>
                      value != "abc" ? "Wrong password." : null,
                ),
                const SizedBox(height: 16),
                MoonRawFormTextInput(
                  textInputConfiguration: MoonTextInputConfiguration(
                    textAlignVertical: TextAlignVertical.top,
                    labelTextAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(fontSize: 16),
                    helperErrorStyle: _helperErrorStyle,
                    inputStyle: _inputStyle.add(
                      $box.chain
                        ..height(200)
                        ..padding(16),
                    ),
                    label: const Text("Label"),
                    hint: const Text("Hint..."),
                  ),
                  validator: (String? value) =>
                      value?.length != null && value!.trim().isEmpty
                          ? "The text area can't be empty."
                          : null,
                ),
                const SizedBox(height: 24),
                MoonBaseInteractiveWidget(
                  style: getButtonStyle(),
                  onTap: () => Form.of(context).validate(),
                  child: const StyledText("Submit"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
