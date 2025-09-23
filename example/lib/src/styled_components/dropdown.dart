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

  Style get _targetStyle => Style(
    $box.chain
      ..width(170)
      ..padding(8)
      ..borderRadius(8)
      ..color(Colors.white)
      ..border(color: Colors.purple),
    $flex.mainAxisAlignment.spaceBetween(),
    $on.disabled($with.opacity(0.2)),
  );

  Style get _dropdownStyle => Style(
    $box.chain
      ..width(170)
      ..color(Colors.white)
      ..borderRadius(8)
      ..border(color: Colors.purple)
      ..padding(8),
    $flex.crossAxisAlignment.start(),
  );

  Style get _menuItemStyle => Style(
    $box.chain
      ..padding(8)
      ..borderRadius(8),
    $on.hover($box.color(Colors.grey.withOpacity(0.2))),
    $on.focus($box.color(Colors.purple.shade100)),
  );

  @override
  Widget build(BuildContext context) {
    return MoonBaseOverlay(
      show: _showOptions,
      overlayAnchorPosition: OverlayAnchorPosition.bottom,
      onTapOutside: () => setState(() => _showOptions = false),
      target: MoonBaseInteractiveWidget(
        focusNode: FocusNode(skipTraversal: true),
        onTap: () => setState(() => _showOptions = !_showOptions),
        child: HBox(
          style: _targetStyle,
          children: [
            Text(
              _options.entries.any((e) => e.value)
                  ? _options.entries.firstWhere((e) => e.value).key.name
                  : "Choose an option",
            ),
            Center(
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _showOptions ? -0.5 : 0,
                child: MoonBaseInteractiveWidget(
                  style: getIconButtonStyle(),
                  onTap: () => setState(() => _showOptions = !_showOptions),
                  child: const StyledIcon(
                    icon: Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: VBox(
          style: _dropdownStyle,
          children: List.generate(3, (int index) {
            final _Options choice = _Options.values[index];

            return MoonBaseInteractiveWidget(
              style: _menuItemStyle,
              onTap: () => setState(() {
                _options.updateAll((key, value) => false);
                _options[choice] = true;
                _showOptions = !_showOptions;
              }),
              child: Row(children: [Expanded(child: Text(choice.name))]),
            );
          }),
        ),
      ),
    );
  }
}
