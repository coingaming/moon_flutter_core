import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/bottom_sheet/utils/bottom_sheet_custom_scroll_physics.dart';
import 'package:moon_core/src/widgets/bottom_sheet/utils/scroll_to_top_status_bar.dart';

/// The Moon Design raw bottom sheet.
///
/// The MoonRawBottomSheet widget itself is rarely used directly.
/// Instead, prefer to create a modal bottom sheet with
/// [showMoonRawModalBottomSheet].
class MoonRawBottomSheet extends StatefulWidget {
  /// Whether the bottom sheet can be dragged vertically and dismissed by
  /// swiping downwards.
  final bool enableDrag;

  /// The minimum velocity required for the bottom sheet to close when flung.
  final double minFlingVelocity;

  /// The threshold distance that the bottom sheet must be dragged to before it
  /// triggers dismissal.
  final double closeProgressThreshold;

  /// The duration of the bottom sheet transition animation (slide in or out).
  final Duration transitionDuration;

  /// The curve of the bottom sheet transition animation (slide in or out).
  final Curve transitionCurve;

  /// The semantic label for the bottom sheet.
  final String? semanticLabel;

  /// The style of the bottom sheet.
  final Style? bottomSheetStyle;

  /// The callback that is called when the bottom sheet begins the closing
  /// process.
  ///
  /// The bottom sheet may not be fully closed (e.g., due to user interaction)
  /// even after this callback is called. Therefore, this callback may be called
  /// multiple times for the same bottom sheet.
  final void Function() onClosing;

  /// The callback that is called to determine whether the bottom sheet should
  /// close based on user interaction.
  ///
  /// If [shouldClose] is null, it is ignored.
  /// If the return value is true, the bottom sheet closes.
  /// If the return value is false, the bottom sheet remains open.
  ///
  /// If [shouldClose] is not null, the bottom sheet will temporarily
  /// return to its previous position until the function returns a value.
  final Future<bool> Function()? shouldClose;

  /// Controls the animation for the bottom sheet entrance and exit transitions.
  ///
  /// The bottom sheet will manipulate the position of this animation controller.
  final AnimationController animationController;

  /// The scroll controller used to navigate the content within the bottom sheet.
  final ScrollController scrollController;

  /// The widget to display inside the bottom sheet as its content.
  final Widget child;

  /// Creates a Moon Design raw modal bottom sheet.
  const MoonRawBottomSheet({
    super.key,
    this.enableDrag = true,
    this.closeProgressThreshold = 0.6,
    this.minFlingVelocity = 500.0,
    this.transitionDuration = const Duration(milliseconds: 350),
    this.transitionCurve = const Cubic(0.0, 0.0, 0.2, 1.0),
    this.semanticLabel,
    this.bottomSheetStyle,
    required this.onClosing,
    this.shouldClose,
    required this.animationController,
    required this.scrollController,
    required this.child,
  });

  @override
  MoonRawBottomSheetState createState() => MoonRawBottomSheetState();

  /// Creates an [AnimationController] specifically designed for a
  /// [MoonRawBottomSheet.animationController].
  ///
  /// This API serves as a convenient mechanism to create a Material compliant
  /// bottom sheet animation.
  /// If custom animation durations are required, a different animation
  /// controller should be utilized.
  static AnimationController createAnimationController(
    TickerProvider vsync,
    Duration duration,
  ) {
    return AnimationController(
      duration: duration,
      debugLabel: 'MoonBottomSheet',
      vsync: vsync,
    );
  }
}

class MoonRawBottomSheetState extends State<MoonRawBottomSheet>
    with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  // Used in NotificationListener to identify distinct ScrollNotification events
  // before and after the dragging gesture.
  bool _isDragging = false;

  bool _verifyingShouldClose = false;

  Curve? _defaultCurve;

  ParametricCurve<double>? _transitionCurve;

  DateTime? _startTime;

  // The DragGesture detector of the scroll view cannot be directly accessed,
  // therefore a VelocityTracker
  // is used to determine the scroll end velocity when attempting to dismiss the
  // modal via dragging.
  VelocityTracker? _velocityTracker;

  bool get _dismissUnderway =>
      widget.animationController.status == AnimationStatus.reverse;

  bool get _hasReachedCloseThreshold =>
      widget.animationController.value < widget.closeProgressThreshold;

  double? get _childHeight =>
      (_childKey.currentContext?.findRenderObject() as RenderBox?)?.size.height;

  ScrollController get _scrollController => widget.scrollController;

  void _close() {
    _isDragging = false;
    widget.onClosing();
  }

  void _cancelClose() {
    widget.animationController.forward().then((value) {
      if (!widget.animationController.isCompleted) {
        widget.animationController.value = 1;
      }
    });
  }

  FutureOr<bool> _shouldClose() async {
    if (_verifyingShouldClose) return false;
    _verifyingShouldClose = true;

    final bool? result = await widget.shouldClose?.call();
    _verifyingShouldClose = false;

    return result ?? false;
  }

  Future<void> _handleDragUpdate(double primaryDelta) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    _transitionCurve = Curves.linear;

    if (_dismissUnderway) return;
    _isDragging = true;

    final double progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null) {
      _cancelClose();

      final bool canClose = await _shouldClose();

      if (canClose) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    widget.animationController.value -= progress;
  }

  Future<void> _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    if (_dismissUnderway || !_isDragging) return;

    _transitionCurve = Split(
      widget.animationController.value,
      beginCurve: _defaultCurve!,
      endCurve: _defaultCurve!,
    );

    _isDragging = false;

    Future<void> tryClose() async {
      if (widget.shouldClose != null) {
        _cancelClose();

        final bool canClose = await _shouldClose();

        if (canClose) _close();
      } else {
        _close();
      }
    }

    if (velocity > widget.minFlingVelocity) {
      tryClose();
    } else if (_hasReachedCloseThreshold) {
      if (widget.animationController.value > 0.0) {
        widget.animationController.fling(velocity: -1.0);
      }
      tryClose();
    } else {
      _cancelClose();
    }
  }

  void _handleScrollUpdate(ScrollNotification notification) {
    assert(notification.context != null);

    if (!_scrollController.hasClients) return;

    ScrollPosition scrollPosition;

    if (_scrollController.positions.length > 1) {
      scrollPosition = _scrollController.positions.firstWhere(
        (p) => p.isScrollingNotifier.value,
        orElse: () => _scrollController.positions.first,
      );
    } else {
      scrollPosition = _scrollController.position;
    }

    if (scrollPosition.axis == Axis.horizontal) return;

    final bool isScrollReversed =
        scrollPosition.axisDirection == AxisDirection.down;
    final double offset = isScrollReversed
        ? scrollPosition.pixels
        : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      // ClampingScrollPhysics terminates with a ScrollEndNotification that
      // encompasses a DragEndDetails class, while BouncingScrollPhysics and
      // other physics that permit overflow do not provide drag end information.

      // The velocity from DragEndDetails is utilized if accessible.
      if (notification is ScrollEndNotification) {
        final DragEndDetails? dragDetails = notification.dragDetails;

        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;

          return;
        }
      }

      // Otherwise, the velocity is calculated using a VelocityTracker.
      if (_velocityTracker == null) {
        final PointerDeviceKind pointerKind =
            _defaultPointerDeviceKind(context);

        _velocityTracker = VelocityTracker.withKind(pointerKind);
        _startTime = DateTime.now();
      }

      DragUpdateDetails? dragDetails;

      if (notification is ScrollUpdateNotification) {
        dragDetails = notification.dragDetails;
      }

      if (notification is OverscrollNotification) {
        dragDetails = notification.dragDetails;
      }

      if (notification is UserScrollNotification) return;

      assert(_velocityTracker != null);
      assert(_startTime != null);

      final startTime = _startTime!;
      final velocityTracker = _velocityTracker!;

      if (dragDetails != null) {
        final Duration duration = startTime.difference(DateTime.now());

        velocityTracker.addPosition(duration, Offset(0, offset));

        _handleDragUpdate(dragDetails.delta.dy);

        return;
      } else if (_isDragging) {
        final double velocity =
            velocityTracker.getVelocity().pixelsPerSecond.dy;

        _velocityTracker = null;
        _startTime = null;

        _handleDragEnd(velocity);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _defaultCurve = widget.transitionCurve;
    _transitionCurve = _defaultCurve;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollToTopStatusBarHandler(
      scrollController: _scrollController,
      child: AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget? child) {
          assert(child != null);

          final double animationValue =
              _transitionCurve!.transform(widget.animationController.value);

          final draggableChild = widget.enableDrag
              ? KeyedSubtree(
                  key: _childKey,
                  child: GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) =>
                        _handleDragUpdate(details.delta.dy),
                    onVerticalDragEnd: (DragEndDetails details) =>
                        _handleDragEnd(details.primaryVelocity ?? 0),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        _handleScrollUpdate(notification);

                        return false;
                      },
                      child: child!,
                    ),
                  ),
                )
              : child;

          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _ModalBottomSheetLayout(progress: animationValue),
              child: draggableChild,
            ),
          );
        },
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
            scrollbars: false,
            physics: CustomModalScrollPhysics(
              controller: widget.animationController,
              parent: const BouncingScrollPhysics(),
            ),
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: RepaintBoundary(
            child: Semantics(
              label: widget.semanticLabel,
              child: Box(
                style: Style(
                  $box.height(MediaQuery.of(context).size.height * 0.8),
                  $box.color(Colors.white),
                ).merge(widget.bottomSheetStyle),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  final double progress;

  _ModalBottomSheetLayout({required this.progress});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

// Determines the input type of the device's operating system.
// Mobile platforms default to 'touch' input and desktop to 'mouse' input.
// Used with VelocityTracker.
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind _defaultPointerDeviceKind(BuildContext context) {
  return switch (Theme.of(context).platform) {
    TargetPlatform.iOS || TargetPlatform.android => PointerDeviceKind.touch,
    TargetPlatform.fuchsia => PointerDeviceKind.unknown,
    _ => PointerDeviceKind.mouse,
  };
}
