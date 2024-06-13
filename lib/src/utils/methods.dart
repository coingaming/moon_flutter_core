import 'package:flutter/material.dart';
import 'package:moon_core/moon_core.dart';

BoxSpecAttribute decorationToAttribute(Decoration decoration) {
  if (decoration is BoxDecoration) {
    return $box.decoration.as(decoration);
  } else if (decoration is ShapeDecoration) {
    return $box.shapeDecoration.as(decoration);
  } else {
    return $box.decoration();
  }
}
