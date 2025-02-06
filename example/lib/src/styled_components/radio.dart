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
  _Choices? _valueCustom = _Choices.first;

  Duration get _animationDuration => const Duration(milliseconds: 150);

  Style get _dotStyle => Style(
        $box.chain
          ..width(0)
          ..color(Colors.deepPurple)
          ..shape.circle(),
        SelectedState.selected(
          $box.width(7.5),
        ),
      ).animate(duration: _animationDuration);

  Style get _baseStyle => Style(
        $box.chain
          ..width(16)
          ..height(16)
          ..border.color.black54()
          ..alignment.center()
          ..shape.circle(),
        SelectedState.selected(
          $box.border.color.deepPurple.shade600(),
        ),
      ).animate(duration: _animationDuration);

  Style get _focusStateStyle => Style(
        $on.focus(
          $box.chain
            ..border.color.black12()
            ..border.width(4)
            ..shape.circle(),
        ),
      ).animate(duration: _animationDuration);

  SelectedState _getVariant(_Choices? value) =>
      value == _valueCustom ? SelectedState.selected : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _Choices.values.length,
        (int index) {
          final _Choices value = _Choices.values[index];

          return Column(
            children: [
              MoonBaseSingleSelectWidget(
                value: value,
                groupValue: _valueCustom,
                toggleable: true,
                style: _focusStateStyle,
                onChanged: (_Choices? value) =>
                    setState(() => _valueCustom = value),
                child: Box(
                  style: _baseStyle.applyVariant(_getVariant(value)),
                  child: Box(
                    style: _dotStyle.applyVariant(_getVariant(value)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
