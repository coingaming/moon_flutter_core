import 'package:flutter/material.dart';

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
