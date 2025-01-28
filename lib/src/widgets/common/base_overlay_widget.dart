import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum OverlayAnchorPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  right,
  vertical,
  horizontal,
}

mixin OverlayPositionResolver {
  OverlayAnchorPosition getResolvedOverlayPosition(
    BuildContext context,
    RenderBox targetRenderBox,
    OverlayAnchorPosition overlayAnchorPosition,
  ) {
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final Offset overlayTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    OverlayAnchorPosition overlayPosition = overlayAnchorPosition;

    if (Directionality.of(context) == TextDirection.rtl ||
        overlayPosition == OverlayAnchorPosition.horizontal ||
        overlayPosition == OverlayAnchorPosition.vertical) {
      overlayPosition = switch (overlayPosition) {
        OverlayAnchorPosition.left => OverlayAnchorPosition.right,
        OverlayAnchorPosition.right => OverlayAnchorPosition.left,
        OverlayAnchorPosition.topLeft => OverlayAnchorPosition.topRight,
        OverlayAnchorPosition.topRight => OverlayAnchorPosition.topLeft,
        OverlayAnchorPosition.bottomLeft => OverlayAnchorPosition.bottomRight,
        OverlayAnchorPosition.bottomRight => OverlayAnchorPosition.bottomLeft,
        OverlayAnchorPosition.vertical => overlayTargetGlobalCenter.dy <
                overlayRenderBox.size.center(Offset.zero).dy
            ? OverlayAnchorPosition.bottom
            : OverlayAnchorPosition.top,
        OverlayAnchorPosition.horizontal => overlayTargetGlobalCenter.dx <
                overlayRenderBox.size.center(Offset.zero).dx
            ? OverlayAnchorPosition.right
            : OverlayAnchorPosition.left,
        _ => overlayPosition,
      };
    }

    return overlayPosition;
  }
}

class MoonBaseOverlay extends StatefulWidget {
  // This is required to show only one overlay at a time.
  static final List<MoonBaseOverlayState> _openedOverlays = [];

  /// Controls whether to show the overlay.
  final bool show;

  /// Determines whether multiple overlays can be open simultaneously.
  /// Defaults to 'false'.
  /// - If [hideOnTap] is 'true', the overlay will always be dismissed on tap,
  ///   even if [allowMultipleOverlays] is 'true'.
  /// - If [hideOnTap] is 'false' but [onTapOutside] specifies dismissal behavior,
  ///   the overlay will still be dismissed when tapped outside,
  ///   regardless of [allowMultipleOverlays].
  final bool allowMultipleOverlays;

  /// Determines whether the overlay should be dismissed when tapped. For finer
  /// control over dismissal, use [show], [onTap] and [onTapOutside] properties.
  /// If true, the overlay will always be dismissed on tap, regardless of any
  /// logic in [onTap] or [onTapOutside]. The [onTap] and [onTapOutside] callbacks
  /// will still be executed, but the dismissal behavior will take precedence.
  /// Defaults to false.
  final bool hideOnTap;

  /// The distance between the overlay and the [target].
  final double distanceToTarget;

  /// The margin around the overlay. Prevents the overlay from touching the
  /// horizontal edges of the viewport.
  final double overlayMargin;

  /// The duration of the overlay transition animation (fade in and out).
  final Duration transitionDuration;

  /// The curve of the overlay transition animation (fade in and out).
  final Curve transitionCurve;

  /// Sets the overlay anchor position relative to the [target].
  /// Defaults to [OverlayAnchorPosition.top].
  final OverlayAnchorPosition overlayAnchorPosition;

  /// The semantic label for the overlay.
  final String? semanticLabel;

  /// The callback that is called when the [child] of the overlay is tapped.
  final VoidCallback? onTap;

  /// The callback that is called when the area outside of the overlay's [target]
  /// and [child] is tapped.
  final VoidCallback? onTapOutside;

  /// The widget to display as the target of the overlay.
  final Widget target;

  /// The child widget to display inside the overlay as its content.
  final Widget child;

  /// Creates a Moon Design raw overlay.
  const MoonBaseOverlay({
    super.key,
    required this.show,
    this.allowMultipleOverlays = false,
    this.hideOnTap = false,
    this.distanceToTarget = 8.0,
    this.overlayMargin = 8.0,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.overlayAnchorPosition = OverlayAnchorPosition.top,
    this.semanticLabel,
    this.onTap,
    this.onTapOutside,
    required this.target,
    required this.child,
  });

  // Clear existing overlays, excluding the current one.
  static void _removeOtherOverLays(MoonBaseOverlayState current) {
    if (_openedOverlays.isNotEmpty) {
      final List<MoonBaseOverlayState> openedOverlays =
          _openedOverlays.toList();

      for (final MoonBaseOverlayState state in openedOverlays) {
        if (state == current) continue;

        state._overlayController.hide();
        state._isVisible = false;

        state._clearOverlayEntry();
      }
    }
  }

  @override
  MoonBaseOverlayState createState() => MoonBaseOverlayState();
}

class MoonBaseOverlayState extends State<MoonBaseOverlay>
    with RouteAware, SingleTickerProviderStateMixin, OverlayPositionResolver {
  late final ObjectKey _regionKey = ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final OverlayPortalController _overlayController = OverlayPortalController();

  bool _isVisible = false;

  _OverlayPositionProperties _getOverlayPositionParameters() {
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset overlayTargetGlobalLeft = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerLeft(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset overlayTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset overlayTargetGlobalRight = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerRight(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final OverlayAnchorPosition overlayPosition = getResolvedOverlayPosition(
      context,
      targetRenderBox,
      widget.overlayAnchorPosition,
    );

    return _resolveOverlayPositionParameters(
      overlayPosition: overlayPosition,
      distanceToTarget: widget.distanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      overlayTargetGlobalLeft: overlayTargetGlobalLeft.dx,
      overlayTargetGlobalCenter: overlayTargetGlobalCenter.dx,
      overlayTargetGlobalRight: overlayTargetGlobalRight.dx,
    );
  }

  _OverlayPositionProperties _resolveOverlayPositionParameters({
    required OverlayAnchorPosition overlayPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double overlayTargetGlobalLeft,
    required double overlayTargetGlobalCenter,
    required double overlayTargetGlobalRight,
  }) {
    return switch (overlayPosition) {
      OverlayAnchorPosition.top => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          overlayMaxWidth: overlayWidth -
              ((overlayWidth / 2 - overlayTargetGlobalCenter) * 2).abs() -
              widget.overlayMargin * 2,
        ),
      OverlayAnchorPosition.bottom => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          overlayMaxWidth: overlayWidth -
              ((overlayWidth / 2 - overlayTargetGlobalCenter) * 2).abs() -
              widget.overlayMargin * 2,
        ),
      OverlayAnchorPosition.left => _OverlayPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          overlayMaxWidth: max(
            0,
            overlayTargetGlobalLeft - distanceToTarget - widget.overlayMargin,
          ),
        ),
      OverlayAnchorPosition.right => _OverlayPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          overlayMaxWidth: max(
            0,
            overlayWidth -
                overlayTargetGlobalRight -
                distanceToTarget -
                widget.overlayMargin,
          ),
        ),
      OverlayAnchorPosition.topLeft => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
        ),
      OverlayAnchorPosition.topRight => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      OverlayAnchorPosition.bottomLeft => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
        ),
      OverlayAnchorPosition.bottomRight => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      _ => throw AssertionError("No match: $overlayPosition"),
    };
  }

  void _clearOverlayEntry() => MoonBaseOverlay._openedOverlays.remove(this);

  void _changeVisibility() => _isVisible ? _showOverlay() : _hideOverlay();

  void _hideOnTap() {
    if (widget.hideOnTap && _isVisible) _hideOverlay();
  }

  void _showOverlay() {
    if (!mounted) return;

    _animationController.stop();

    Future.microtask(() {
      MoonBaseOverlay._openedOverlays.add(this);

      if (!widget.allowMultipleOverlays) {
        MoonBaseOverlay._removeOtherOverLays(this);
      }

      _overlayController.show();
      _animationController.forward();
    });
  }

  void _hideOverlay() {
    if (!mounted) return;

    _clearOverlayEntry();

    _animationController.reverse().then((_) {
      _overlayController.hide();
      _isVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.transitionCurve,
    );

    _isVisible = widget.show;

    if (widget.show) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    }
  }

  @override
  void didUpdateWidget(MoonBaseOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show != oldWidget.show || widget.show != _isVisible) {
      _isVisible = !_isVisible;

      _changeVisibility();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    MoonBaseOverlay._openedOverlays.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () {
            _isVisible = false;
            _changeVisibility();
          },
        },
        child: TapRegion(
          groupId: _regionKey,
          behavior: HitTestBehavior.translucent,
          child: FocusTraversalOrder(
            order: const NumericFocusOrder(0),
            child: CompositedTransformTarget(
              link: _layerLink,
              child: OverlayPortal.targetsRootOverlay(
                controller: _overlayController,
                overlayChildBuilder: (BuildContext context) {
                  final overlayPositionParameters =
                      _getOverlayPositionParameters();

                  return Semantics(
                    label: widget.semanticLabel,
                    child: UnconstrainedBox(
                      child: FocusTraversalOrder(
                        order: const NumericFocusOrder(1),
                        child: CompositedTransformFollower(
                          link: _layerLink,
                          showWhenUnlinked: false,
                          offset: overlayPositionParameters.offset,
                          followerAnchor:
                              overlayPositionParameters.followerAnchor,
                          targetAnchor: overlayPositionParameters.targetAnchor,
                          child: TapRegion(
                            groupId: _regionKey,
                            behavior: HitTestBehavior.translucent,
                            onTapOutside: (PointerDownEvent _) {
                              _hideOnTap();
                              widget.onTapOutside?.call();
                            },
                            child: GestureDetector(
                              excludeFromSemantics: true,
                              behavior: HitTestBehavior.translucent,
                              onTapDown: (TapDownDetails details) {
                                _hideOnTap();
                                widget.onTap?.call();
                              },
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      overlayPositionParameters.overlayMaxWidth,
                                ),
                                child: RepaintBoundary(
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Directionality(
                                      textDirection: Directionality.of(context),
                                      child: widget.child,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: widget.target,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OverlayPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double overlayMaxWidth;
  final Offset offset;

  _OverlayPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.overlayMaxWidth,
    required this.offset,
  });
}
