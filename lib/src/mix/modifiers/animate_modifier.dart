import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mix/mix.dart';

/// A modifier that wraps a widget with the [Animate] widget from flutter_animate.
final class AnimateModifierSpec
    extends WidgetModifierSpec<AnimateModifierSpec> {
  final Adapter? adapter;
  final bool? autoPlay;
  final AnimationController? controller;
  final Duration? delay;
  final List<Effect<dynamic>>? effects;
  final void Function(AnimationController)? onComplete;
  final void Function(AnimationController)? onInit;
  final void Function(AnimationController)? onPlay;
  final double? target;
  final double? value;

  const AnimateModifierSpec({
    this.adapter,
    this.autoPlay,
    this.controller,
    this.delay,
    this.effects,
    this.onComplete,
    this.onInit,
    this.onPlay,
    this.target,
    this.value,
  });

  @override
  AnimateModifierSpec lerp(
    AnimateModifierSpec? other,
    double t,
  ) {
    // TODO: these lerp values need to be reviewed at later date
    return AnimateModifierSpec(
      adapter: t < 0.5 ? adapter : other?.adapter,
      autoPlay: t < 0.5 ? autoPlay : other?.autoPlay,
      controller: t < 0.5 ? controller : other?.controller,
      delay: t < 0.5 ? delay : other?.delay,
      effects: t < 0.5 ? effects : other?.effects,
      onComplete: t < 0.5 ? onComplete : other?.onComplete,
      onInit: t < 0.5 ? onInit : other?.onInit,
      onPlay: t < 0.5 ? onPlay : other?.onPlay,
      target: t < 0.5 ? target : other?.target,
      value: t < 0.5 ? value : other?.value,
    );
  }

  @override
  AnimateModifierSpec copyWith({
    Adapter? adapter,
    bool? autoPlay,
    AnimationController? controller,
    Duration? delay,
    List<Effect<dynamic>>? effects,
    void Function(AnimationController)? onComplete,
    void Function(AnimationController)? onInit,
    void Function(AnimationController)? onPlay,
    double? target,
    double? value,
  }) {
    return AnimateModifierSpec(
      adapter: adapter ?? this.adapter,
      autoPlay: autoPlay ?? this.autoPlay,
      controller: controller ?? this.controller,
      delay: delay ?? this.delay,
      effects: effects ?? this.effects,
      onComplete: onComplete ?? this.onComplete,
      onInit: onInit ?? this.onInit,
      onPlay: onPlay ?? this.onPlay,
      target: target ?? this.target,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [
        adapter,
        autoPlay,
        controller,
        delay,
        effects,
        onComplete,
        onInit,
        onPlay,
        target,
        value,
      ];

  @override
  Widget build(Widget child) {
    return Animate(
      adapter: adapter,
      autoPlay: autoPlay,
      controller: controller,
      delay: delay,
      effects: effects,
      onComplete: onComplete,
      onInit: onInit,
      onPlay: onPlay,
      target: target,
      value: value,
      child: child,
    );
  }
}

final class AnimateModifierSpecAttribute
    extends WidgetModifierSpecAttribute<AnimateModifierSpec> {
  final Adapter? adapter;
  final bool? autoPlay;
  final AnimationController? controller;
  final Duration? delay;
  final List<Effect<dynamic>>? effects;
  final void Function(AnimationController)? onComplete;
  final void Function(AnimationController)? onInit;
  final void Function(AnimationController)? onPlay;
  final double? target;
  final double? value;

  const AnimateModifierSpecAttribute({
    this.adapter,
    this.autoPlay = true,
    this.controller,
    this.delay,
    this.effects,
    this.onComplete,
    this.onInit,
    this.onPlay,
    this.target,
    this.value,
  });

  @override
  AnimateModifierSpecAttribute merge(
    AnimateModifierSpecAttribute? other,
  ) {
    if (other == null) return this;

    return AnimateModifierSpecAttribute(
      adapter: other.adapter ?? adapter,
      autoPlay: other.autoPlay ?? autoPlay,
      controller: other.controller ?? controller,
      delay: other.delay ?? delay,
      effects: other.effects ?? effects,
      onComplete: other.onComplete ?? onComplete,
      onInit: other.onInit ?? onInit,
      onPlay: other.onPlay ?? onPlay,
      target: other.target ?? target,
      value: other.value ?? value,
    );
  }

  @override
  AnimateModifierSpec resolve(MixData mix) {
    return AnimateModifierSpec(
      adapter: adapter,
      autoPlay: autoPlay,
      controller: controller,
      delay: delay,
      effects: effects,
      onComplete: onComplete,
      onInit: onInit,
      onPlay: onPlay,
      target: target,
      value: value,
    );
  }

  @override
  List<Object?> get props => [
        adapter,
        autoPlay,
        controller,
        delay,
        effects,
        onComplete,
        onInit,
        onPlay,
        target,
        value,
      ];
}

final class AnimateModifierSpecUtility<T extends Attribute>
    extends MixUtility<T, AnimateModifierSpecAttribute> {
  const AnimateModifierSpecUtility(super.builder);
  T call({
    Adapter? adapter,
    bool? autoPlay,
    AnimationController? controller,
    Duration? delay,
    List<Effect<dynamic>>? effects,
    void Function(AnimationController)? onComplete,
    void Function(AnimationController)? onInit,
    void Function(AnimationController)? onPlay,
    double? target,
    double? value,
  }) {
    return builder(
      AnimateModifierSpecAttribute(
        adapter: adapter,
        autoPlay: autoPlay,
        controller: controller,
        delay: delay,
        effects: effects,
        onComplete: onComplete,
        onInit: onInit,
        onPlay: onPlay,
        target: target,
        value: value,
      ),
    );
  }
}
