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

  BoxStyler get _inputStyle => BoxStyler()
      .width(300)
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 6),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .border(
        BorderMix.all(
          BorderSideMix.value(const BorderSide(color: Colors.grey, width: 1)),
        ),
      )
      .color(Colors.white)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
      .wrapIconTheme(const IconThemeData(color: Colors.black))
      .onHovered(BoxStyler().color(Colors.grey.shade200))
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),
      )
      .onError(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(const BorderSide(color: Colors.red, width: 2)),
          ),
        ),
      )
      .onDisabled(BoxStyler().wrapOpacity(0.4))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 180)),
      );

  BoxStyler get _helperErrorStyle => BoxStyler()
      .width(300)
      .alignment(Alignment.center)
      .padding(EdgeInsetsGeometryMix.symmetric(vertical: 8))
      .wrapDefaultTextStyle(
        TextStyleMix(color: Colors.grey.shade600, fontSize: 12),
      )
      .wrapIconTheme(
        IconThemeData(color: Colors.grey.shade600, size: 16),
      )
      .onError(
        BoxStyler()
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.red))
            .wrapIconTheme(const IconThemeData(color: Colors.red, size: 16)),
      )
      .onDisabled(BoxStyler().wrapOpacity(0.5))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  BoxStyler get _trailingStyle => BoxStyler()
      .alignment(Alignment.centerRight)
      .padding(EdgeInsetsGeometryMix.symmetric(horizontal: 4, vertical: 2))
      .wrapDefaultTextStyle(
        TextStyleMix(color: Colors.black, decoration: TextDecoration.underline),
      )
      .onHovered(BoxStyler().color(Colors.grey.shade200))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 120)),
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
    final BoxStyler textAreaStyle = _inputStyle.merge(
      BoxStyler()
          .height(200)
          .padding(EdgeInsetsGeometryMix.all(16))
          .alignment(Alignment.topCenter),
    );

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
                      child: StyledIcon(
                        icon: Icons.close,
                        style: IconStyler().size(20),
                      ),
                    ),
                    label: const StyledText("Label"),
                    hint: const StyledText("Enter text (over 3 characters)"),
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
                    leading: const StyledIcon(icon: Icons.pin_outlined),
                    trailing: MoonBaseInteractiveWidget(
                      style: _trailingStyle,
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      child: StyledText(_hidePassword ? "Show" : "Hide"),
                    ),
                    label: const StyledText("Label"),
                    hint: const StyledText("Enter password (abc)"),
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
                    inputStyle: textAreaStyle,
                    label: const StyledText("Label"),
                    hint: const StyledText("Hint..."),
                  ),
                  validator: (String? value) =>
                      value != null && value.trim().isEmpty
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
