import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec.dart';

final $baseLayout = BaseLayoutSpecUtility.self;

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

        return StyledColumn(
          inherit: true,
          children: [
            StyledRow(
              inherit: true,
              children: [
                if (leading != null) ...[
                  _DefaultStyleWrapper(
                    iconThemeData: baseLayoutStyle.leadingIconThemeData,
                    defaultTextStyle: baseLayoutStyle.leadingTextStyle,
                    child: leading!,
                  ),
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                ],
                if (label != null)
                  _DefaultStyleWrapper(
                    iconThemeData: baseLayoutStyle.labelIconThemeData,
                    defaultTextStyle: baseLayoutStyle.labelTextStyle,
                    child: label!,
                  ),
                if (trailing != null) ...[
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                  _DefaultStyleWrapper(
                    iconThemeData: baseLayoutStyle.trailingIconThemeData,
                    defaultTextStyle: baseLayoutStyle.trailingTextStyle,
                    child: trailing!,
                  ),
                ],
              ],
            ),
            if (content != null) ...[
              SizedBox(height: baseLayoutStyle.verticalGap),
              _DefaultStyleWrapper(
                iconThemeData: baseLayoutStyle.contentIconThemeData,
                defaultTextStyle: baseLayoutStyle.contentTextStyle,
                child: content!,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _DefaultStyleWrapper extends StatelessWidget {
  final IconThemeData? iconThemeData;
  final TextStyle? defaultTextStyle;
  final Widget child;

  const _DefaultStyleWrapper({
    this.iconThemeData,
    this.defaultTextStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return switch ((iconThemeData != null, defaultTextStyle != null)) {
      (true, true) => IconTheme(
          data: iconThemeData!,
          child: DefaultTextStyle(
            style: defaultTextStyle!,
            child: child,
          ),
        ),
      (true, false) => IconTheme(
          data: iconThemeData!,
          child: child,
        ),
      (false, true) => DefaultTextStyle(
          style: defaultTextStyle!,
          child: child,
        ),
      _ => child,
    };
  }
}
