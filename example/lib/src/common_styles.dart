import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

Style getButtonStyle() => Style(
  $box.chain
    ..color(Colors.purple)
    ..borderRadius(8)
    ..padding(8.0, 16.0),
  $text.style.color(Colors.white),
  $icon.color(Colors.white),
).merge(getEffects()).animate();

Style getIconButtonStyle() => Style(
  $box.chain
    ..padding(2)
    ..margin(4),
  $icon.size(20),
  ($on.focus | $on.hover)(
    $box.chain
      ..color(Colors.purple.shade100)
      ..shape.circle(),
  ),
).animate();

Style getEffects() => Style(
  $on.focus(
    $box.shapeDecoration.as(
      ShapeDecorationWithPremultipliedAlpha(
        shape: MoonBorder(
          side: BorderSide(color: Colors.purple.shade100, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  $on.hover($box.color(Colors.purple.shade100)),
).animate();
