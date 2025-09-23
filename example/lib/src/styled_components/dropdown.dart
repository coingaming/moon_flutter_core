import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

enum _Options {
  first,
  second,
  third;

  String get name {
    return switch (this) {
      _Options.first => "Choice #1",
      _Options.second => "Choice #2",
      _Options.third => "Choice #3",
    };
  }
}

class StyledDropdown extends StatefulWidget {
  const StyledDropdown({super.key});

  @override
  State<StyledDropdown> createState() => _StyledDropdownState();
}

class _StyledDropdownState extends State<StyledDropdown> {
  bool _showOptions = false;

  final Map<_Options, bool> _options = {
    _Options.first: false,
    _Options.second: false,
    _Options.third: false,
  };

  BoxStyler get _targetStyle => BoxStyler()
      .width(170)
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 8),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .border(
        BorderMix.all(
          BorderSideMix.value(const BorderSide(color: Colors.purple)),
        ),
      )
      .color(Colors.white)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black87))
      .onHovered(BoxStyler().color(Colors.purple.shade50))
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 180)),
      );

  FlexBoxStyler get _targetContentStyle => FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.spaceBetween)
      .crossAxisAlignment(CrossAxisAlignment.center)
      .spacing(12);

  BoxStyler get _dropdownContainerStyle => BoxStyler()
      .width(170)
      .color(Colors.white)
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .border(
        BorderMix.all(
          BorderSideMix.value(const BorderSide(color: Colors.purple)),
        ),
      )
      .padding(EdgeInsetsGeometryMix.all(8))
      .shadow(
        BoxShadowMix.value(
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.purple.withValues(alpha: 0.12),
          ),
        ),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  FlexBoxStyler get _menuListStyle => FlexBoxStyler()
      .crossAxisAlignment(CrossAxisAlignment.stretch)
      .spacing(4);

  BoxStyler get _menuItemStyle => BoxStyler()
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 8),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .onHovered(BoxStyler().color(Colors.purple.shade50))
      .onFocused(BoxStyler().color(Colors.purple.shade100))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 120)),
      );

  FlexBoxStyler get _menuItemContentStyle => FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.spaceBetween)
      .crossAxisAlignment(CrossAxisAlignment.center);

  String get _selectedLabel {
    final selectedEntries =
        _options.entries.where((entry) => entry.value).toList(growable: false);

    if (selectedEntries.isEmpty) return "Choose an option";

    return selectedEntries.first.key.name;
  }

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      show: _showOptions,
      overlayAnchorPosition: OverlayAnchorPosition.bottom,
      onTapOutside: () => setState(() => _showOptions = false),
      target: MoonBaseInteractiveWidget(
        focusNode: FocusNode(skipTraversal: true),
        onTap: () => setState(() => _showOptions = !_showOptions),
        style: _targetStyle,
        child: RowBox(
          style: _targetContentStyle,
          children: [
            StyledText(_selectedLabel),
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _showOptions ? -0.5 : 0,
              child: MoonBaseInteractiveWidget(
                style: getIconButtonStyle(),
                mouseCursor: SystemMouseCursors.click,
                onTap: () => setState(() => _showOptions = !_showOptions),
                child: const StyledIcon(
                  icon: Icons.keyboard_arrow_down_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Box(
        style: _dropdownContainerStyle,
        child: ColumnBox(
          style: _menuListStyle,
          children: List.generate(_options.length, (int index) {
            final _Options choice = _Options.values[index];

            return MoonBaseInteractiveWidget(
              style: _menuItemStyle,
              onTap: () => setState(() {
                _options.updateAll((key, value) => false);
                _options[choice] = true;
                _showOptions = false;
              }),
              child: RowBox(
                style: _menuItemContentStyle,
                children: [
                  StyledText(choice.name),
                  if (_options[choice]!)
                    StyledIcon(
                      icon: Icons.check,
                      style: IconStyler().color(Colors.purple).size(16),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
