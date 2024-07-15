import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MoonRawSegmentedTab {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether the segmented tab is disabled.
  final bool disabled;

  /// Should gestures provide audible and/or haptic feedback.
  ///
  /// On platforms like Android, enabling feedback will result in audible and tactile
  /// responses to certain actions. For example, a tap may produce a clicking sound,
  /// while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the segmented tab.
  final String? semanticLabel;

  /// The styling options for the segmented tab.
  final Style? tabStyle;

  /// Called when the focus state of the [Focus] changes.
  ///
  /// Called with true when the [Focus] node gains focus and false when the
  /// [Focus] node loses focus.
  final dynamic Function(bool)? onFocusChange;

  /// The callback that returns the current selection status of the segmented tab
  /// as a boolean value.
  final ValueChanged<bool>? isSelected;

  /// The primary content of the segmented tab.
  final Widget? child;

  /// Creates a Moon Design raw segmented tab.
  const MoonRawSegmentedTab({
    this.autoFocus = false,
    this.disabled = false,
    this.enableFeedback = false,
    this.focusNode,
    this.tabStyle,
    this.semanticLabel,
    this.onFocusChange,
    this.isSelected,
    this.child,
  });
}
