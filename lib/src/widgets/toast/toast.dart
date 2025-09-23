import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

class MoonRawToast {
  static const double _toastTravelDistance = 64.0;
  static const Duration _timeBetweenToasts = Duration(milliseconds: 200);

  static final List<_ToastEntry> _toastQueue = [];
  static bool _isDisplaying = false;

  /// Creates a Moon Design raw toast.
  const MoonRawToast();

  /// Displays a Moon Design raw toast.
  static void show(
    BuildContext context, {

    /// The style of the toast container.
    BoxStyler? style,

    /// The alignment (position) of the toast.
    AlignmentGeometry toastAlignment = Alignment.bottomCenter,

    /// Whether the toast is persistent (attaches to root navigator).
    bool isPersistent = true,

    /// Whether to use the [SafeArea] for the toast (takes into account notches
    /// and native system bars).
    bool useSafeArea = true,

    /// The duration to display the toast.
    Duration displayDuration = const Duration(seconds: 3),

    /// The duration of the toast transition animation (slide in or out).
    Duration transitionDuration = const Duration(milliseconds: 200),

    /// The curve of the toast transition animation (slide in or out).
    Curve transitionCurve = Curves.easeInOutCubic,

    /// The semantic label for the toast.
    String? semanticLabel,

    /// The primary content of the toast.
    required Widget child,
  }) {
    assert(
      displayDuration > _timeBetweenToasts,
      'The display duration must be greater than the time between toasts (200 ms).',
    );

    final effectiveContext = isPersistent
        ? (Navigator.maybeOf(context, rootNavigator: true)?.context ?? context)
        : context;

    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(effectiveContext).context,
    );

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext _) {
        return TweenAnimationBuilder(
          duration: transitionDuration,
          curve: transitionCurve,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (BuildContext _, double progress, Widget? child) {
            return SafeArea(
              left: useSafeArea,
              top: useSafeArea,
              right: useSafeArea,
              bottom: useSafeArea,
              maintainBottomViewPadding: true,
              child: Box(
                style: BoxStyler()
                    .wrapOpacity(progress)
                    .alignment(toastAlignment)
                    .transform(
                      Matrix4.translationValues(
                        switch (toastAlignment) {
                          Alignment.topLeft ||
                          Alignment.centerLeft ||
                          Alignment.bottomLeft =>
                            -_toastTravelDistance +
                                progress * _toastTravelDistance,
                          Alignment.topRight ||
                          Alignment.centerRight ||
                          Alignment.bottomRight =>
                            (1 - progress) * _toastTravelDistance,
                          _ => 0,
                        },
                        switch (toastAlignment) {
                          Alignment.topCenter =>
                            -_toastTravelDistance +
                                progress * _toastTravelDistance,
                          Alignment.bottomCenter =>
                            (1 - progress) * _toastTravelDistance,
                          _ => 0,
                        },
                        0,
                      ),
                    ),
                child: child,
              ),
            );
          },
          child: themes.wrap(
            Semantics(
              label: semanticLabel,
              child: Box(
                style: style ?? const BoxStyler.create(),
                child: child,
              ),
            ),
          ),
        );
      },
    );

    final _ToastEntry toastEntry = _ToastEntry(
      overlayEntry: overlayEntry,
      context: effectiveContext,
      displayDuration: displayDuration,
    );

    _toastQueue.add(toastEntry);

    if (!_isDisplaying) _processQueue();
  }

  static Future<void> _processQueue() async {
    _isDisplaying = true;

    while (_toastQueue.isNotEmpty) {
      final _ToastEntry toastEntry = _toastQueue.removeAt(0);

      if (!toastEntry.context.mounted) continue;

      Navigator.of(toastEntry.context).overlay?.insert(toastEntry.overlayEntry);

      await Future<void>.delayed(toastEntry.displayDuration);

      toastEntry.overlayEntry.remove();

      await Future<void>.delayed(_timeBetweenToasts);
    }

    _isDisplaying = false;
  }

  static void clearQueue() => _toastQueue.clear();
}

class _ToastEntry {
  final OverlayEntry overlayEntry;
  final BuildContext context;
  final Duration displayDuration;

  _ToastEntry({
    required this.overlayEntry,
    required this.context,
    required this.displayDuration,
  });
}
