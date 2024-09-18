import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

const _delayDuration = Duration(seconds: 3);
const _animationDuration = Duration(milliseconds: 800);
const _animationCurve = Curves.fastOutSlowIn;

class MoonRawCarousel extends StatefulWidget {
  /// The axis direction in which the carousel scrolls.
  final Axis axisDirection;

  /// Whether to enable the automatic scrolling for the carousel.
  final bool autoPlay;

  /// Whether to align the selected carousel item to the center of the viewport.
  /// When set to true, the [anchor] property is ignored.
  final bool isCentered;

  /// Limits 'maxExtent' proportionally based on [anchor], making the carousel
  /// behave like a [ListView] and keeping the last item(s) unreachable for
  /// [onIndexChanged].
  final bool clampMaxExtent;

  /// Whether to enable infinite loop for the carousel items.
  final bool loop;

  /// Positions the selected item in the viewport, ranging from 0 (start) to
  /// 1 (end). Ignored if [isCentered] is true.
  final double anchor;

  /// The gap between the carousel items.
  final double gap;

  /// The maximum width for each carousel item in the viewport.
  final double itemExtent;

  /// The factor to adjust and multiply the velocity of carousel scrolling.
  final double velocityFactor;

  /// The delay between the items in the carousel's automatic scrolling sequence.
  final Duration autoPlayDelay;

  /// The duration of the MoonCarousel [autoplay] transition animation.
  final Duration transitionDuration;

  /// The curve of the MoonCarousel [autoplay] transition animation.
  final Curve transitionCurve;

  /// The total number of items to build for the carousel.
  final int itemCount;

  /// The [ScrollController] used to control the carousel.
  final ScrollController? controller;

  /// The carousel's scroll physics.
  ///
  /// Defaults to [MoonCarouselScrollPhysics], which ensures landing on
  /// a specific item after scrolling.
  final ScrollPhysics? physics;

  /// The custom scroll behavior for the carousel.
  final ScrollBehavior? scrollBehavior;

  /// The callback that is called when the carousel item index has changed.
  final void Function(int index)? onIndexChanged;

  /// Builds carousel items lazily within the viewport.
  ///
  /// With [loop] false, 'itemIndex' matches 'realIndex' (the element index).
  ///
  /// With [loop] true, two indexes are exposed by the 'itemBuilder'. The first
  /// 'itemIndex' is modded (e.g., position(11) = 1, 'position(-1) = 9'), while
  /// 'realIndex' shows the actual index (e.g., [..., -2, -1, 0, 1, 2, ...]).
  /// The 'realIndex' supports 'jumpToItem' for direct item access.

  final Widget Function(BuildContext context, int itemIndex, int realIndex)
      itemBuilder;

  /// Creates a Moon Design raw carousel.
  const MoonRawCarousel({
    super.key,
    this.axisDirection = Axis.horizontal,
    this.autoPlay = false,
    this.isCentered = true,
    this.clampMaxExtent = false,
    this.loop = false,
    this.anchor = 0.0,
    this.gap = 8.0,
    required this.itemExtent,
    this.velocityFactor = 0.5,
    this.autoPlayDelay = _delayDuration,
    this.transitionDuration = _animationDuration,
    this.transitionCurve = _animationCurve,
    required this.itemCount,
    this.controller,
    this.physics,
    this.scrollBehavior,
    this.onIndexChanged,
    required this.itemBuilder,
  })  : assert(itemExtent > 0),
        assert(itemCount > 0),
        assert(velocityFactor > 0.0 && velocityFactor <= 1.0);

  @override
  State<MoonRawCarousel> createState() => _MoonRawCarouselState();
}

class _MoonRawCarouselState extends State<MoonRawCarousel> {
  late int _lastReportedItemIndex;
  late MoonCarouselScrollController _scrollController;

  final Key _forwardListKey = const ValueKey<String>("moon_carousel_key");

  bool get _isHorizontal => widget.axisDirection == Axis.horizontal;

  double get _effectiveGap => widget.gap;

  // Computes the viewport anchor to center the selected item when 'isCentered'.
  double _getCenteredAnchor(BoxConstraints constraints) {
    if (!widget.isCentered) return widget.anchor;

    final maxExtent =
        _isHorizontal ? constraints.maxWidth : constraints.maxHeight;

    return ((maxExtent / 2) - (widget.itemExtent / 2)) / maxExtent;
  }

  // Checks if carousel content exceeds viewport width to decide on clamping.
  bool _clampMaxExtent(double viewportWidth) {
    final double itemsWidth = widget.itemCount * widget.itemExtent;
    final double gapWidth = (widget.itemCount - 1) * _effectiveGap;
    final double anchor = viewportWidth * widget.anchor * 2;
    final double totalWidth = itemsWidth + gapWidth + anchor;

    return totalWidth >= viewportWidth && widget.clampMaxExtent;
  }

  AxisDirection _getDirection(BuildContext context) {
    if (_isHorizontal) {
      assert(debugCheckHasDirectionality(context));

      return textDirectionToAxisDirection(Directionality.of(context));
    }

    return AxisDirection.down;
  }

  void _startAutoplay() {
    _scrollController.startAutoPlay(
      delay: widget.autoPlayDelay,
      duration: widget.transitionDuration,
      curve: widget.transitionCurve,
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController = (widget.controller as MoonCarouselScrollController?) ??
        MoonCarouselScrollController();

    _lastReportedItemIndex = _scrollController.initialItem;

    if (widget.autoPlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoplay());
    }
  }

  @override
  void didUpdateWidget(MoonRawCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.autoPlay != oldWidget.autoPlay) {
      widget.autoPlay ? _startAutoplay() : _scrollController.stopAutoplay();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _scrollController.dispose();

    super.dispose();
  }

  List<Widget> _buildSlivers(
    BuildContext context,
    AxisDirection axisDirection,
  ) {
    final EdgeInsetsDirectional resolvedPadding = _isHorizontal
        ? EdgeInsetsDirectional.only(end: _effectiveGap)
        : EdgeInsetsDirectional.only(bottom: _effectiveGap);

    SliverChildDelegate buildDelegate(bool forward) =>
        SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: resolvedPadding,
              child: widget.itemBuilder(
                context,
                forward
                    ? index.abs() % widget.itemCount
                    : widget.itemCount - (index.abs() % widget.itemCount) - 1,
                forward ? index : -(index + 1),
              ),
            );
          },
          childCount: widget.loop ? null : widget.itemCount,
        );

    return List.generate(
      widget.loop ? 2 : 1,
      (int index) => SliverFixedExtentList(
        key: index == 0 ? _forwardListKey : null,
        delegate: buildDelegate(index == 0),
        itemExtent: widget.itemExtent + _effectiveGap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);

    final ScrollBehavior effectiveScrollBehavior = widget.scrollBehavior ??
        ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        );

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification notification) {
        final int currentItem =
            (notification.metrics as MoonCarouselExtentMetrics).itemIndex;

        if (currentItem != _lastReportedItemIndex) {
          _lastReportedItemIndex = currentItem;

          final int trueIndex =
              _getTrueIndex(_lastReportedItemIndex, widget.itemCount);

          widget.onIndexChanged?.call(trueIndex);
        }

        return false;
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double centeredAnchor = _getCenteredAnchor(constraints);
          final bool clampMaxExtent = _clampMaxExtent(constraints.maxWidth);

          return OverflowBox(
            maxWidth: constraints.maxWidth,
            child: _MoonCarouselScrollable(
              anchor: centeredAnchor,
              axisDirection: axisDirection,
              controller: _scrollController,
              clampMaxExtent: clampMaxExtent,
              gap: _effectiveGap,
              itemCount: widget.itemCount,
              itemExtent: widget.itemExtent + _effectiveGap,
              loop: widget.loop,
              physics: widget.physics ?? const MoonCarouselScrollPhysics(),
              scrollBehavior: effectiveScrollBehavior,
              velocityFactor: widget.velocityFactor,
              viewportBuilder: (BuildContext context, ViewportOffset position) {
                return Viewport(
                  offset: position,
                  anchor: centeredAnchor,
                  center: _forwardListKey,
                  axisDirection: axisDirection,
                  slivers: _buildSlivers(context, axisDirection),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Extends Scrollable to include viewport's itemExtent, itemCount, loop, and
/// other values, allowing ScrollPosition and Physics to access them directly
/// from the scroll context.
class _MoonCarouselScrollable extends Scrollable {
  final bool clampMaxExtent;
  final bool loop;
  final double anchor;
  final double gap;
  final double itemExtent;
  final double velocityFactor;
  final int itemCount;

  const _MoonCarouselScrollable({
    super.axisDirection = AxisDirection.right,
    super.controller,
    super.physics,
    super.scrollBehavior,
    required super.viewportBuilder,
    required this.clampMaxExtent,
    required this.loop,
    required this.anchor,
    required this.gap,
    required this.itemExtent,
    required this.velocityFactor,
    required this.itemCount,
  });

  @override
  _MoonCarouselScrollableState createState() => _MoonCarouselScrollableState();
}

class _MoonCarouselScrollableState extends ScrollableState {
  bool get clampMaxExtent => (widget as _MoonCarouselScrollable).clampMaxExtent;

  bool get loop => (widget as _MoonCarouselScrollable).loop;

  double get anchor => (widget as _MoonCarouselScrollable).anchor;

  double get gap => (widget as _MoonCarouselScrollable).gap;

  double get itemExtent => (widget as _MoonCarouselScrollable).itemExtent;

  double get velocityFactor =>
      (widget as _MoonCarouselScrollable).velocityFactor;

  int get itemCount => (widget as _MoonCarouselScrollable).itemCount;
}

/// Scroll controller for [MoonRawCarousel].
class MoonCarouselScrollController extends ScrollController {
  /// The initial carousel item index for [MoonCarouselScrollController].
  /// Defaults to '0'.
  final int initialItem;

  /// Scroll controller for [MoonRawCarousel].
  MoonCarouselScrollController({this.initialItem = 0});

  /// Timer for autoplay.
  Timer? _autoplayTimer;

  void startAutoPlay({Duration? delay, Duration? duration, Curve? curve}) {
    _autoplayTimer?.cancel();

    _autoplayTimer = Timer.periodic(delay ?? _delayDuration, (Timer timer) {
      // When the carousel reaches the end, animate it back to the beginning.
      offset >= position.maxScrollExtent && !position.outOfRange
          ? animateToItem(0, duration: duration, curve: curve)
          : nextItem(duration: duration, curve: curve);
    });
  }

  void stopAutoplay() => _autoplayTimer?.cancel();

  @override
  void dispose() {
    stopAutoplay();

    super.dispose();
  }

  /// Returns the index of the currently selected item.
  /// If [MoonRawCarousel.loop] is true it provides the modded index value.
  int get selectedItem => _getTrueIndex(
        (position as _MoonCarouselScrollPosition).itemIndex,
        (position as _MoonCarouselScrollPosition).itemCount,
      );

  Future<void> _animateTo(
    double Function(_MoonCarouselScrollPosition position) targetOffset,
    Duration? duration,
    Curve? curve,
  ) async {
    if (!hasClients) return;

    await Future.wait<void>([
      for (final position in positions.cast<_MoonCarouselScrollPosition>())
        position.animateTo(
          targetOffset(position),
          duration: duration ?? _animationDuration,
          curve: curve ?? _animationCurve,
        ),
    ]);
  }

  /// Animate to the specified item index.
  Future<void> animateToItem(int index, {Duration? duration, Curve? curve}) =>
      _animateTo((position) => index * position.itemExtent, duration, curve);

  /// Jump to the specified item index.
  void jumpToItem(int itemIndex) {
    for (final position in positions.cast<_MoonCarouselScrollPosition>()) {
      position.jumpTo(itemIndex * position.itemExtent);
    }
  }

  /// Animate to the next item in the viewport.
  Future<void> nextItem({Duration? duration, Curve? curve}) =>
      _animateTo((position) => offset + position.itemExtent, duration, curve);

  /// Animate to the previous item in the viewport.
  Future<void> previousItem({Duration? duration, Curve? curve}) =>
      _animateTo((position) => offset - position.itemExtent, duration, curve);

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _MoonCarouselScrollPosition(
      context: context,
      initialItem: initialItem,
      oldPosition: oldPosition,
      physics: physics,
    );
  }
}

/// The metrics for the [MoonCarouselScrollController].
class MoonCarouselExtentMetrics extends FixedScrollMetrics {
  /// The index of the currently selected item within the scroll view.
  final int itemIndex;

  /// Provides an immutable snapshot of current scroll positions in the carousel.
  /// Use [ScrollNotification] to get the selected real item index at any moment.
  MoonCarouselExtentMetrics({
    required super.axisDirection,
    required super.pixels,
    required super.devicePixelRatio,
    required super.minScrollExtent,
    required super.maxScrollExtent,
    required super.viewportDimension,
    required this.itemIndex,
  });

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? pixels,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      pixels: pixels ?? this.pixels,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minScrollExtent: minScrollExtent ??
          (hasContentDimensions ? this.minScrollExtent : 0.0),
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}

int _getItemFromOffset({
  required double itemExtent,
  required double minScrollExtent,
  required double maxScrollExtent,
  required double offset,
}) {
  final offsetInScrollableRange =
      _clipOffsetToScrollableRange(offset, minScrollExtent, maxScrollExtent);

  return (offsetInScrollableRange / itemExtent).round();
}

double _clipOffsetToScrollableRange(
  double offset,
  double minScrollExtent,
  double maxScrollExtent,
) {
  return math.min(math.max(offset, minScrollExtent), maxScrollExtent);
}

// Returns the modded item index from the real index.
int _getTrueIndex(int currentIndex, int totalCount) {
  if (currentIndex >= 0) return currentIndex % totalCount;

  return (totalCount + (currentIndex % totalCount)) % totalCount;
}

class _MoonCarouselScrollPosition extends ScrollPositionWithSingleContext
    implements MoonCarouselExtentMetrics {
  _MoonCarouselScrollPosition({
    required super.physics,
    required super.context,
    required int initialItem,
    super.oldPosition,
  })  : assert(context is _MoonCarouselScrollableState),
        super(
          initialPixels: _getItemExtentFromScrollContext(context) * initialItem,
        );

  double get anchor => _getAnchorFromScrollContext(context);

  static double _getAnchorFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).anchor;

  double get itemExtent => _getItemExtentFromScrollContext(context);

  static double _getItemExtentFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).itemExtent;

  double get gap => _getGapFromScrollContext(context);

  static double _getGapFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).gap;

  int get itemCount => _getItemCountFromScrollContext(context);

  static int _getItemCountFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).itemCount;

  bool get clampMaxExtent => _getDeferMaxExtentFromScrollContext(context);

  static bool _getDeferMaxExtentFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).clampMaxExtent;

  bool get loop => _getLoopFromScrollContext(context);

  static bool _getLoopFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).loop;

  double get velocityFactor => _getVelocityFactorFromScrollContext(context);

  static double _getVelocityFactorFromScrollContext(ScrollContext context) =>
      (context as _MoonCarouselScrollableState).velocityFactor;

  @override
  int get itemIndex {
    return _getItemFromOffset(
      itemExtent: itemExtent,
      minScrollExtent: hasContentDimensions ? minScrollExtent : 0.0,
      maxScrollExtent: maxScrollExtent,
      offset: pixels,
    );
  }

  @override
  double get maxScrollExtent {
    if (loop) {
      return super.hasContentDimensions ? super.maxScrollExtent : 0.0;
    } else if (clampMaxExtent) {
      final itemsToSubtract = viewportDimension ~/ itemExtent;
      final remainderOfViewport = viewportDimension % itemExtent;
      final anchorWhitespaceFactor = viewportDimension * anchor * 2;

      return itemExtent * (itemCount - itemsToSubtract) -
          remainderOfViewport +
          anchorWhitespaceFactor -
          gap;
    }

    return itemExtent * (itemCount - 1);
  }

  @override
  MoonCarouselExtentMetrics copyWith({
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    int? itemIndex,
  }) {
    return MoonCarouselExtentMetrics(
      axisDirection: axisDirection ?? this.axisDirection,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      minScrollExtent: minScrollExtent ??
          (hasContentDimensions ? this.minScrollExtent : 0.0),
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }
}

/// The physics for the [MoonRawCarousel].
class MoonCarouselScrollPhysics extends ScrollPhysics {
  /// Extends [FixedExtentScrollPhysics] for carousel behavior. If
  /// [MoonRawCarousel.loop] is false, friction is applied when scrolling
  /// beyond the viewport, similar to [BouncingScrollPhysics].
  const MoonCarouselScrollPhysics({super.parent});

  @override
  MoonCarouselScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      MoonCarouselScrollPhysics(parent: buildParent(ancestor));

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            '$runtimeType.applyBoundaryConditions() was called redundantly.',
          ),
          ErrorDescription(
            'The new position, $value, matches the current position '
            '${position.pixels} of ${position.runtimeType}. '
            'Apply boundary conditions only if pixels will change.',
          ),
          DiagnosticsProperty<ScrollPhysics>(
            'The physics object in question was',
            this,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
          DiagnosticsProperty<ScrollMetrics>(
            'The position object in question was',
            position,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
        ]);
      }

      return true;
    }());
    final pixels = position.pixels;
    final minScrollExtent = position.minScrollExtent;
    final maxScrollExtent = position.maxScrollExtent;

    if (value < pixels && pixels <= minScrollExtent) {
      return value - pixels; // Under-scroll.
    }
    if (maxScrollExtent <= pixels && pixels < value) {
      return value - pixels; // Overscroll.
    }
    if (value < minScrollExtent && minScrollExtent < pixels) {
      return value - minScrollExtent; // Hit top edge.
    }
    if (pixels < maxScrollExtent && maxScrollExtent < value) {
      return value - maxScrollExtent; // Hit bottom edge.
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final _MoonCarouselScrollPosition metrics =
        position as _MoonCarouselScrollPosition;

    // Scenario 1:
    // If out of bounds, use parent ballistics to return within range.
    if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) ||
        (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // Simulate the carousel's natural fall trajectory without item interference.
    final Simulation? testFrictionSimulation = super.createBallisticSimulation(
      metrics,
      velocity * math.min(metrics.velocityFactor + 0.15, 1.0),
    );

    // Scenario 2:
    // If the trajectory exceeds the scroll extent, use parent ballistics to
    // prevent overshoot.
    if (testFrictionSimulation != null &&
        (testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent ||
            testFrictionSimulation.x(double.infinity) ==
                metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // Find the nearest item for the carousel to settle on based on simulation.
    final int settlingItemIndex = _getItemFromOffset(
      itemExtent: metrics.itemExtent,
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      offset: testFrictionSimulation?.x(double.infinity) ?? metrics.pixels,
    );

    final double settlingPixels = settlingItemIndex * metrics.itemExtent;

    // Scenario 3:
    // No action needed if the carousel is stationary and at the target position.
    final Tolerance tolerance = toleranceFor(metrics);

    if (velocity.abs() < tolerance.velocity &&
        (settlingPixels - metrics.pixels).abs() < tolerance.distance) {
      return null;
    }

    // Scenario 4:
    // Use a spring simulation if low velocity suggests returning to start.
    if (settlingItemIndex == metrics.itemIndex) {
      return SpringSimulation(
        spring,
        metrics.pixels,
        settlingPixels,
        velocity * metrics.velocityFactor,
        tolerance: tolerance,
      );
    }

    // Scenario 5:
    // Use a friction simulation to guide the carousel to the nearest item.
    return FrictionSimulation.through(
      metrics.pixels,
      settlingPixels,
      velocity * metrics.velocityFactor,
      tolerance.velocity * metrics.velocityFactor * velocity.sign,
    );
  }
}
