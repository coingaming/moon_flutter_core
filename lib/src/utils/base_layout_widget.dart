import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

class BaseLayoutWidget extends StatelessWidget {
  final Style? headerStyle;
  final Style? contentStyle;
  final Style? verticalGapStyle;
  final TextStyle? defaultTextStyle;
  final IconThemeData? defaultIconStyle;
  final Widget? leading;
  final Widget? label;
  final Widget? trailing;
  final Widget? content;

  const BaseLayoutWidget({
    super.key,
    this.verticalGapStyle,
    this.headerStyle,
    this.contentStyle,
    this.defaultTextStyle,
    this.defaultIconStyle,
    this.leading,
    this.label,
    this.trailing,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: defaultIconStyle ?? const IconThemeData(),
      child: DefaultTextStyle(
        style: defaultTextStyle ?? const TextStyle(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HBox(
              style: headerStyle,
              children: [
                if (leading != null) leading!,
                if (label != null)
                  Expanded(
                    child: label!,
                  ),
                if (trailing != null) trailing!,
              ],
            ),
            if (content != null) ...[
              Box(
                style: verticalGapStyle,
              ),
              HBox(
                style: contentStyle,
                children: [
                  Expanded(
                    child: content!,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
