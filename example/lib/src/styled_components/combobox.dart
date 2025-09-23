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

  Style get _targetStyle => Style(
    $box.chain
      ..width(280)
      ..padding(8, 8)
      ..borderRadius(8)
      ..color(Colors.white)
      ..border(color: Colors.purple),
    $flex.mainAxisAlignment.spaceBetween(),
    $on.disabled($with.opacity(0.2)),
  );

  Style get _overlayStyle => Style(
    $box.chain
      ..width(280)
      ..color(Colors.white)
      ..borderRadius(8)
      ..border(color: Colors.purple)
      ..padding(8),
  );

  Style get _leadingStyle =>
      Style($box.padding(4, 8), $box.margin(4), $icon.size(14));

  Style get _menuItemStyle => Style(
    $box.chain
      ..padding(8)
      ..borderRadius(8),
    $flex.mainAxisAlignment.spaceBetween(),
  ).merge(getEffects());

  Style get _checkboxStyle => Style(
    $box.chain
      ..borderRadius(4)
      ..color(Colors.purple)
      ..border.color(Colors.purple),
    SelectedState.unselected(
      $box.chain
        ..color.transparent()
        ..border.color.black54(),
    ),
  ).animate();

  Style get _arrowStyle => Style(
    $icon.chain
      ..size(16)
      ..color.white(),
    SelectedState.unselected($with.opacity(0)),
  ).animate(duration: const Duration(milliseconds: 300));

  Variant _getEffectiveVariant(bool value) =>
      value ? SelectedState.selected : SelectedState.unselected;

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
          mouseCursor: SystemMouseCursors.click,
          inputStyle: _targetStyle,
          onTap: () => setState(() => _showOptions = !_showOptions),
          hint: const Text('Choose an option'),
          leading: _options.values.any((element) => element == true)
              ? Center(
                  child: MoonBaseInteractiveWidget(
                    style: getButtonStyle().merge(_leadingStyle),
                    onTap: () => setState(
                      () => _options.updateAll((key, value) => false),
                    ),
                    child: Row(
                      children: [
                        StyledText(
                          "${_options.values.where((element) => element == true).length}",
                        ),
                        const StyledIcon(icon: Icons.close),
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
      child: SingleChildScrollView(
        child: VBox(
          style: _overlayStyle,
          children: List.generate(5, (int index) {
            final _Options choice = _Options.values[index];
            final bool isSelected = _options[choice]!;
            final Variant variant = _getEffectiveVariant(isSelected);

            return MoonBaseInteractiveWidget(
              style: _menuItemStyle,
              onTap: () =>
                  setState(() => _options[choice] = !_options[choice]!),
              child: StyledRow(
                inherit: true,
                children: [
                  Text(choice.name),
                  ExcludeFocusTraversal(
                      child: MoonBaseMultiSelectWidget(
                        style: _checkboxStyle.applyVariant(variant),
                        value: isSelected,
                        onChanged: (bool? value) =>
                            setState(() => _options[choice] = !_options[choice]!),
                        child: StyledIcon(
                          icon:
                              variant == SelectedState.selected ? Icons.check : null,
                          style: _arrowStyle.applyVariant(variant),
                        ),
                      ),
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
