import 'package:flutter/material.dart';

enum MoonPopoverPosition {
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

class MoonRawPopover extends StatefulWidget {
  /// Controls whether to show the popover.
  final bool show;

  /// The distance between the popover and the [target].
  final double distanceToTarget;

  /// The margin around the popover. Prevents the popover from touching the
  /// edges of the viewport.
  final double popoverMargin;

  /// The duration of the popover transition animation (fade in and out).
  final Duration transitionDuration;

  /// The curve of the popover transition animation (fade in and out).
  final Curve transitionCurve;

  /// Sets the popover position relative to the [target].
  /// Defaults to [MoonPopoverPosition.top].
  final MoonPopoverPosition popoverPosition;

  /// The semantic label for the popover.
  final String? semanticLabel;

  /// The callback that is called when the user taps outside the popover.
  final VoidCallback? onTapOutside;

  /// The widget to display as the target of the popover.
  final Widget target;

  /// The child widget to display inside the popover as its content.
  final Widget child;

  /// Creates a Moon Design raw popover.
  const MoonRawPopover({
    super.key,
    required this.show,
    this.distanceToTarget = 8,
    this.popoverMargin = 8,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.popoverPosition = MoonPopoverPosition.top,
    this.semanticLabel,
    this.onTapOutside,
    required this.target,
    required this.child,
  });

  @override
  MoonRawPopoverState createState() => MoonRawPopoverState();
}

class MoonRawPopoverState extends State<MoonRawPopover>
    with RouteAware, SingleTickerProviderStateMixin {
  late final ObjectKey _regionKey = ObjectKey(widget);
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final OverlayPortalController _overlayController = OverlayPortalController();

  _PopoverPositionProperties _getPopoverPositionParameters() {
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final RenderBox targetRenderBox = context.findRenderObject()! as RenderBox;

    final Offset popoverTargetGlobalCenter = targetRenderBox.localToGlobal(
      targetRenderBox.size.center(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset popoverTargetGlobalLeft = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerLeft(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final Offset popoverTargetGlobalRight = targetRenderBox.localToGlobal(
      targetRenderBox.size.centerRight(Offset.zero),
      ancestor: overlayRenderBox,
    );

    final double effectiveDistanceToTarget = widget.distanceToTarget;

    MoonPopoverPosition popoverPosition = widget.popoverPosition;

    if (Directionality.of(context) == TextDirection.rtl ||
        popoverPosition == MoonPopoverPosition.horizontal ||
        popoverPosition == MoonPopoverPosition.vertical) {
      popoverPosition = switch (popoverPosition) {
        MoonPopoverPosition.left => MoonPopoverPosition.right,
        MoonPopoverPosition.right => MoonPopoverPosition.left,
        MoonPopoverPosition.topLeft => MoonPopoverPosition.topRight,
        MoonPopoverPosition.topRight => MoonPopoverPosition.topLeft,
        MoonPopoverPosition.bottomLeft => MoonPopoverPosition.bottomRight,
        MoonPopoverPosition.bottomRight => MoonPopoverPosition.bottomLeft,
        MoonPopoverPosition.vertical => popoverTargetGlobalCenter.dy <
                overlayRenderBox.size.center(Offset.zero).dy
            ? MoonPopoverPosition.bottom
            : MoonPopoverPosition.top,
        MoonPopoverPosition.horizontal => popoverTargetGlobalCenter.dx <
                overlayRenderBox.size.center(Offset.zero).dx
            ? MoonPopoverPosition.right
            : MoonPopoverPosition.left,
        _ => popoverPosition,
      };
    }

    return _resolvePopoverPositionParameters(
      popoverPosition: popoverPosition,
      distanceToTarget: effectiveDistanceToTarget,
      overlayWidth: overlayRenderBox.size.width,
      popoverTargetGlobalLeft: popoverTargetGlobalLeft.dx,
      popoverTargetGlobalCenter: popoverTargetGlobalCenter.dx,
      popoverTargetGlobalRight: popoverTargetGlobalRight.dx,
    );
  }

  _PopoverPositionProperties _resolvePopoverPositionParameters({
    required MoonPopoverPosition popoverPosition,
    required double distanceToTarget,
    required double overlayWidth,
    required double popoverTargetGlobalLeft,
    required double popoverTargetGlobalCenter,
    required double popoverTargetGlobalRight,
  }) {
    return switch (popoverPosition) {
      MoonPopoverPosition.top => _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          popoverMaxWidth: overlayWidth -
              ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() -
              widget.popoverMargin * 2,
        ),
      MoonPopoverPosition.bottom => _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          popoverMaxWidth: overlayWidth -
              ((overlayWidth / 2 - popoverTargetGlobalCenter) * 2).abs() -
              widget.popoverMargin * 2,
        ),
      MoonPopoverPosition.left => _PopoverPositionProperties(
          offset: Offset(-distanceToTarget, 0),
          targetAnchor: Alignment.centerLeft,
          followerAnchor: Alignment.centerRight,
          popoverMaxWidth:
              popoverTargetGlobalLeft - distanceToTarget - widget.popoverMargin,
        ),
      MoonPopoverPosition.right => _PopoverPositionProperties(
          offset: Offset(distanceToTarget, 0),
          targetAnchor: Alignment.centerRight,
          followerAnchor: Alignment.centerLeft,
          popoverMaxWidth: overlayWidth -
              popoverTargetGlobalRight -
              distanceToTarget -
              widget.popoverMargin,
        ),
      MoonPopoverPosition.topLeft => _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          popoverMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        ),
      MoonPopoverPosition.topRight => _PopoverPositionProperties(
          offset: Offset(0, -distanceToTarget),
          targetAnchor: Alignment.topLeft,
          followerAnchor: Alignment.bottomLeft,
          popoverMaxWidth:
              overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        ),
      MoonPopoverPosition.bottomLeft => _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          popoverMaxWidth: popoverTargetGlobalRight - widget.popoverMargin,
        ),
      MoonPopoverPosition.bottomRight => _PopoverPositionProperties(
          offset: Offset(0, distanceToTarget),
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          popoverMaxWidth:
              overlayWidth - popoverTargetGlobalLeft - widget.popoverMargin,
        ),
      _ => throw AssertionError("No match: $popoverPosition"),
    };
  }

  void _showPopover() {
    _animationController.stop();

    Future.microtask(() {
      _overlayController.show();
      _animationController.forward();
    });
  }

  void _hidePopover() {
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
      WidgetsBinding.instance.addPostFrameCallback((_) => _showPopover());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(MoonRawPopover oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.show != oldWidget.show) {
      widget.show ? _showPopover() : _hidePopover();
    }
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
            final popoverPositionParameters = _getPopoverPositionParameters();

            return Semantics(
              label: widget.semanticLabel,
              child: UnconstrainedBox(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: popoverPositionParameters.offset,
                  followerAnchor: popoverPositionParameters.followerAnchor,
                  targetAnchor: popoverPositionParameters.targetAnchor,
                  child: TapRegion(
                    groupId: _regionKey,
                    behavior: HitTestBehavior.translucent,
                    onTapOutside: (PointerDownEvent _) =>
                        widget.onTapOutside?.call(),
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
            );
          },
          child: widget.target,
        ),
      ),
    );
  }
}

class _PopoverPositionProperties {
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final double popoverMaxWidth;
  final Offset offset;

  _PopoverPositionProperties({
    required this.followerAnchor,
    required this.targetAnchor,
    required this.popoverMaxWidth,
    required this.offset,
  });
}
