import 'package:flutter/material.dart';

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

class MoonBaseOverlay extends StatefulWidget {
  /// Controls whether to show the overlay.
  final bool show;

  /// The distance between the overlay and the [target].
  final double distanceToTarget;

  /// The margin around the overlay. Prevents the overlay from touching the
  /// edges of the viewport.
  final double overlayMargin;

  /// The duration of the overlay transition animation (fade in and out).
  final Duration transitionDuration;

  /// The curve of the overlay transition animation (fade in and out).
  final Curve transitionCurve;

  /// Sets the overlay position relative to the [target].
  /// Defaults to [OverlayPosition.top].
  final OverlayPosition overlayPosition;

  /// The semantic label for the overlay.
  final String? semanticLabel;

  /// The callback that is called when the user taps anywhere on the screen.
  final VoidCallback? onTap;

  /// The callback that is called when the user taps outside the overlay.
  final VoidCallback? onTapOutside;

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
    this.overlayPosition = OverlayPosition.top,
    this.semanticLabel,
    this.onTap,
    this.onTapOutside,
    required this.target,
    required this.child,
  });

  @override
  MoonBaseOverlayState createState() => MoonBaseOverlayState();
}

class MoonBaseOverlayState extends State<MoonBaseOverlay>
    with RouteAware, SingleTickerProviderStateMixin {
  late final ObjectKey _regionKey = ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final OverlayPortalController _overlayController = OverlayPortalController();

  _OverlayPositionProperties _getOverlayPositionParameters() {
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset overlayTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset overlayTargetGlobalLeft = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerLeft(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset overlayTargetGlobalRight = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerRight(Offset.zero),
      ancestor: overlayRenderBox,
    );

    OverlayPosition overlayPosition = widget.overlayPosition;

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
    return switch (overlayPosition) {
      OverlayPosition.top => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          overlayMaxWidth: overlayWidth -
              ((overlayWidth / 2 - overlayTargetGlobalCenter) * 2).abs() -
              widget.overlayMargin * 2,
        ),
      OverlayPosition.bottom => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          overlayMaxWidth: overlayWidth -
              ((overlayWidth / 2 - overlayTargetGlobalCenter) * 2).abs() -
              widget.overlayMargin * 2,
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
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      OverlayPosition.topRight => _OverlayPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
        ),
      OverlayPosition.bottomLeft => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          overlayMaxWidth: overlayTargetGlobalRight - widget.overlayMargin,
        ),
      OverlayPosition.bottomRight => _OverlayPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          overlayMaxWidth:
              overlayWidth - overlayTargetGlobalLeft - widget.overlayMargin,
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
      widget.show ? _showOverlay() : _hideOverlay();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: _regionKey,
      behavior: HitTestBehavior.translucent,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: OverlayPortal.targetsRootOverlay(
          controller: _overlayController,
          overlayChildBuilder: (BuildContext context) {
            final overlayPositionParameters = _getOverlayPositionParameters();

            return Semantics(
              label: widget.semanticLabel,
              child: GestureDetector(
                excludeFromSemantics: true,
                onTapDown: (TapDownDetails _) => widget.onTap?.call(),
                child: UnconstrainedBox(
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: overlayPositionParameters.offset,
                    followerAnchor: overlayPositionParameters.followerAnchor,
                    targetAnchor: overlayPositionParameters.targetAnchor,
                    child: TapRegion(
                      groupId: _regionKey,
                      behavior: HitTestBehavior.translucent,
                      onTapOutside: (PointerDownEvent _) {
                        widget.onTapOutside?.call();
                        widget.onTap?.call();
                      },
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
            );
          },
          child: widget.target,
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
