import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/src/widgets/avatar/avatar.dart';

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
              style: Style(
                $box.width(_badgeWidth),
                $box.height(_badgeHeight),
                $box.alignment.center(),
                $box.color(Colors.purpleAccent),
                $box.borderRadiusDirectional.bottomEnd(_borderRadiusValue),
                $box.borderRadiusDirectional.topStart(_borderRadiusValue),
                $text.style.color(Colors.white),
                $text.style.fontSize(8),
              ),
              child: const StyledText('Flutter'),
            ),
            content: Box(
              style: Style(
                $box.alignment.center(),
                $box.shapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/placeholder.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                $text.style.color(Colors.white),
                $text.style.fontSize(16),
              ),
              child: const StyledText('MD'),
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
          badge: Box(
            style: Style(
              $box.decoration.color(Colors.purpleAccent),
              $box.decoration.shape.circle(),
              $box.alignment.center(),
              $text.style.color(Colors.white),
              $text.style.fontSize(8),
            ),
            child: const StyledText('3'),
          ),
          content: Box(
            style: Style(
              $box.decoration.color(Colors.deepPurple),
              $box.borderRadius.circular(32),
              $text.style.fontSize(8),
              $icon.color(Colors.white),
              $icon.size(40),
            ),
            child: const StyledIcon(Icons.person),
          ),
        ),
      ],
    );
  }
}
