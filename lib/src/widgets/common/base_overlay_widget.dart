import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum OverlayPosition {
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
  OverlayPosition getResolvedOverlayPosition(
    BuildContext context,
    RenderBox targetRenderBox,
    OverlayPosition tooltipAnchorPosition,
  ) {
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final Offset overlayTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    OverlayPosition overlayPosition = tooltipAnchorPosition;

    if (Directionality.of(context) == TextDirection.rtl ||
        overlayPosition == OverlayPosition.horizontal ||
        overlayPosition == OverlayPosition.vertical) {
      overlayPosition = switch (overlayPosition) {
        OverlayPosition.left => OverlayPosition.right,
        OverlayPosition.right => OverlayPosition.left,
        OverlayPosition.topLeft => OverlayPosition.topRight,
        OverlayPosition.topRight => OverlayPosition.topLeft,
        OverlayPosition.bottomLeft => OverlayPosition.bottomRight,
        OverlayPosition.bottomRight => OverlayPosition.bottomLeft,
        OverlayPosition.vertical => overlayTargetGlobalCenter.dy <
                overlayRenderBox.size.center(Offset.zero).dy
            ? OverlayPosition.bottom
            : OverlayPosition.top,
        OverlayPosition.horizontal => overlayTargetGlobalCenter.dx <
                overlayRenderBox.size.center(Offset.zero).dx
            ? OverlayPosition.right
            : OverlayPosition.left,
        _ => overlayPosition,
      };
    }

    return overlayPosition;
  }
}

class MoonBaseOverlay extends StatefulWidget {
  /// Controls whether to show the overlay.
  final bool show;

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
  /// Defaults to [OverlayPosition.top].
  final OverlayPosition overlayAnchorPosition;

  /// The semantic label for the overlay.
  final String? semanticLabel;

  /// The callback that is called when the [child] of the overlay is tapped.
  final VoidCallback? onTap;

  /// The callback that is called when the area outside of the overlay's [child]
  /// is tapped.
  final VoidCallback? onTapOutside;

  /// The callback that is called when the [target] of the overlay is hovered.
  final VoidCallback? onTargetHover;

  /// The widget to display as the target of the overlay.
  final Widget target;

  /// The child widget to display inside the overlay as its content.
  final Widget child;

  /// Creates a Moon Design raw overlay.
  const MoonBaseOverlay({
    super.key,
    required this.show,
    this.distanceToTarget = 8.0,
    this.overlayMargin = 8.0,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.overlayAnchorPosition = OverlayPosition.top,
    this.semanticLabel,
    this.onTap,
    this.onTapOutside,
    this.onTargetHover,
    required this.target,
    required this.child,
  });

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

    final OverlayPosition overlayPosition = getResolvedOverlayPosition(
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
    required OverlayPosition overlayPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double overlayTargetGlobalLeft,
    required double overlayTargetGlobalCenter,
    required double overlayTargetGlobalRight,
  }) {
    final double screenSize = MediaQuery.of(context).size.width;

    return switch (overlayPosition) {
      OverlayPosition.top => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          overlayMaxWidth: screenSize - 2 * widget.overlayMargin,
        ),
      OverlayPosition.bottom => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          overlayMaxWidth: screenSize - 2 * widget.overlayMargin,
        ),
      OverlayPosition.left => _OverlayPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          overlayMaxWidth:
              overlayTargetGlobalLeft - distanceToTarget - widget.overlayMargin,
        ),
      OverlayPosition.right => _OverlayPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          overlayMaxWidth: overlayWidth -
              overlayTargetGlobalRight -
              distanceToTarget -
              widget.overlayMargin,
        ),
      OverlayPosition.topLeft => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
        ),
      OverlayPosition.topRight => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      OverlayPosition.bottomLeft => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
        ),
      OverlayPosition.bottomRight => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      _ => throw AssertionError("No match: $overlayPosition"),
    };
  }

  void _showOverlay() {
    _animationController.stop();

    Future.microtask(() {
      _overlayController.show();
      _animationController.forward();
    });
  }

  void _hideOverlay() {
    _animationController.reverse().then((_) => _overlayController.hide());
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

    if (widget.show) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    }
  }

  @override
  void didUpdateWidget(MoonBaseOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show != oldWidget.show) {
      _overlayController.isShowing ? _hideOverlay() : _showOverlay();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () {
            setState(() => _overlayController.hide());
          },
        },
        child: TapRegion(
          groupId: _regionKey,
          behavior: HitTestBehavior.translucent,
          child: MouseRegion(
            onEnter: (_) => widget.onTargetHover?.call(),
            onExit: (_) => widget.onTargetHover?.call(),
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
                            targetAnchor:
                                overlayPositionParameters.targetAnchor,
                            child: TapRegion(
                              groupId: _regionKey,
                              behavior: HitTestBehavior.opaque,
                              onTapOutside: (PointerDownEvent _) {
                                widget.onTapOutside?.call();
                              },
                              child: GestureDetector(
                                excludeFromSemantics: true,
                                behavior: HitTestBehavior.opaque,
                                onTap: widget.onTap,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: overlayPositionParameters
                                        .overlayMaxWidth,
                                  ),
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
                    );
                  },
                  child: widget.target,
                ),
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
