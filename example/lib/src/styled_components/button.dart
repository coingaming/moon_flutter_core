import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key});

  BoxStyler get _buttonStyle {
    final BoxStyler hoverFocusStyle = BoxStyler()
        .color(Colors.grey.shade300)
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.blue))
        .wrapIconTheme(
          const IconThemeData(color: Colors.blue, size: 16),
        );

    final BoxStyler pressedStyle =
        BoxStyler().wrapScale(x: 0.95, y: 0.95);

    return BoxStyler()
        .color(Colors.white)
        .borderRadius(BorderRadiusGeometryMix.circular(8))
        .border(
          BorderMix.all(
            BorderSideMix.value(const BorderSide(color: Colors.black38)),
          ),
        )
        .padding(EdgeInsetsGeometryMix.all(8))
        .wrapDefaultTextStyle(TextStyleMix(color: Colors.black))
        .wrapIconTheme(const IconThemeData(color: Colors.black, size: 16))
        .onHovered(hoverFocusStyle)
        .onFocused(hoverFocusStyle)
        .onPressed(pressedStyle)
        .animate(
          AnimationConfig.ease(const Duration(milliseconds: 200)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onTap: () {},
      style: _buttonStyle,
      child: RowBox(
        style: FlexBoxStyler()
            .spacing(8)
            .mainAxisSize(MainAxisSize.min),
        children: [
          const Icon(Icons.widgets_outlined),
          const SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("MoonButton"),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const SizedBox(
              height: 48,
              width: 48,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(Icons.person, size: 24),
                  Positioned(bottom: 0, child: Text("JD")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
