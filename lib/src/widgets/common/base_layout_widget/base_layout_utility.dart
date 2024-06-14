import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec_attribute.dart';

class BaseLayoutUtility<T extends Attribute>
    extends SpecUtility<T, BaseLayoutSpecAttribute> {
  BaseLayoutUtility(super.builder);

  @override
  T only({
    AnimatedDataDto? animated,
    double? horizontalGap,
    double? verticalGap,
    IconThemeData? defaultIconStyle,
    TextStyleDto? labelTextStyle,
    TextStyleDto? contentTextStyle,
  }) {
    return builder(
      BaseLayoutSpecAttribute(
        horizontalGap: horizontalGap,
        verticalGap: verticalGap,
        defaultIconStyle: defaultIconStyle,
        labelTextStyle: labelTextStyle,
        contentTextStyle: contentTextStyle,
      ),
    );
  }

  T horizontalGap(double horizontalGap) => only(horizontalGap: horizontalGap);

  T verticalGap(double verticalGap) => only(verticalGap: verticalGap);

  T defaultIconStyle(IconThemeData defaultIconStyle) =>
      only(defaultIconStyle: defaultIconStyle);

  late final labelTextStyle = TextStyleUtility(
    (textStyleDto) => only(labelTextStyle: textStyleDto),
  );

  late final contentTextStyle = TextStyleUtility(
    (textStyleDto) => only(contentTextStyle: textStyleDto),
  );
}
