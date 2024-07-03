import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

class MoonBaseSingleSelectWidget<T> extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Should gestures provide audible and/or haptic feedback.
  ///
  /// On platforms like Android, enabling feedback will result in audible and tactile
  /// responses to certain actions. For example, a tap may produce a clicking sound,
  /// while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// Set to true if this widget is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  ///
  /// To indicate returning to an indeterminate state, [onChanged] is called with null.
  ///
  /// If true, [onChanged] is called with [value] when selected while [groupValue] != [value],
  /// or with null when selected again while [groupValue] == [value].
  ///
  /// If false, [onChanged] is called with [value] when selected while
  /// [groupValue] != [value], and only by selecting another widget in the
  /// group (i.e. changing the value of [groupValue]) can this widget be unselected.
  final bool toggleable;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// The style of the widget.
  final Style? style;

  /// The value represented by this widget.
  final T value;

  /// The currently selected value for a group of widgets.
  ///
  /// This widget is considered selected if its [value] matches the [groupValue].
  final T? groupValue;

  /// Called when the focus state of the [Focus] changes.
  ///
  /// Called with true when the [Focus] node gains focus
  /// and false when the [Focus] node loses focus.
  final dynamic Function(bool)? onFocusChange;

  /// The callback that is called when the user selects the widget.
  ///
  /// The widget passes its [value] as a parameter to [onChanged] callback.
  /// The widget does not actually change state until the parent widget
  /// rebuilds the widget with the new [groupValue].
  ///
  /// If null, the widget is displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent gets rebuilt.
  final ValueChanged<T?>? onChanged;

  /// The main content of the widget.
  final Widget child;

  const MoonBaseSingleSelectWidget({
    super.key,
    this.autofocus = false,
    this.enableFeedback = false,
    this.toggleable = false,
    this.focusNode,
    this.semanticLabel,
    this.style,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.onFocusChange,
    required this.child,
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      inMutuallyExclusiveGroup: true,
      selected: _isSelected,
      child: MoonBaseInteractiveWidget(
        autofocus: autofocus,
        focusNode: focusNode,
        enableFeedback: enableFeedback,
        style: style,
        onFocusChange: onFocusChange,
        onPress: onChanged == null
            ? null
            : () => onChanged!(_isSelected && toggleable ? null : value),
        child: child,
      ),
    );
  }
}
