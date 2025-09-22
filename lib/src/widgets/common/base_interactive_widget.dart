import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mix/mix.dart';

/// Base widget for interactive widgets (eg. button, chip, tag, menu item etc).
class MoonBaseInteractiveWidget extends StatelessWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether the widget is enabled and interactive.
  final bool enabled;

  /// Should gestures provide audible and/or haptic feedback.
  ///
  /// On platforms like Android, enabling feedback will result in audible and
  /// tactile responses to certain actions. For example, a tap may produce a
  /// clicking sound, while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.GestureDetector.hitTestBehavior}
  final HitTestBehavior hitTestBehavior;

  /// The controller for the widget state.
  final WidgetStatesController? stateController;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

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
  /// If this callback and [onLongPress] are null, then widget will be disabled
  /// automatically.
  final VoidCallback? onTap;

  /// The callback that is called when widget is long-pressed.
  ///
  /// If this callback and [onTap] are null, then widget will be disabled
  /// automatically.
  final VoidCallback? onLongPress;

  /// Called when the focus state of the [Focus] changes.
  ///
  /// Called with true when the [Focus] node gains focus and false when the
  /// [Focus] node loses focus.
  final dynamic Function(bool)? onFocusChange;

  /// The main content of the widget.
  final Widget child;

  /// Creates a Moon Design raw interactive widget.
  const MoonBaseInteractiveWidget({
    super.key,
    this.autofocus = false,
    this.enabled = true,
    this.enableFeedback = false,
    this.focusNode,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.stateController,
    this.mouseCursor,
    this.semanticLabel,
    this.style,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && (onTap != null || onLongPress != null);

    return ExcludeFocusTraversal(
      excluding: !isEnabled,
      child: Semantics(
        label: semanticLabel,
        child: CallbackShortcuts(
          bindings: onTap != null
              ? {
                  const SingleActivator(LogicalKeyboardKey.enter): onTap!,
                  const SingleActivator(LogicalKeyboardKey.space): onTap!,
                }
              : {},
          child: Pressable(
            autofocus: autofocus,
            focusNode: focusNode,
            enabled: isEnabled,
            enableFeedback: enableFeedback,
            hitTestBehavior: hitTestBehavior,
            mouseCursor: mouseCursor,
            controller: stateController,
            onFocusChange: onFocusChange,
            onPress: enabled ? onTap : null,
            onLongPress: enabled ? onLongPress : null,
            child: Box(style: style, child: child),
          ),
        ),
      ),
    );
  }
}
