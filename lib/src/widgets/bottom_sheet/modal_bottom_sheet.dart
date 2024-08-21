import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/bottom_sheet/bottom_sheet.dart';

/// Displays a Moon Design modal bottom sheet.
Future<T?> showMoonModalRawBottomSheet<T>({
  required BuildContext context,
  bool enableDrag = true,
  bool isDismissible = true,
  bool useRootNavigator = false,
  Color barrierColor = Colors.black54,
  double closeProgressThreshold = 0.6,
  Duration transitionDuration = const Duration(milliseconds: 350),
  Curve transitionCurve = const Cubic(0.0, 0.0, 0.2, 1.0),
  RouteSettings? settings,
  String? semanticLabel,
  Style? bottomSheetStyle,
  AnimationController? animationController,
  required WidgetBuilder builder,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final bool hasMaterialLocalizations =
      Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) !=
          null;

  final String barrierLabel = hasMaterialLocalizations
      ? MaterialLocalizations.of(context).modalBarrierDismissLabel
      : '';

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final T? result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(
    MoonModalBottomSheetRoute<T>(
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      themes: themes,
      modalBarrierColor: barrierColor,
      closeProgressThreshold: closeProgressThreshold,
      animationDuration: transitionDuration,
      animationCurve: transitionCurve,
      settings: settings,
      semanticLabel: semanticLabel,
      bottomSheetStyle: bottomSheetStyle,
      barrierLabel: barrierLabel,
      animationController: animationController,
      builder: builder,
    ),
  );

  return result;
}

class MoonModalBottomSheetRoute<T> extends PageRoute<T> {
  final bool enableDrag;
  final bool isDismissible;
  final CapturedThemes? themes;
  final Color modalBarrierColor;
  final double closeProgressThreshold;
  final Duration animationDuration;
  final Curve animationCurve;
  final String? semanticLabel;
  final Style? bottomSheetStyle;
  final AnimationController? animationController;
  final ScrollController? scrollController;
  final WidgetBuilder builder;

  MoonModalBottomSheetRoute({
    super.settings,
    this.enableDrag = true,
    this.isDismissible = true,
    this.themes,
    required this.modalBarrierColor,
    required this.closeProgressThreshold,
    required this.animationDuration,
    required this.animationCurve,
    this.barrierLabel,
    this.semanticLabel,
    this.bottomSheetStyle,
    this.animationController,
    this.scrollController,
    required this.builder,
  });

  AnimationController? _animationController;

  // RoutePopDisposition.pop breaks the bottom sheet drag to close functionality
  // and eventually causes a crash.
  bool get _hasScopedWillPopCallback =>
      popDisposition == RoutePopDisposition.bubble;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  Color get barrierColor => modalBarrierColor;

  @override
  Duration get transitionDuration => animationDuration;

  @override
  final String? barrierLabel;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);

    _animationController = MoonRawBottomSheet.createAnimationController(
      navigator!.overlay!,
      transitionDuration,
    );

    return _animationController!;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) =>
      nextRoute is MoonModalBottomSheetRoute;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      previousRoute is MoonModalBottomSheetRoute || previousRoute is PageRoute;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // By design, the bottom sheet is positioned at the bottom of the viewport
    // and is not affected by the top padding of the MediaQuery.
    final Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      child: _ModalBottomSheet<T>(
        enableDrag: enableDrag,
        closeProgressThreshold: closeProgressThreshold,
        transitionDuration: animationDuration,
        transitionCurve: animationCurve,
        semanticLabel: semanticLabel,
        bottomSheetStyle: bottomSheetStyle,
        animationController: animationController,
        route: this,
      ),
    );

    return themes?.wrap(bottomSheet) ?? bottomSheet;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  final bool enableDrag;
  final double closeProgressThreshold;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final String? semanticLabel;
  final Style? bottomSheetStyle;
  final AnimationController? animationController;
  final MoonModalBottomSheetRoute<T> route;

  const _ModalBottomSheet({
    super.key,
    this.enableDrag = true,
    required this.closeProgressThreshold,
    this.transitionDuration,
    this.transitionCurve,
    this.semanticLabel,
    this.bottomSheetStyle,
    this.animationController,
    required this.route,
  });

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ScrollController? _scrollController;

  String _getRouteLabel() {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        if (Localizations.of<MaterialLocalizations>(
              context,
              MaterialLocalizations,
            ) !=
            null) {
          return MaterialLocalizations.of(context).dialogLabel;
        } else {
          return const DefaultMaterialLocalizations().dialogLabel;
        }
    }
  }

  Future<bool> _handleShouldClose() async {
    final RoutePopDisposition willPop = widget.route.popDisposition;

    return willPop != RoutePopDisposition.doNotPop;
  }

  void _updateController() {
    final Animation<double>? animation = widget.route.animation;

    // Used to relay the state of the bottom sheet internal animation controller.
    if (animation != null) {
      widget.animationController?.value = animation.value;
    }
  }

  @override
  void initState() {
    super.initState();

    widget.route.animation?.addListener(_updateController);
  }

  @override
  void dispose() {
    widget.route.animation?.removeListener(_updateController);
    widget.animationController?.dispose();
    _scrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(widget.route._animationController != null);

    final ScrollController scrollController =
        PrimaryScrollController.maybeOf(context) ??
            (_scrollController ??= ScrollController());

    return PrimaryScrollController(
      controller: scrollController,
      child: Builder(
        builder: (BuildContext context) => AnimatedBuilder(
          animation: widget.route._animationController!,
          builder: (BuildContext context, Widget? child) {
            assert(child != null);

            return Semantics(
              explicitChildNodes: true,
              label: _getRouteLabel(),
              namesRoute: true,
              scopesRoute: true,
              child: MoonRawBottomSheet(
                enableDrag: widget.enableDrag,
                closeProgressThreshold: widget.closeProgressThreshold,
                transitionDuration: widget.transitionDuration,
                transitionCurve: widget.transitionCurve,
                semanticLabel: widget.semanticLabel,
                bottomSheetStyle: widget.bottomSheetStyle,
                onClosing: () =>
                    {if (widget.route.isCurrent) Navigator.of(context).pop()},
                shouldClose: widget.route._hasScopedWillPopCallback
                    ? () => _handleShouldClose()
                    : null,
                animationController: widget.route._animationController!,
                scrollController: scrollController,
                child: child!,
              ),
            );
          },
          child: widget.route.builder(context),
        ),
      ),
    );
  }
}
