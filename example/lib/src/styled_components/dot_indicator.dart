import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledDotIndicator extends StatefulWidget {
  const StyledDotIndicator({super.key});

  @override
  State<StyledDotIndicator> createState() => _StyledDotIndicatorState();
}

class _StyledDotIndicatorState extends State<StyledDotIndicator> {
  int _selectedDot = 0;

  Style get _rowStyle => Style(
        $flex.chain
          ..mainAxisAlignment.center()
          ..gap(16),
      );

  Style get _dotStyle => Style(
        $box.chain
          ..width(8)
          ..height(8)
          ..color(Colors.grey)
          ..shape.circle(),
        SelectedState.selected(
          $box.color(Colors.purple),
        ),
      ).animate(duration: const Duration(milliseconds: 400));

  Style get _boxStyle => Style(
        $box.chain
          ..height(32)
          ..width(32)
          ..borderRadius(4)
          ..color(Colors.purple),
        $text.style.color(Colors.white),
        ($on.hover | $on.focus | $on.press | $on.longPress)(
          $box.color(Colors.purple.shade300),
        ),
        SelectedState.selected(
          $box.color(Colors.purple.shade300),
        ),
      ).animate(duration: const Duration(milliseconds: 400));

  Variant _getVariant(int index) =>
      index == _selectedDot ? SelectedState.selected : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyledRow(
          style: _rowStyle,
          children: [
            ...List<Widget>.generate(
              4,
              (int index) {
                return Box(
                  style: _dotStyle.applyVariant(_getVariant(index)),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        StyledRow(
          style: _rowStyle,
          children: List<Widget>.generate(
            4,
            (int index) => MoonBaseInteractiveWidget(
              style: _boxStyle.applyVariant(_getVariant(index)),
              onTap: () => setState(() => _selectedDot = index),
              child: Center(
                child: StyledText('$index'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
