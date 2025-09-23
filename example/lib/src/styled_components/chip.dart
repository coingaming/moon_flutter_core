import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

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

  BoxStyler get _chipStyle => BoxStyler()
      .color(Colors.white)
      .margin(EdgeInsetsGeometryMix.symmetric(horizontal: 4))
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 8),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black87))
      .onHovered(BoxStyler().color(Colors.grey.shade300))
      .onFocused(BoxStyler().color(Colors.grey.shade200))
      .onPressed(BoxStyler().color(Colors.grey.shade400))
      .onSelected(
        BoxStyler().color(Colors.deepPurple.shade100),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  FlexBoxStyler get _chipContentStyle => FlexBoxStyler()
      .mainAxisSize(MainAxisSize.min)
      .crossAxisAlignment(CrossAxisAlignment.center)
      .spacing(8);

  IconStyler get _chipIconStyle => IconStyler().size(16);

  IconStyler get _checkIconStyle =>
      IconStyler().size(16).color(Colors.deepPurple.shade600);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonBaseInteractiveWidget(
          onTap: () {},
          style: _chipStyle,
          child: RowBox(
            style: _chipContentStyle,
            children: [
              StyledIcon(icon: Icons.widgets_outlined, style: _chipIconStyle),
              const StyledText("MoonChip"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_Choices.values.length, (int index) {
            final _Choices value = _Choices.values[index];
            final bool isSelected = value == _valueCustom;

            return MoonBaseSingleSelectWidget<_Choices>(
              value: value,
              groupValue: _valueCustom,
              style: _chipStyle,
              onChanged: (_Choices? newValue) =>
                  setState(() => _valueCustom = newValue),
              child: RowBox(
                style: _chipContentStyle,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: isSelected
                        ? StyledIcon(
                            key: ValueKey(value),
                            icon: Icons.check,
                            style: _checkIconStyle,
                          )
                        : const SizedBox(width: 16, height: 16),
                  ),
                  StyledText(value.name),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
