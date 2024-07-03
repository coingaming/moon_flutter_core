import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Base widget for interactive widgets (eg. button, chip, tag, menu item etc).
class MoonBaseInteractiveWidget extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Should gestures provide audible and/or haptic feedback.
  ///
  /// On platforms like Android, enabling feedback will result in audible and tactile
  /// responses to certain actions. For example, a tap may produce a clicking sound,
  /// while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// The duration to wait after the press is released before the state of pressed is removed.
  final Duration unpressDelay;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.GestureDetector.hitTestBehavior}
  final HitTestBehavior hitTestBehavior;

  /// Semantic label for the widget.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	[Semantics] widget.
  final String? semanticLabel;

  /// The style of the widget.
  final Style? style;

  /// The callback that is called when the widget is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then widget will be disabled automatically.
  final VoidCallback? onPress;

  /// The callback that is called when widget is long-pressed.
  ///
  /// If this callback and [onPress] are null, then widget will be disabled automatically.
  final VoidCallback? onLongPress;

  /// Called when the focus state of the [Focus] changes.
  ///
  /// Called with true when the [Focus] node gains focus
  /// and false when the [Focus] node loses focus.
  final dynamic Function(bool)? onFocusChange;

  /// The main content of the widget.
  final Widget child;

  const MoonBaseInteractiveWidget({
    super.key,
    this.autofocus = false,
    this.enableFeedback = false,
    this.unpressDelay = const Duration(milliseconds: 200),
    this.focusNode,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.semanticLabel,
    this.style,
    this.onPress,
    this.onLongPress,
    this.onFocusChange,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: MouseRegion(
        cursor: (onPress != null || onLongPress != null)
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: PressableBox(
          autofocus: autofocus,
          focusNode: focusNode,
          enabled: onPress != null || onLongPress != null,
          enableFeedback: enableFeedback,
          hitTestBehavior: hitTestBehavior,
          unpressDelay: unpressDelay,
          onFocusChange: onFocusChange,
          onPress: onPress,
          onLongPress: onLongPress,
          style: style,
          child: child,
        ),
      ),
    );
  }
}
