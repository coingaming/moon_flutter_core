import 'package:flutter/rendering.dart';
import 'package:moon_core/src/widgets/avatar/avatar.dart';

class AvatarCircleClipper extends CustomClipper<Path> {
  final bool showBadge;
  final double badgeMarginValue;
  final double badgeSizeValue;
  final MoonBadgeAlignment badgeAlignment;
  final Size avatarSize;
  final TextDirection textDirection;

  AvatarCircleClipper({
    required this.showBadge,
    required this.badgeMarginValue,
    required this.badgeSizeValue,
    required this.badgeAlignment,
    required this.avatarSize,
    required this.textDirection,
  });

  Path _getBadgePath() {
    final double width = avatarSize.width;
    final double height = avatarSize.height;
    final double badgeRadius = badgeSizeValue / 2;
    final Offset center;

    switch (badgeAlignment) {
      case MoonBadgeAlignment.topLeft:
        center = textDirection == TextDirection.ltr
            ? Offset(badgeRadius, badgeRadius)
            : Offset(width - badgeRadius, badgeRadius);
      case MoonBadgeAlignment.topRight:
        center = textDirection == TextDirection.ltr
            ? Offset(width - badgeRadius, badgeRadius)
            : Offset(badgeRadius, badgeRadius);
      case MoonBadgeAlignment.bottomLeft:
        center = textDirection == TextDirection.ltr
            ? Offset(badgeRadius, height - badgeRadius)
            : Offset(width - badgeRadius, width - badgeRadius);
      case MoonBadgeAlignment.bottomRight:
        center = textDirection == TextDirection.ltr
            ? Offset(width - badgeRadius, height - badgeRadius)
            : Offset(badgeRadius, width - badgeRadius);
      default:
        center = Offset(width - badgeRadius, width - badgeRadius);
    }

    return Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: badgeRadius + badgeMarginValue),
      );
  }

  Path _getAvatarPath() =>
      Path()..addRect(Rect.fromLTWH(0, 0, avatarSize.width, avatarSize.height));

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
