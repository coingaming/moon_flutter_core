import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledAuthCode extends StatefulWidget {
  const StyledAuthCode({super.key});

  @override
  State<StyledAuthCode> createState() => _StyledAuthCodeState();
}

class _StyledAuthCodeState extends State<StyledAuthCode> {
  FlexBoxStyler get _rowStyle =>
      FlexBoxStyler().spacing(12).mainAxisAlignment(MainAxisAlignment.center);

  BoxStyler get _cellStyle => BoxStyler()
      .constraints(BoxConstraintsMix.square(56))
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(8)),
      )
      .color(Colors.white)
      .border(
        BorderMix.all(
          BorderSideMix.value(
            const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      )
      .wrapDefaultTextStyle(TextStyleMix(fontSize: 24, color: Colors.black))
      .variant(
        moonActiveContextVariant,
        BoxStyler()
            .border(
              BorderMix.all(
                BorderSideMix.value(
                  const BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
            )
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.orange)),
      )
      .onSelected(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),
      )
      .onError(
        BoxStyler()
            .border(
              BorderMix.all(
                BorderSideMix.value(
                  const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            )
            .wrapDefaultTextStyle(TextStyleMix(color: Colors.red)),
      )
      .animate(AnimationConfig.ease(const Duration(milliseconds: 200)));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: MoonRawAuthCode(
        authInputFieldCount: 4,
        cursorColor: Colors.orange,
        errorAnimationType: ErrorAnimationType.shake,
        rowStyle: _rowStyle,
        cellStyle: _cellStyle,
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
        helperText: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text("This is hint", style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
