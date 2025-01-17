import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledCheckbox extends StatefulWidget {
  const StyledCheckbox({super.key});

  @override
  State<StyledCheckbox> createState() => _StyledCheckboxState();
}

class _StyledCheckboxState extends State<StyledCheckbox> {
  bool? _checkboxValue = false;

  Variant get _effectiveVariant => _checkboxValue == null
      ? SelectedState.indeterminate
      : _checkboxValue!
          ? SelectedState.selected
          : SelectedState.unselected;

  IconData? get _icon => _effectiveVariant == SelectedState.indeterminate
      ? Icons.remove
      : _effectiveVariant == SelectedState.selected
          ? Icons.check
          : null;

  Style get _checkboxStyle => Style(
        $box.chain
          ..height(20)
          ..width(20)
          ..borderRadius(4)
          ..color.deepPurple.shade600()
          ..border(
            color: Colors.deepPurple.shade600,
            width: 0,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        SelectedState.unselected(
          $box.color.transparent(),
          $box.border.color.black54(),
        ),
      )
          .applyVariant(_effectiveVariant)
          .animate(duration: const Duration(milliseconds: 150));

  Style get _checkboxIconStyle => Style(
        $icon.chain
          ..size(16)
          ..color.white(),
        $with.opacity(1),
        SelectedState.unselected($with.opacity(0)),
      )
          .applyVariant(_effectiveVariant)
          .animate(duration: const Duration(milliseconds: 300));

  Style get _focusStateStyle => Style(
        $on.focus(
          $box.chain
            ..borderRadius(4)
            ..border(
              color: Colors.black12,
              width: 4,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
        ),
      ).animate(duration: const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    return MoonBaseMultiSelectWidget(
      tristate: true,
      style: _focusStateStyle,
      value: _checkboxValue,
      onChanged: (bool? newValue) => setState(() => _checkboxValue = newValue),
      child: Box(
        style: _checkboxStyle,
        child: StyledIcon(
          _icon,
          style: _checkboxIconStyle,
        ),
      ),
    );
  }
}
