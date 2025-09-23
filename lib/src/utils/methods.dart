import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

BoxMix decorationToAttribute(Decoration decoration) {
  if (decoration is BoxDecoration) {
    return BoxMix(decoration: BoxDecorationMix.value(decoration));
  } else if (decoration is ShapeDecoration) {
    return BoxMix(decoration: ShapeDecorationMix.value(decoration));
  } else {
    return BoxMix(decoration: BoxDecorationMix());
  }
}
