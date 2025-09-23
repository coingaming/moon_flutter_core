import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

BoxStyler getButtonStyle() => BoxStyler()
    .padding(
      EdgeInsetsGeometryMix.symmetric(horizontal: 16, vertical: 8),
    )
    .borderRadius(
      BorderRadiusGeometryMix.value(BorderRadius.circular(8)),
    )
    .color(Colors.purple)
    .wrapDefaultTextStyle(TextStyleMix(color: Colors.white))
    .onHovered(BoxStyler().color(Colors.purple.shade600))
    .onFocused(
      BoxStyler().border(
        BorderMix.all(
          BorderSideMix.value(
            BorderSide(color: Colors.purple.shade200, width: 2),
          ),
        ),
      ),
    )
    .animate(AnimationConfig(duration: const Duration(milliseconds: 150)));

BoxStyler getIconButtonStyle() => BoxStyler()
    .padding(EdgeInsetsGeometryMix.all(6))
    .borderRadius(
      BorderRadiusGeometryMix.value(BorderRadius.circular(24)),
    )
    .onHovered(
      BoxStyler().color(Colors.purple.shade100),
    )
    .onFocused(
      BoxStyler().border(
        BorderMix.all(
          BorderSideMix.value(
            BorderSide(color: Colors.purple.shade200, width: 2),
          ),
        ),
      ),
    )
    .animate(AnimationConfig(duration: const Duration(milliseconds: 150)));
