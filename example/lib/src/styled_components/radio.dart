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

  Style get _outerCircleStyle => Style(
        $box.chain
          ..border.color.black54()
          ..width(16)
          ..shape.circle()
          ..alignment.center(),
        SelectedState.selected(
          $box.border.color.deepPurple.shade600(),
        ),
      ).animate(duration: _animationDuration);

  Style get _innerCircleStyle => Style(
        $box.chain
          ..color(Colors.deepPurple)
          ..shape.circle()
          ..width(0),
        SelectedState.selected(
          $box.width(9),
        ),
      ).animate(duration: _animationDuration);

  Style get _focusStateStyle => Style(
        $box.height(32),
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
                toggleable: true,
                style: _focusStateStyle,
                value: _Choices.values[index],
                groupValue: _valueCustom,
                onChanged: (_Choices? value) =>
                    setState(() => _valueCustom = value),
                child: Box(
                  style: _outerCircleStyle.applyVariant(_getVariant(value)),
                  child: Box(
                    style: _innerCircleStyle.applyVariant(_getVariant(value)),
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
