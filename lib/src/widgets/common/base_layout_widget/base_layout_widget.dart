import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec.dart';

class BaseLayoutWidget extends StyledWidget {
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final Widget? content;

  const BaseLayoutWidget({
    super.key,
    super.style,
    super.orderOfModifiers = const [],
    this.leading,
    this.label,
    this.trailing,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SpecBuilder(
      style: style,
      orderOfModifiers: orderOfModifiers,
      builder: (context) {
        final baseLayoutStyle = BaseLayoutSpec.of(context);

        return IconTheme(
          data: baseLayoutStyle.defaultIconStyle ?? const IconThemeData(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: baseLayoutStyle.horizontalGap),
                  ],
                  if (label != null)
                    Expanded(
                      child: switch (baseLayoutStyle.labelTextStyle != null) {
                        true => DefaultTextStyle(
                            style: baseLayoutStyle.labelTextStyle!,
                            child: label!,
                          ),
                        _ => label!,
                      },
                    ),
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
          ),
        );
      },
    );
  }
}
