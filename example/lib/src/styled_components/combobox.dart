import 'package:example/src/common_styles.dart';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

enum _Options {
  first,
  second,
  third,
  fourth,
  fifth;

  String get name {
    return switch (this) {
      _Options.first => "Choice #1",
      _Options.second => "Choice #2",
      _Options.third => "Choice #3",
      _Options.fourth => "Choice #4",
      _Options.fifth => "Choice #5",
    };
  }
}

class StyledCombobox extends StatefulWidget {
  const StyledCombobox({super.key});

  @override
  State<StyledCombobox> createState() => _StyledComboboxState();
}

class _StyledComboboxState extends State<StyledCombobox> {
  bool _showOptions = false;

  final Map<_Options, bool> _options = {
    _Options.first: false,
    _Options.second: false,
    _Options.third: false,
    _Options.fourth: false,
    _Options.fifth: false,
  };

  int get _selectedCount =>
      _options.values.where((isSelected) => isSelected).length;

  BoxStyler get _inputStyle => BoxStyler()
      .width(280)
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 10),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .border(
        BorderMix.all(
          BorderSideMix.value(const BorderSide(color: Colors.purple)),
        ),
      )
      .color(Colors.white)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.black87))
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

  BoxStyler get _overlayStyle => BoxStyler()
      .width(280)
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
            blurRadius: 16,
            offset: const Offset(0, 6),
            color: Colors.purple.withValues(alpha: 0.14),
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
        EdgeInsetsGeometryMix.symmetric(horizontal: 12, vertical: 10),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(8))
      .onHovered(BoxStyler().color(Colors.purple.shade50))
      .onFocused(BoxStyler().color(Colors.purple.shade100))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 120)),
      );

  FlexBoxStyler get _menuItemContentStyle => FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.spaceBetween)
      .crossAxisAlignment(CrossAxisAlignment.center)
      .spacing(12);

  BoxStyler get _selectionBadgeStyle => BoxStyler()
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 8, vertical: 4),
      )
      .borderRadius(BorderRadiusGeometryMix.circular(6))
      .color(Colors.purple.shade50)
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.purple))
      .wrapIconTheme(
        IconThemeData(color: Colors.purple.shade400, size: 14),
      )
      .onHovered(BoxStyler().color(Colors.purple.shade100))
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 150)),
      );

  BoxStyler get _checkboxStyle => BoxStyler()
      .constraints(BoxConstraintsMix.square(20))
      .alignment(Alignment.center)
      .borderRadius(BorderRadiusGeometryMix.circular(4))
      .border(
        BorderMix.all(
          BorderSideMix.value(
            const BorderSide(color: Colors.purple, width: 2),
          ),
        ),
      )
      .color(Colors.transparent)
      .onSelected(
        BoxStyler()
            .color(Colors.purple)
            .border(
              BorderMix.all(
                BorderSideMix.value(
                  const BorderSide(color: Colors.purple, width: 2),
                ),
              ),
            ),
      )
      .animate(
        AnimationConfig.ease(const Duration(milliseconds: 150)),
      );

  IconStyler get _checkboxIconStyle => IconStyler().size(14).color(Colors.white);

  IconStyler get _clearIconStyle =>
      IconStyler().size(14).color(Colors.purple.shade400);

  FlexBoxStyler get _badgeContentStyle =>
      FlexBoxStyler().mainAxisSize(MainAxisSize.min).spacing(4);

  void _toggleOption(_Options choice) {
    setState(() => _options[choice] = !_options[choice]!);
  }

  void _clearSelection() {
    setState(() => _options.updateAll((key, value) => false));
  }

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      overlayAnchorPosition: OverlayAnchorPosition.bottom,
      show: _showOptions,
      onTapOutside: () => setState(() => _showOptions = false),
      target: MoonRawTextInput(
        textInputConfiguration: MoonTextInputConfiguration(
          readOnly: true,
          canRequestFocus: false,
          inputStyle: _inputStyle,
          onTap: () => setState(() => _showOptions = !_showOptions),
          hint: const StyledText('Choose an option'),
          leading: _selectedCount > 0
              ? Center(
                  child: MoonBaseInteractiveWidget(
                    style: _selectionBadgeStyle,
                    onTap: _clearSelection,
                    child: RowBox(
                      style: _badgeContentStyle,
                      children: [
                        StyledText('$_selectedCount'),
                        StyledIcon(icon: Icons.close, style: _clearIconStyle),
                      ],
                    ),
                  ),
                )
              : null,
          trailing: Center(
            child: AnimatedRotation(
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
          ),
        ),
      ),
      child: Box(
        style: _overlayStyle,
        child: ColumnBox(
          style: _menuListStyle,
          children: _Options.values.map((choice) {
            final bool isSelected = _options[choice]!;

            return MoonBaseInteractiveWidget(
              style: _menuItemStyle,
              onTap: () => _toggleOption(choice),
              child: RowBox(
                style: _menuItemContentStyle,
                children: [
                  StyledText(choice.name),
                  MoonBaseMultiSelectWidget(
                    value: isSelected,
                    style: _checkboxStyle,
                    onChanged: (_) => _toggleOption(choice),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: isSelected
                          ? StyledIcon(
                              key: ValueKey(choice),
                              icon: Icons.check,
                              style: _checkboxIconStyle,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(growable: false),
        ),
      ),
    );
  }
}
