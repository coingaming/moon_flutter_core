import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec_attribute.dart';
import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_utility.dart';

BaseLayoutUtility<BaseLayoutSpecAttribute> $baseLayout = BaseLayoutUtility(MixUtility.selfBuilder);

class BaseLayoutWidget extends StyledWidget {
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final Widget? content;

  const BaseLayoutWidget({
    super.key,
    super.style,
    super.orderOfModifiers = const [],
    super.inherit = false,
    this.leading,
    this.label,
    this.trailing,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SpecBuilder(
      style: style,
      inherit: inherit,
      orderOfModifiers: orderOfModifiers,
      builder: (BuildContext context) {
        final baseLayoutStyle = BaseLayoutSpec.of(context);

        final child = StyledColumn(
          inherit: true,
          children: [
            StyledRow(
              inherit: true,
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                ],
                if (label != null)
                  switch (baseLayoutStyle.labelTextStyle != null) {
                    true => DefaultTextStyle(
                        style: baseLayoutStyle.labelTextStyle!,
                        child: label!,
                      ),
                    _ => label!,
                  },
                if (trailing != null) ...[
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                  trailing!,
                ],
              ],
            ),
            if (content != null) ...[
              SizedBox(height: baseLayoutStyle.verticalGap),
              switch (baseLayoutStyle.contentTextStyle != null) {
                true => DefaultTextStyle(
                    style: baseLayoutStyle.contentTextStyle!,
                    child: content!,
                  ),
                _ => content!,
              },
            ],
          ],
        );

        return baseLayoutStyle.defaultIconStyle != null
            ? IconTheme(
                data: baseLayoutStyle.defaultIconStyle!,
                child: child,
              )
            : child;
      },
    );
  }
}
