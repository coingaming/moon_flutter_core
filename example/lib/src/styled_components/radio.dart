import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

enum _Choices { first, second }

class StyledRadio extends StatefulWidget {
  const StyledRadio({super.key});

  @override
  State<StyledRadio> createState() => _StyledRadioState();
}

class _StyledRadioState extends State<StyledRadio> {
  static const double _radioSize = 16;
  static const Duration _animationDuration = Duration(milliseconds: 150);

  _Choices? _valueCustom = _Choices.first;

  BoxStyler get _radioStyle => BoxStyler()
      .constraints(BoxConstraintsMix.square(_radioSize))
      .alignment(Alignment.center)
      .shapeCircle()
      .border(
        BorderMix.all(
          BorderSideMix.value(
            const BorderSide(color: Colors.black54, width: 1.5),
          ),
        ),
      )
      .color(Colors.transparent)
      .onSelected(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              const BorderSide(color: Colors.deepPurple, width: 2),
            ),
          ),
        ),
      )
      .animate(AnimationConfig.ease(_animationDuration));

  BoxStyler get _focusStyle => BoxStyler()
      .onFocused(
        BoxStyler().border(
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
      .animate(AnimationConfig.ease(_animationDuration));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _Choices.values.map((value) {
        final bool isSelected = value == _valueCustom;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: MoonBaseSingleSelectWidget<_Choices>(
            value: value,
            groupValue: _valueCustom,
            toggleable: true,
            style: _focusStyle,
            onChanged: (_Choices? newValue) =>
                setState(() => _valueCustom = newValue),
            child: Box(
              style: _radioStyle,
              child: AnimatedContainer(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                width: isSelected ? 8 : 0,
                height: isSelected ? 8 : 0,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
