import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';

class StyledDotIndicator extends StatefulWidget {
  const StyledDotIndicator({super.key});

  @override
  State<StyledDotIndicator> createState() => _StyledDotIndicatorState();
}

class _StyledDotIndicatorState extends State<StyledDotIndicator> {
  int _selectedDot = 0;

  Variant _variant(int index) =>
      index == _selectedDot ? SelectedState.selected : SelectedState.unselected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyledRow(
          style: Style(
            $flex.mainAxisAlignment.center(),
            $flex.gap(16),
          ),
          children: [
            ...List<Widget>.generate(
              4,
              (int index) {
                return Box(
                  style: Style(
                    $box.width(8),
                    $box.height(8),
                    $box.color(Colors.grey),
                    $box.shape.circle(),
                    SelectedState.selected($box.color(Colors.purple)),
                  )
                      .applyVariant(_variant(index))
                      .animate(duration: const Duration(milliseconds: 400)),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        StyledRow(
          style: Style(
            $flex.mainAxisAlignment.center(),
            $flex.gap(16),
          ),
          children: List<Widget>.generate(
            4,
            (int index) => MoonBaseInteractiveWidget(
              style: Style(
                $box.height(32),
                $box.width(32),
                $box.borderRadius(4),
                $box.color(Colors.purple),
                $text.style.color(Colors.white),
                ($on.hover | $on.focus | $on.press | $on.longPress)(
                  $box.color(Colors.purple.shade300),
                ),
                SelectedState.selected($box.color(Colors.purple.shade300)),
              )
                  .applyVariant(_variant(index))
                  .animate(duration: const Duration(milliseconds: 200)),
              onPress: () => setState(() => _selectedDot = index),
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
