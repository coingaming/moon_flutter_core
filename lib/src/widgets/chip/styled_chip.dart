import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/utils/extensions.dart';
import 'package:moon_core/src/widgets/common/base_single_select_widget.dart';
import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';

enum _Choices {
  first,
  second,
  third;

  String get name => switch (this) {
        _Choices.first => "Chip 1",
        _Choices.second => "Chip 2",
        _Choices.third => "Chip 3",
      };
}

class StyledChip extends StatefulWidget {
  const StyledChip({super.key});

  @override
  State<StyledChip> createState() => _StyledChipState();
}

class _StyledChipState extends State<StyledChip> {
  _Choices? _valueCustom = _Choices.first;

  SelectedState _getVariant(_Choices? value) {
    return value == _valueCustom
        ? SelectedState.selected
        : SelectedState.unselected;
  }

  @override
  Widget build(BuildContext context) {
    final Style chipStyle = Style(
      $box.color(Colors.white),
      $box.borderRadius(8),
      $box.margin.horizontal(4),
      $box.padding(8.0, 12.0),
      $flex.gap(8.0),
      $flex.mainAxisSize.min(),
      $with.iconTheme.data(size: 16),
      ($on.hover | $on.focus | $on.press | $on.longPress)(
        $box.color(Colors.grey.shade300),
      ),
      SelectedState.unselected(
        $with.iconTheme.data(size: 0),
        $box.padding(8.0, 16.0, 8.0, 8.0),
      ),
      SelectedState.selected(
        $box.padding(8.0, 16.0, 8.0, 12.0),
        $box.color(Colors.deepPurple.shade100),
      ),
    ).animate(duration: const Duration(milliseconds: 200));

    return Column(
      children: [
        MoonBaseInteractiveWidget(
          onPress: () {},
          style: chipStyle,
          child: const StyledRow(
            inherit: true,
            children: [
              StyledIcon(Icons.widgets_outlined),
              Text("MoonChip"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _Choices.values.length,
            (int index) => MoonBaseSingleSelectWidget(
              value: _Choices.values[index],
              groupValue: _valueCustom,
              style: chipStyle.applyVariant(
                _getVariant(_Choices.values[index]),
              ),
              onChanged: (_Choices? value) =>
                  setState(() => _valueCustom = value),
              child: StyledRow(
                inherit: true,
                children: [
                  const Icon(Icons.check),
                  Text(_Choices.values[index].name),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
