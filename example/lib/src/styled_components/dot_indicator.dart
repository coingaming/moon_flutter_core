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

  FlexBoxStyler get _rowStyle => FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.center)
      .spacing(16);

  BoxStyler get _boxStyle {
    final BoxStyler activeState = BoxStyler()
        .color(Colors.purple.shade300)
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.white));

    return BoxStyler()
        .constraints(BoxConstraintsMix.square(32))
        .borderRadius(BorderRadiusGeometryMix.circular(4))
        .color(Colors.purple)
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.white))
        .onHovered(activeState)
        .onFocused(activeState)
        .onPressed(activeState)
        .onSelected(activeState)
        .animate(
          AnimationConfig.ease(const Duration(milliseconds: 400)),
        );
  }

  BoxStyler getDotStyle(Color color) => BoxStyler()
      .constraints(BoxConstraintsMix.square(12))
      .color(color)
      .shapeCircle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawDotIndicator(
          dotCount: 4,
          selectedDot: _selectedDot,
          dotIndicatorStyle: _rowStyle,
          dotBuilder: (int index, Color color) {
            return Box(style: getDotStyle(color));
          },
        ),
        const SizedBox(height: 16),
        RowBox(
          style: _rowStyle,
          children: List<Widget>.generate(4, (int index) {
            final WidgetStatesController controller = WidgetStatesController()
              ..update(WidgetState.selected, index == _selectedDot);

            return MoonBaseInteractiveWidget(
              stateController: controller,
              style: _boxStyle,
              onTap: () => setState(() => _selectedDot = index),
              child: Center(child: StyledText('$index')),
            );
          }),
        ),
      ],
    );
  }
}
