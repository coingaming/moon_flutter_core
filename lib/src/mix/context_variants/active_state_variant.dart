import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

class ActiveStateVariant extends InheritedWidget {
  final bool isActive;

  const ActiveStateVariant({
    super.key,
    required this.isActive,
    required super.child,
  });

  static bool isActiveState(BuildContext context) {
    final ActiveStateVariant? activeState = context
        .dependOnInheritedWidgetOfExactType<ActiveStateVariant>();

    return activeState?.isActive ?? false;
  }

  @override
  bool updateShouldNotify(ActiveStateVariant oldWidget) {
    return isActive != oldWidget.isActive;
  }
}

/// Mix context variant that activates when [ActiveStateVariant.isActive] is true.
const moonActiveContextVariant = ContextVariant(
  'moon.context.active',
  ActiveStateVariant.isActiveState,
);
