import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/src/utils/shape_decoration_premul.dart';
import 'package:moon_core/src/widgets/common/base_interactive_widget.dart';

class MoonRawSwitch extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether to use haptic feedback (vibration) when the switch is toggled.
  final bool hasHapticFeedback;

  /// Whether the switch is in active (on) state.
  final bool value;

  /// Whether the switch thumb should use an overshoot animation when toggling.
  /// If false, the thumb will use [curve] for the animation.
  final bool thumbAnimatesWithOvershoot;

  /// The decoration tween for the active and inactive tracks of the switch.
  final DecorationTween? trackDecorationTween;

  /// The duration of the switch toggle animation.
  final Duration duration;

  /// The curve of the switch toggle animation.
  final Curve curve;

  /// The padding of the switch.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the switch.
  final String? semanticLabel;

  /// The style for the switch.
  final Style? switchStyle;

  /// The style for the switch thumb.
  final Style? thumbStyle;

  /// The callback that is called when the switch toggles between the
  /// active (on) and inactive (off) states.
  final ValueChanged<bool>? onChanged;

  /// The widget to display on the left side of the switch track when the switch
  /// is active (on).
  final Widget? activeTrackWidget;

  /// The widget to display on the right side of the switch track when the
  /// switch is inactive (off).
  final Widget? inactiveTrackWidget;

  /// The widget to display inside the thumb when the switch is active (on).
  final Widget? activeThumbWidget;

  /// The widget to display inside the thumb when the switch is inactive (off).
  final Widget? inactiveThumbWidget;

  /// Creates a Moon Design raw switch.
  const MoonRawSwitch({
    super.key,
    this.autofocus = false,
    this.hasHapticFeedback = true,
    required this.value,
    this.thumbAnimatesWithOvershoot = true,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOutCubic,
    this.padding,
    this.focusNode,
    this.semanticLabel,
    this.thumbStyle,
    this.switchStyle,
    this.trackDecorationTween,
    this.onChanged,
    this.activeTrackWidget,
    this.inactiveTrackWidget,
    this.activeThumbWidget,
    this.inactiveThumbWidget,
  });

  @override
  _MoonRawSwitchState createState() => _MoonRawSwitchState();
}

class _MoonRawSwitchState extends State<MoonRawSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late CurvedAnimation _curvedAnimation;
  late CurvedAnimation _curvedAnimationWithOvershoot;

  late Animation<Decoration>? _trackDecorationAnimation;
  late Animation<double> _activeTrackWidgetFadeAnimation;
  late Animation<double> _inactiveTrackWidgetFadeAnimation;
  late Animation<double> _thumbFadeAnimation;

  bool get _isInteractive => widget.onChanged != null;

  void _resumePositionAnimation() {
    _curvedAnimationWithOvershoot
      ..curve = Curves.ease
      ..reverseCurve = Curves.ease.flipped;

    widget.value
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _handleTap() {
    if (_isInteractive) {
      widget.onChanged?.call(!widget.value);

      if (widget.hasHapticFeedback) _emitVibration();
    }
  }

  void _emitVibration() => HapticFeedback.lightImpact();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    _curvedAnimationWithOvershoot = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );

    _thumbFadeAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 50.0,
      ),
    ]).animate(_curvedAnimation);

    _activeTrackWidgetFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0),
      ),
    );

    _inactiveTrackWidgetFadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3),
      ),
    );

    _trackDecorationAnimation = (widget.trackDecorationTween ??
            DecorationTween(
              begin: ShapeDecorationWithPremultipliedAlpha(
                color: Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              end: ShapeDecorationWithPremultipliedAlpha(
                color: Colors.deepPurple.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ))
        .animate(_curvedAnimation);
  }

  @override
  void didUpdateWidget(MoonRawSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) _resumePositionAnimation();

    if (_curvedAnimationWithOvershoot.value == 0.0 ||
        _curvedAnimationWithOvershoot.value == 1.0) {
      _curvedAnimationWithOvershoot
        ..curve = widget.thumbAnimatesWithOvershoot
            ? Curves.easeOutBack
            : widget.curve
        ..reverseCurve = widget.thumbAnimatesWithOvershoot
            ? Curves.easeOutBack.flipped
            : widget.curve.flipped;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry effectivePadding =
        widget.padding ?? const EdgeInsets.all(4);

    final EdgeInsets resolvedDirectionalPadding =
        effectivePadding.resolve(Directionality.of(context));

    final isLtr = Directionality.of(context) == TextDirection.ltr;

    final Animation<Alignment> alignmentAnimation = AlignmentTween(
      begin: isLtr ? Alignment.centerLeft : Alignment.centerRight,
      end: isLtr ? Alignment.centerRight : Alignment.centerLeft,
    ).animate(_curvedAnimationWithOvershoot);

    return Semantics(
      label: widget.semanticLabel,
      toggled: widget.value,
      child: MoonBaseInteractiveWidget(
        enabled: _isInteractive,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        style: Style(
          $box.height(24),
          $box.width(44),
        ).merge(widget.switchStyle),
        onPress: _handleTap,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return DecoratedBoxTransition(
                decoration: _trackDecorationAnimation!,
                child: Padding(
                  padding: resolvedDirectionalPadding,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: widget.activeTrackWidget != null
                                ? FadeTransition(
                                    opacity: _activeTrackWidgetFadeAnimation,
                                    child: widget.activeTrackWidget,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          SizedBox(
                            width: resolvedDirectionalPadding.left,
                          ),
                          Expanded(
                            child: widget.inactiveTrackWidget != null
                                ? FadeTransition(
                                    opacity: _inactiveTrackWidgetFadeAnimation,
                                    child: widget.inactiveTrackWidget,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                      Align(
                        alignment: alignmentAnimation.value,
                        child: Box(
                          style: Style(
                            $box.width(16),
                            $box.height(16),
                            $box.borderRadius(8),
                            $box.color(Colors.white),
                          )
                              .animate(duration: widget.duration)
                              .merge(widget.thumbStyle),
                          child: FadeTransition(
                            opacity: _thumbFadeAnimation,
                            child: _curvedAnimation.value > 0.5
                                ? widget.activeThumbWidget
                                : widget.inactiveThumbWidget,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
