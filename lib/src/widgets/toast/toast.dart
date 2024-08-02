import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

class MoonRawToast {
  static const double _toastTravelDistance = 64.0;
  static const Duration _timeBetweenToasts = Duration(milliseconds: 200);

  static final _toastQueue = <_ToastEntry>[];

  static Timer? _timer;
  static OverlayEntry? _entry;

  /// Creates a Moon Design raw toast.
  const MoonRawToast();

  /// Displays a Moon Design raw toast.
  static void show(
    BuildContext context, {
    /// The style of the toast container.
    Style? style,

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

    final OverlayEntry entry = OverlayEntry(
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
                style: Style(
                  $with.opacity(progress),
                  $with.align(alignment: toastAlignment),
                  $with.transform(
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
                        _ => 0
                      },
                      switch (toastAlignment) {
                        Alignment.topCenter => -_toastTravelDistance +
                            progress * _toastTravelDistance,
                        Alignment.bottomCenter =>
                          (1 - progress) * _toastTravelDistance,
                        _ => 0
                      },
                      0,
                    ),
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
                style: style,
                child: child,
              ),
            ),
          ),
        );
      },
    );

    final _ToastEntry toastEntry =
        _ToastEntry(buildContext: effectiveContext, overlayEntry: entry);

    _toastQueue.add(toastEntry);

    if (_timer == null) _showAndRemoveToastOverlay(duration: displayDuration);
  }

  /// Clear the toast queue.
  static void clearToastQueue() {
    _timer?.cancel();
    _timer = null;

    if (_entry == null) return;

    _entry?.remove();
    _entry = null;

    _toastQueue.clear();
  }

  /// Show and remove the toast overlay.
  static void _showAndRemoveToastOverlay({required Duration duration}) {
    if (_toastQueue.isEmpty) {
      _entry = null;
      return;
    }

    final toastEntry = _toastQueue.removeAt(0);

    if (!toastEntry.buildContext.mounted) {
      clearToastQueue();
      return;
    }

    _entry = toastEntry.overlayEntry;
    _timer = Timer(duration, () {
      _timer?.cancel();
      _timer = null;

      _entry?.remove();
      _entry = null;

      _showAndRemoveToastOverlay(duration: duration);
    });

    Future.delayed(
      _timeBetweenToasts,
      () => Navigator.of(toastEntry.buildContext).overlay?.insert(_entry!),
    );
  }
}

class _ToastEntry {
  final BuildContext buildContext;
  final OverlayEntry overlayEntry;

  _ToastEntry({required this.buildContext, required this.overlayEntry});
}
