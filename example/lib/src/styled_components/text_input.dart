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

  BoxStyler get _inputStyle => BoxStyler()
      .width(300)
      .minHeight(30)
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 4),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .border(
        BorderMix.all(
          BorderSideMix.value(const BorderSide(color: Colors.grey, width: 1)),
        ),
      )
      .color(Colors.white)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.grey.shade600))
      .wrapIconTheme(
        IconThemeData(color: Colors.black.withValues(alpha: 0.8), size: 18),
      )
      .onHovered(
        BoxStyler()
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.purple))
            .wrapIconTheme(const IconThemeData(color: Colors.purple, size: 18))
            .color(Colors.grey.shade200),
      )
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
            BorderSideMix.value(
              const BorderSide(color: Colors.red, width: 2),
            ),
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
      .onDisabled(BoxStyler().wrapOpacity(0.5))
      .onError(
        BoxStyler().wrapDefaultTextStyle(TextStyleMix(color: Colors.red)),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  IconStyler get _iconStyle => IconStyler().size(20);

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
          child: StyledIcon(icon: Icons.close, style: _iconStyle),
        ),
        trailing: MoonBaseInteractiveWidget(
          style: getIconButtonStyle(),
          onTap: () => _searchController.clear(),
          child: StyledIcon(icon: Icons.close, style: _iconStyle),
        ),
        label: const StyledText("Label"),
        hint: const StyledText("Hint"),
        helper: const StyledText("Text input field with floating label."),
      ),
    );
  }
}
