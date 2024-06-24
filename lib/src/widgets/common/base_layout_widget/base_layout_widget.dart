import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/mix/modifiers/widget_modifiers.dart';
import 'package:moon_core/src/utils/extensions/icon_theme_data_x.dart';

import 'package:moon_core/src/widgets/common/base_layout_widget/base_layout_spec.dart';

final $baseLayout = BaseLayoutSpecUtility.self;
final _wrapper = DefaultModifierUtility.self;

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
                  IconThemeAndDefaultTextStyleWrapper(
                    iconThemeData: baseLayoutStyle.leadingIconThemeData,
                    defaultTextStyle: baseLayoutStyle.leadingTextStyle,
                    child: leading!,
                  ),
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                ],
                if (label != null)
                  IconThemeAndDefaultTextStyleWrapper(
                    iconThemeData: baseLayoutStyle.labelIconThemeData,
                    defaultTextStyle: baseLayoutStyle.labelTextStyle,
                    child: label!,
                  ),
                if (trailing != null) ...[
                  SizedBox(width: baseLayoutStyle.horizontalGap),
                  IconThemeAndDefaultTextStyleWrapper(
                    iconThemeData: baseLayoutStyle.trailingIconThemeData,
                    defaultTextStyle: baseLayoutStyle.trailingTextStyle,
                    child: trailing!,
                  ),
                ],
              ],
            ),
            if (content != null) ...[
              SizedBox(height: baseLayoutStyle.verticalGap),
              IconThemeAndDefaultTextStyleWrapper(
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

class IconThemeAndDefaultTextStyleWrapper extends StatelessWidget {
  final bool inherit;
  final IconThemeData? iconThemeData;
  final TextStyle? defaultTextStyle;
  final Widget child;

  const IconThemeAndDefaultTextStyleWrapper({
    this.inherit = false,
    this.iconThemeData,
    this.defaultTextStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final iconStyle = IconSpec.of(context);

    final inheritedIconTheme = IconThemeData(
      applyTextScaling: iconStyle.applyTextScaling,
      color: iconStyle.color,
      fill: iconStyle.fill,
      grade: iconStyle.grade,
      opticalSize: iconStyle.opticalSize,
      shadows: iconStyle.shadows,
      size: iconStyle.size,
      weight: iconStyle.weight,
    );

    final resolvedIconTheme = inheritedIconTheme.merge(iconThemeData);

    return SpecBuilder(
      inherit: inherit,
      style: Style(
        resolvedIconTheme.hasAValue
            ? _wrapper.iconTheme(
                data: resolvedIconTheme,
              )
            : null,
        defaultTextStyle != null
            ? _wrapper.defaultTextStyle(
                style: defaultTextStyle!,
              )
            : null,
      ),
      builder: (context) {
        return child;
      },
    );
  }
}
