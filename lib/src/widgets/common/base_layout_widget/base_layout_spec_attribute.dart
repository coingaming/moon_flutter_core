import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec.dart';

class BaseLayoutSpecAttribute extends SpecAttribute<BaseLayoutSpec> {
  final double? horizontalGap;
  final double? verticalGap;
  final IconThemeData? defaultIconStyle;
  final TextStyleDto? labelTextStyle;
  final TextStyleDto? contentTextStyle;

  const BaseLayoutSpecAttribute({
    this.horizontalGap,
    this.verticalGap,
    this.defaultIconStyle,
    this.labelTextStyle,
    this.contentTextStyle,
  });

  @override
  BaseLayoutSpec resolve(MixData mix) {
    return BaseLayoutSpec(
      horizontalGap: horizontalGap,
      verticalGap: verticalGap,
      defaultIconStyle: defaultIconStyle,
      labelTextStyle: labelTextStyle?.resolve(mix),
      contentTextStyle: contentTextStyle?.resolve(mix),
    );
  }

  @override
  BaseLayoutSpecAttribute merge(covariant BaseLayoutSpecAttribute? other) {
    if (other == null) return this;

    return BaseLayoutSpecAttribute(
      horizontalGap: other.horizontalGap ?? horizontalGap,
      verticalGap: other.verticalGap ?? verticalGap,
      defaultIconStyle: other.defaultIconStyle ?? defaultIconStyle,
      labelTextStyle: other.labelTextStyle ?? labelTextStyle,
      contentTextStyle: other.contentTextStyle ?? contentTextStyle,
    );
  }

  @override
  List<Object?> get props => [
        horizontalGap,
        verticalGap,
        defaultIconStyle,
        labelTextStyle,
        contentTextStyle,
      ];
}
