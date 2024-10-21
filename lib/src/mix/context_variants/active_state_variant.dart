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
    final ActiveStateVariant? activeState =
        context.dependOnInheritedWidgetOfExactType<ActiveStateVariant>();

    return activeState?.isActive ?? false;
  }

  @override
  bool updateShouldNotify(ActiveStateVariant oldWidget) {
    return isActive != oldWidget.isActive;
  }
}

class ActiveVariant extends ContextVariant {
  const ActiveVariant();

  @override
  bool when(BuildContext context) => ActiveStateVariant.isActiveState(context);
}

extension OnContextVariantUtilityX on OnContextVariantUtility {
  ActiveVariant get active => const ActiveVariant();
}
