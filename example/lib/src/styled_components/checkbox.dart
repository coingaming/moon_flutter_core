import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledCheckbox extends StatefulWidget {
  const StyledCheckbox({super.key});

  @override
  State<StyledCheckbox> createState() => _StyledCheckboxState();
}

class _StyledCheckboxState extends State<StyledCheckbox> {
  bool? _checkboxValue = false;

  static const double _checkboxSize = 20;

  IconData? get _icon => switch (_checkboxValue) {
        null => Icons.remove,
        true => Icons.check,
        false => null,
      };

  BoxStyler get _baseCheckboxStyle => BoxStyler()
      .constraints(BoxConstraintsMix.square(_checkboxSize))
      .alignment(Alignment.center)
      .borderRadius(BorderRadiusGeometryMix.circular(4))
      .border(
        BorderMix.all(
          BorderSideMix.value(
            const BorderSide(
              color: Colors.black54,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      )
      .color(Colors.transparent)
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 150)),
      );

  BoxStyler get _selectedCheckboxStyle => BoxStyler()
      .color(Colors.deepPurple.shade600)
      .border(
        BorderMix.all(
          BorderSideMix.value(
            BorderSide(
              color: Colors.deepPurple.shade600,
              width: 0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
      );

  BoxStyler get _focusStateStyle => BoxStyler()
      .onFocused(
        BoxStyler()
            .borderRadius(BorderRadiusGeometryMix.circular(4))
            .border(
              BorderMix.all(
                BorderSideMix.value(
                  const BorderSide(
                    color: Colors.black12,
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
              ),
            ),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 300)),
      );

  @override
  Widget build(BuildContext context) {
    final bool isSelected = _checkboxValue == true;
    final bool isIndeterminate = _checkboxValue == null;

    final BoxStyler checkboxStyle = _baseCheckboxStyle.merge(
      (isSelected || isIndeterminate) ? _selectedCheckboxStyle : BoxStyler(),
    );

    return MoonBaseMultiSelectWidget(
      tristate: true,
      style: _focusStateStyle,
      value: _checkboxValue,
      onChanged: (bool? newValue) => setState(() => _checkboxValue = newValue),
      child: Box(
        style: checkboxStyle,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _icon == null
              ? const SizedBox.shrink()
              : StyledIcon(
                  key: ValueKey(_icon),
                  icon: _icon,
                  style: IconStyler().color(Colors.white).size(16),
                ),
        ),
      ),
    );
  }
}
