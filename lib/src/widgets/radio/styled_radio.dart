import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/widgets/common/base_single_select_widget.dart';
import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';

enum _Choices { first, second }

class StyledRadio extends StatefulWidget {
  const StyledRadio({super.key});

  @override
  State<StyledRadio> createState() => _StyledRadioState();
}

class _StyledRadioState extends State<StyledRadio> {
  _Choices? _valueCustom = _Choices.first;

  Duration get _animationDuration => const Duration(milliseconds: 150);

  SelectedState _getVariant(_Choices? value) {
    return value == _valueCustom
        ? SelectedState.selected
        : SelectedState.unselected;
  }

  @override
  Widget build(BuildContext context) {
    final Style outerCircleStyle = Style(
      $box.border.color.black54(),
      $box.width(16),
      $box.shape.circle(),
      SelectedState.selected(
        $box.border.color.deepPurple.shade600(),
      ),
    );

    final Style iconStyle = Style(
      $icon.color(Colors.deepPurple),
      $icon.size(0),
      SelectedState.selected(
        $icon.size(9),
      ),
    );

    final Style focusStateStyle = Style(
      $box.height(32),
      $on.focus(
        $box.border.color.black12(),
        $box.border.width(4),
        $box.shape.circle(),
      ),
    );

    return Column(
      children: List.generate(
        _Choices.values.length,
        (int index) => Column(
          children: [
            MoonBaseSingleSelectWidget(
              toggleable: true,
              style: focusStateStyle.animate(duration: _animationDuration),
              value: _Choices.values[index],
              groupValue: _valueCustom,
              onChanged: (_Choices? value) =>
                  setState(() => _valueCustom = value),
              child: Box(
                style: outerCircleStyle
                    .applyVariant(_getVariant(_Choices.values[index]))
                    .animate(duration: _animationDuration),
                child: StyledIcon(
                  Icons.circle,
                  style: iconStyle
                      .applyVariant(_getVariant(_Choices.values[index]))
                      .animate(duration: _animationDuration),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
