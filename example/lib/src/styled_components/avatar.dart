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

  Style get _customBadgeStyle => Style(
    $box.chain
      ..width(_badgeWidth)
      ..height(_badgeHeight)
      ..alignment.center()
      ..color(Colors.purpleAccent)
      ..borderRadiusDirectional.bottomEnd(_borderRadiusValue)
      ..borderRadiusDirectional.topStart(_borderRadiusValue),
    $text.chain
      ..style.color(Colors.white)
      ..style.fontSize(8),
  );

  Style get _customContentStyle => Style(
    $box.chain
      ..alignment.center()
      ..shapeDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/placeholder.png"),
          fit: BoxFit.cover,
        ),
      ),
    $text.chain
      ..style.color(Colors.white)
      ..style.fontSize(16),
  );

  Style get _badgeStyle => Style(
    $box.chain
      ..decoration.color(Colors.purpleAccent)
      ..decoration.shape.circle()
      ..alignment.center(),
    $text.chain
      ..style.color(Colors.white)
      ..style.fontSize(8),
  );

  Style get _contentStyle => Style(
    $box.chain
      ..decoration.color(Colors.deepPurple)
      ..borderRadius.circular(32),
    $icon.chain
      ..color(Colors.white)
      ..size(40),
    $text.style.fontSize(8),
  );

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
            child: const StyledIcon(Icons.person),
          ),
        ),
      ],
    );
  }
}
