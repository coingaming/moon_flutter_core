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

  /// The style of the alert.
  final Style? style;

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

class _MoonRawAlertState extends State<MoonRawAlert>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;

  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;

  void _showAlert() {
    if (!mounted) return;
    _animationController!.forward();

    setState(() => _isVisible = true);

    widget.onVisibilityChanged?.call(true);
  }

  void _hideAlert() {
    _animationController!.reverse().then<void>((void value) {
      if (!mounted) return;

      setState(() => _isVisible = false);

      widget.onVisibilityChanged?.call(false);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;

      if (_isVisible) _animationController!.value = 1.0;
    });
  }

  @override
  void didUpdateWidget(MoonRawAlert oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.show != widget.show) {
      widget.show ? _showAlert() : _hideAlert();
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController ??= AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    _curvedAnimation ??= CurvedAnimation(
      parent: _animationController!,
      curve: widget.transitionCurve,
    );

    return Visibility(
      visible: _isVisible,
      child: Semantics(
        label: widget.semanticLabel,
        child: FadeTransition(
          opacity: _curvedAnimation!,
          child: Box(
            style: widget.style,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
