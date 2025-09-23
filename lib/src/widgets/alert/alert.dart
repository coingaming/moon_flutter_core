import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

class MoonRawAlert extends StatefulWidget {
  /// Whether to show the alert.
  final bool show;

  /// The duration of the alert visibility transition.
  final Duration transitionDuration;

  /// The curve of the alert visibility transition.
  final Curve transitionCurve;

  /// Semantic label for the alert.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	[Semantics] widget.
  final String? semanticLabel;

  /// The style of the alert container.
  final BoxStyler? style;

  /// Called when the visibility state of the alert has changed.
  final dynamic Function(bool)? onVisibilityChanged;

  /// The main content of the alert.
  ///
  /// The [BaseLayoutWidget] can be used as a convenience widget which has
  /// already pre-defined layout.
  final Widget child;

  /// Creates a Moon Design raw alert.
  const MoonRawAlert({
    super.key,
    this.show = false,
    this.style,
    this.semanticLabel,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.onVisibilityChanged,
    required this.child,
  });

  @override
  State<MoonRawAlert> createState() => _MoonRawAlertState();
}

class _MoonRawAlertState extends State<MoonRawAlert> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();

    _isVisible = widget.show;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: AnimatedOpacity(
        opacity: widget.show ? 1 : 0,
        duration: widget.transitionDuration,
        curve: widget.transitionCurve,
        onEnd: () {
          setState(() {
            _isVisible = widget.show;
            widget.onVisibilityChanged?.call(widget.show);
          });
        },
        child: Visibility(
          visible: widget.show || _isVisible,
          child: widget.style != null
              ? Box(style: widget.style!, child: widget.child)
              : widget.child,
        ),
      ),
    );
  }
}
