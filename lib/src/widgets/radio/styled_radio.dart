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
      $box.height(16),
      $box.margin.vertical(4),
      $box.border.color.black54(),
      $box.shape.circle(),
      SelectedState.selected(
        $box.border.color.deepPurple.shade600(),
      ),
    );

    final Style iconStyle = Style(
      $icon.color(Colors.deepPurple),
      $icon.size(0),
      SelectedState.selected(
        $icon.size(8),
      ),
    );

    return Column(
      children: List.generate(
        _Choices.values.length,
        (int index) => MoonBaseSingleSelectWidget(
          toggleable: true,
          style: outerCircleStyle
              .applyVariant(_getVariant(_Choices.values[index]))
              .animate(duration: _animationDuration),
          value: _Choices.values[index],
          groupValue: _valueCustom,
          onChanged: (_Choices? value) =>
              setState(() => _valueCustom = value),
          child: SizedBox(
            width: 16,
            child: StyledIcon(
              Icons.circle,
              style: iconStyle
                  .applyVariant(_getVariant(_Choices.values[index]))
                  .animate(duration: _animationDuration),
            ),
          ),
        ),
      ),
    );
  }
}
