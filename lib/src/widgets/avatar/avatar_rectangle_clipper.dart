import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:moon_core/src/widgets/avatar/avatar.dart';

class AvatarRectangleClipper extends CustomClipper<Path> {
  final bool showBadge;
  final BorderRadiusGeometry avatarBorderRadius;
  final BorderRadiusGeometry badgeBorderRadius;
  final double badgeMarginValue;
  final MoonBadgeAlignment badgeAlignment;
  final Size avatarSize;
  final Size badgeSize;
  final TextDirection textDirection;

  AvatarRectangleClipper({
    required this.showBadge,
    required this.avatarBorderRadius,
    required this.badgeBorderRadius,
    required this.avatarSize,
    required this.badgeMarginValue,
    required this.badgeSize,
    required this.badgeAlignment,
    required this.textDirection,
  });

  Path _getBadgePath() {
    final Offset badgeOffset = _calculateBadgeOffset();

    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromCenter(
            center: badgeOffset,
            width: badgeSize.width + 2 * badgeMarginValue,
            height: badgeSize.height + 2 * badgeMarginValue,
          ),
          topLeft: badgeBorderRadius.resolve(textDirection).topLeft,
          topRight: badgeBorderRadius.resolve(textDirection).topRight,
          bottomLeft: badgeBorderRadius.resolve(textDirection).bottomLeft,
          bottomRight: badgeBorderRadius.resolve(textDirection).bottomRight,
        ),
      );
  }

  Offset _calculateBadgeOffset() {
    final double width = avatarSize.width;
    final double height = avatarSize.height;

    double badgeCenterX;
    double badgeCenterY;

    switch (badgeAlignment) {
      case MoonBadgeAlignment.topLeft:
        badgeCenterX = textDirection == TextDirection.ltr
            ? badgeSize.width / 2 + badgeMarginValue
            : width - badgeSize.width / 2 - badgeMarginValue;
        badgeCenterY = badgeSize.height / 2 + badgeMarginValue;
      case MoonBadgeAlignment.topRight:
        badgeCenterX = textDirection == TextDirection.ltr
            ? width - badgeSize.width / 2 - badgeMarginValue
            : badgeSize.width / 2 + badgeMarginValue;
        badgeCenterY = badgeSize.height / 2 + badgeMarginValue;
      case MoonBadgeAlignment.bottomLeft:
        badgeCenterX = textDirection == TextDirection.ltr
            ? badgeSize.width / 2 + badgeMarginValue
            : width - badgeSize.width / 2 - badgeMarginValue;
        badgeCenterY = height - badgeSize.height / 2 - badgeMarginValue;
      case MoonBadgeAlignment.bottomRight:
        badgeCenterX = textDirection == TextDirection.ltr
            ? width - badgeSize.width / 2 - badgeMarginValue
            : badgeSize.width / 2 + badgeMarginValue;
        badgeCenterY = height - badgeSize.height / 2 - badgeMarginValue;
    }

    return Offset(badgeCenterX, badgeCenterY);
  }

  Path _getAvatarPath() {
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, avatarSize.width, avatarSize.height),
          topLeft: avatarBorderRadius.resolve(textDirection).topLeft,
          topRight: avatarBorderRadius.resolve(textDirection).topRight,
          bottomLeft: avatarBorderRadius.resolve(textDirection).bottomLeft,
          bottomRight: avatarBorderRadius.resolve(textDirection).bottomRight,
        ),
      );
  }

  @override
  Path getClip(Size size) {
    if (!showBadge) return _getAvatarPath();

    return Path.combine(
      PathOperation.difference,
      _getAvatarPath(),
      _getBadgePath(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
