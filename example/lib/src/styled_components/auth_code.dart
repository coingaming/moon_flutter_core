import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledAuthCode extends StatefulWidget {
  const StyledAuthCode({super.key});

  @override
  State<StyledAuthCode> createState() => _StyledAuthCodeState();
}

class _StyledAuthCodeState extends State<StyledAuthCode> {
  ShapeDecorationWithPremultipliedAlpha _getBorder(
    Color color, {
    double width = 1,
  }) =>
      ShapeDecorationWithPremultipliedAlpha(
        color: Colors.white,
        shape: MoonSquircleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color, width: width),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: MoonRawAuthCode(
        authInputFieldCount: 4,
        errorAnimationType: ErrorAnimationType.shake,
        authFieldCursorColor: Colors.orange,
        hint: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "This is hint",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        inputFieldStyle: Style(
          $box.shapeDecoration.as(_getBorder(Colors.grey)),
          $flex.chain
            ..gap(12)
            ..mainAxisAlignment(MainAxisAlignment.center),
          $on.active(
            $box.shapeDecoration.as(_getBorder(Colors.orange)),
            $text.style.color(Colors.orange),
          ),
          $on.selected(
            $box.shapeDecoration.as(_getBorder(Colors.purple, width: 2)),
          ),
          $on.error(
            $box.shapeDecoration.as(_getBorder(Colors.red)),
            $text.chain.style.color(Colors.red),
          ),
          ($on.selected & $on.error)(
            $box.shapeDecoration.as(_getBorder(Colors.red, width: 2)),
          ),
          $with.defaultTextStyle.style.fontSize(24),
        ).animate(duration: const Duration(milliseconds: 200)),
        validator: (String? pin) =>
            (pin != null && pin != "0000" && pin.length == 4)
                ? "The input must be exactly '0000'."
                : null,
        errorBuilder: (BuildContext context, String? errorText) => Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            errorText ?? "",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
