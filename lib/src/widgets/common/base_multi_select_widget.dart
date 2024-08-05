import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class MoonBaseMultiSelectWidget extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Should gestures provide audible and/or haptic feedback.
  ///
  /// On platforms like Android, enabling feedback will result in audible and tactile
  /// responses to certain actions. For example, a tap may produce a clicking sound,
  /// while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// Whether the widget supports a tri-state (indeterminate).
  ///
  /// When tri-state is true, the widget can be in one of three states: true, false, or null.
  ///
  /// When tri-state is false (the default), the widget [value] can only be true or false.
  ///
  /// If tri-state is true, the widget displays a dash when its [value] is null, indicating the mixed state.
  ///
  /// When a tri-state widget is tapped, its [onChanged] callback is invoked, cycling through the three states:
  /// * If the current value is false, the [value] becomes true.
  /// * If the current value is true, the [value] becomes null (mixed state).
  /// * If the current value is null (mixed state), the [value] becomes false.
  ///
  /// If tri-state is false, the [value] must not be null.
  final bool tristate;

  /// Whether the widget is selected.
  ///
  /// When [tristate] is true, a value of null corresponds to the indeterminate state.
  /// When [tristate] is false, this value must not be null.
  final bool? value;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// The style of the widget.
  final Style? style;

  /// Called when the focus state of the [Focus] changes.
  ///
  /// Called with true when the [Focus] node gains focus
  /// and false when the [Focus] node loses focus.
  final dynamic Function(bool)? onFocusChange;

  /// The callback that is called when the widget value changes.
  ///
  /// The widget passes its [value] as a parameter to [onChanged] callback.
  /// The widget does not actually change state until the parent widget
  /// rebuilds the widget with the new [value].
  ///
  /// If null, the widget is displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent gets rebuilt.

  final ValueChanged<bool?>? onChanged;

  /// The content of the widget.
  final Widget child;

  /// Creates a Moon Design raw multi select widget.
  const MoonBaseMultiSelectWidget({
    super.key,
    this.autofocus = false,
    this.enableFeedback = false,
    this.tristate = false,
    required this.value,
    this.focusNode,
    this.semanticLabel,
    this.style,
    this.onFocusChange,
    required this.onChanged,
    required this.child,
  }) : assert(
          tristate || value != null,
          'A non-tristate widget must have a non-null value.',
        );

  void _handleTap() {
    switch (value) {
      case false:
        onChanged!(true);
      case true:
        onChanged!(tristate ? null : false);
      case null:
        onChanged!(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      selected: value,
      mixed: tristate ? value == null : null,
      child: MoonBaseInteractiveWidget(
        autofocus: autofocus,
        focusNode: focusNode,
        enableFeedback: enableFeedback,
        style: style,
        onFocusChange: onFocusChange,
        onPress: onChanged == null ? null : () => _handleTap(),
        child: child,
      ),
    );
  }
}
