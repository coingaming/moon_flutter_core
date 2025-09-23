import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

class StyledAvatar extends StatefulWidget {
  const StyledAvatar({super.key});

  @override
  State<StyledAvatar> createState() => _StyledAvatarState();
}

class _StyledAvatarState extends State<StyledAvatar> {
  static const Size _avatarSize = Size(56, 56);
  static const double _badgeHeight = 14;
  static const double _badgeWidth = 40;
  static const double _borderRadiusValue = 8;
  static const double _marginValue = 1;

  BoxStyler get _customBadgeStyle => BoxStyler()
      .width(_badgeWidth)
      .height(_badgeHeight)
      .alignment(Alignment.center)
      .color(Colors.purpleAccent)
      .borderRadius(
        BorderRadiusGeometryMix.value(
          const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(_borderRadiusValue),
            topStart: Radius.circular(_borderRadiusValue),
          ),
        ),
      )
      .wrapDefaultTextStyle(
        TextStyleMix(color: Colors.white, fontSize: 8),
      );

  BoxStyler get _customContentStyle => BoxStyler()
      .alignment(Alignment.center)
      .backgroundImageAsset(
        "assets/images/placeholder.png",
        fit: BoxFit.cover,
      )
      .wrapDefaultTextStyle(
        TextStyleMix(color: Colors.white, fontSize: 16),
      );

  BoxStyler get _badgeStyle => BoxStyler()
      .alignment(Alignment.center)
      .color(Colors.purpleAccent)
      .shapeCircle()
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.white, fontSize: 8));

  BoxStyler get _contentStyle => BoxStyler()
      .alignment(Alignment.center)
      .color(Colors.deepPurple)
      .borderRadius(BorderRadiusGeometryMix.circular(32))
      .wrapDefaultTextStyle(TextStyleMix(color: Colors.white, fontSize: 8));

  IconStyler get _contentIconStyle =>
      IconStyler().color(Colors.white).size(40);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // With custom rectangle clipper.
        Directionality(
          textDirection: TextDirection.ltr,
          child: MoonRawAvatar.rectangle(
            showBadge: true,
            badgeMarginValue: _marginValue,
            avatarSize: _avatarSize,
            badgeSize: const Size(_badgeWidth, _badgeHeight),
            avatarClipperBorderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(16),
              bottomStart: Radius.circular(16),
            ),
            badgeClipperBorderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(_borderRadiusValue + 1),
            ),
            badge: Box(
              style: _customBadgeStyle,
              child: const StyledText("Flutter"),
            ),
            content: Box(
              style: _customContentStyle,
              child: const StyledText("MD"),
            ),
          ),
        ),
        const SizedBox(width: 24),

        // Default circle clipper.
        MoonRawAvatar(
          showBadge: true,
          badgeSizeValue: 12,
          badgeMarginValue: 3,
          avatarSize: _avatarSize,
          badge: Box(style: _badgeStyle, child: const StyledText("3")),
          content: Box(
            style: _contentStyle,
            child: StyledIcon(icon: Icons.person, style: _contentIconStyle),
          ),
        ),
      ],
    );
  }
}
