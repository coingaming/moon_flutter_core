import 'package:flutter/material.dart';

/// Displays a modal overlay with entrance/exit animations, barrier color,
/// and behavior. Allows dismissing the dialog by tapping on the barrier.
Future<T?> showMoonRawModal<T>({
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  Color barrierColor = Colors.black54,
  Curve transitionCurve = Curves.easeInOutCubic,
  Duration transitionDuration = const Duration(milliseconds: 200),
  String? barrierLabel,
  RouteSettings? routeSettings,
  RouteTransitionsBuilder? customTransitionBuilder,
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  assert(_debugIsActive(context));

  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context, rootNavigator: useRootNavigator).context,
  );

  final String effectiveBarrierLabel = barrierLabel ??
      MaterialLocalizations.of(context).modalBarrierDismissLabel;

  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
    _MoonRawModalRoute<T>(
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      barrierColor: barrierColor,
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
      barrierLabel: effectiveBarrierLabel,
      settings: routeSettings,
      themes: themes,
      customTransitionBuilder: customTransitionBuilder,
      builder: builder,
    ),
  );
}

bool _debugIsActive(BuildContext context) {
  if (context is Element && !context.debugIsActive) {
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('This BuildContext is no longer valid.'),
      ErrorDescription(
        'The BuildContext passed to showMoonRawModal is no longer valid.',
      ),
      ErrorHint(
        'This often happens when showMoonRawModal is called after awaiting a '
        'Future, causing the BuildContext to refer to a disposed widget. Use a '
        'parent context instead.',
      ),
    ]);
  }
  return true;
}

class _MoonRawModalRoute<T> extends RawDialogRoute<T> {
  /// A Moon Design raw modal route with entrance and exit animations, modal
  /// barrier color, and dismissal functionality.
  _MoonRawModalRoute({
    super.barrierDismissible,
    required bool useSafeArea,
    CapturedThemes? themes,
    required super.barrierColor,
    required Curve transitionCurve,
    required super.transitionDuration,
    super.settings,
    super.barrierLabel,
    RouteTransitionsBuilder? customTransitionBuilder,
    required WidgetBuilder builder,
  }) : super(
          pageBuilder: (_, __, ___) {
            Widget modal = Builder(builder: builder);
            if (themes != null) modal = themes.wrap(modal);
            if (useSafeArea) modal = SafeArea(child: modal);

            return modal;
          },
          transitionBuilder: customTransitionBuilder ??
              (_, Animation<double> animation, __, Widget child) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: transitionCurve,
                  ),
                  child: child,
                );
              },
        );
}
