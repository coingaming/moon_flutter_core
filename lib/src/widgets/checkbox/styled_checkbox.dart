import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_multi_select_widget.dart';
import 'package:moon_core/src/widgets/common/variants/selected_state_variants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MoonBaseMultiSelectWidget(
        tristate: true,
        style: Style(
          $box.height(20),
          $box.width(20),
          $box.borderRadius(4),
          $box.color.deepPurple.shade600(),
          $box.border.color.deepPurple.shade600(),
          SelectedState.unselected(
            $box.color.transparent(),
            $box.border.color.black54(),
          ),
        )
            .applyVariant(_effectiveVariant)
            .animate(duration: const Duration(milliseconds: 150)),
        value: _checkboxValue,
        onChanged: (bool? newValue) =>
            setState(() => _checkboxValue = newValue),
        child: StyledIcon(
          _effectiveVariant == SelectedState.indeterminate
              ? Icons.remove
              : _effectiveVariant == SelectedState.selected
                  ? Icons.check
                  : null,
          style: Style(
            $icon.size(16),
            $icon.color.white(),
            $with.opacity(1),
            SelectedState.unselected($with.opacity(0)),
          )
              .applyVariant(_effectiveVariant)
              .animate(duration: const Duration(milliseconds: 300)),
        ),
      ),
    );
  }
}
