import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key});

  Style get _buttonStyle => Style(
        $box.chain
          ..color(Colors.white)
          ..borderRadius(8)
          ..border(color: Colors.black38)
          ..padding(8.0),
        $flex.chain
          ..gap(8.0)
          ..mainAxisSize.min(),
        $with.scale(1),
        $with.opacity(1),
        $with.defaultTextStyle.style(color: Colors.black),
        $with.iconTheme.data(color: Colors.black, size: 16),
        ($on.hover | $on.focus)(
          $box.color(Colors.grey.shade300),
          $with.iconTheme.data(color: Colors.blue, size: 16),
          $with.defaultTextStyle.style(color: Colors.blue),
        ),
        ($on.press | $on.longPress)(
          $with.scale(0.95),
        ),
      ).animate(duration: const Duration(milliseconds: 200));

  @override
  Widget build(BuildContext context) {
    return MoonBaseInteractiveWidget(
      onTap: () {},
      style: _buttonStyle,
      child: StyledRow(
        inherit: true,
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
                  Positioned(
                    bottom: 0,
                    child: Text("JD"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
