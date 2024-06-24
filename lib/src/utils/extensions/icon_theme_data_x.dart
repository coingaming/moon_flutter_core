import 'package:flutter/material.dart';

extension IconThemeDataX on IconThemeData {
  bool get hasAValue =>
      color != null ||
      size != null ||
      shadows != null ||
      fill != null ||
      weight != null ||
      grade != null ||
      opticalSize != null ||
      applyTextScaling != null;
}
