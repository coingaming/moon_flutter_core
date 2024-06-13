import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec_attribute.dart';

class BaseLayoutSpec extends Spec<BaseLayoutSpec> {
  final double? horizontalGap;
  final double? verticalGap;
  final IconThemeData? defaultIconStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? contentTextStyle;

  const BaseLayoutSpec({
    super.animated,
    this.horizontalGap,
    this.verticalGap,
    this.defaultIconStyle,
    this.labelTextStyle,
    this.contentTextStyle,
  });

  const BaseLayoutSpec.empty({super.animated})
      : horizontalGap = null,
        verticalGap = null,
        defaultIconStyle = null,
        labelTextStyle = null,
        contentTextStyle = null;

  static BaseLayoutSpec of(BuildContext context) {
    final mix = Mix.of(context);
    return mix.attributeOf<BaseLayoutSpecAttribute>()?.resolve(mix) ?? const BaseLayoutSpec.empty();
  }

  @override
  BaseLayoutSpec lerp(BaseLayoutSpec? other, double t) {
    return BaseLayoutSpec(
      horizontalGap: lerpDouble(horizontalGap, other?.horizontalGap, t),
      verticalGap: lerpDouble(verticalGap, other?.verticalGap, t),
      defaultIconStyle: IconThemeData.lerp(defaultIconStyle, other?.defaultIconStyle, t),
      labelTextStyle: TextStyle.lerp(labelTextStyle, other?.labelTextStyle, t),
      contentTextStyle: TextStyle.lerp(contentTextStyle, other?.contentTextStyle, t),
    );
  }

  @override
  BaseLayoutSpec copyWith({
    double? horizontalGap,
    double? verticalGap,
    IconThemeData? defaultIconStyle,
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return BaseLayoutSpec(
      horizontalGap: horizontalGap ?? this.horizontalGap,
      verticalGap: verticalGap ?? this.verticalGap,
      defaultIconStyle: defaultIconStyle ?? this.defaultIconStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  get props => [
        horizontalGap,
        verticalGap,
        defaultIconStyle,
        labelTextStyle,
        contentTextStyle,
      ];
}
