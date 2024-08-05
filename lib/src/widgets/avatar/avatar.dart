import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/avatar/avatar_circle_clipper.dart';
import 'package:moon_core/src/widgets/avatar/avatar_rectangle_clipper.dart';

enum MoonBadgeAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class MoonRawAvatar extends StatelessWidget {
  /// Whether to show the avatar badge.
  final bool showBadge;

  /// The border radius of the avatar badge, used by the default clipper if no
  /// [customClipper] is provided.
  final BorderRadiusGeometry? badgeClipperBorderRadius;

  /// The border radius of the avatar, used by the default clipper if no
  /// [customClipper] is provided.
  final BorderRadiusGeometry? avatarClipperBorderRadius;

  /// The custom clipper for the avatar.
  final CustomClipper<Path>? customClipper;

  /// The gap between the avatar and the badge.
  final double badgeMarginValue;

  /// The alignment of the avatar badge.
  final MoonBadgeAlignment badgeAlignment;

  /// The size of the avatar.
  final Size avatarSize;

  /// The size value of the avatar badge, used by the default clipper
  /// if no [customClipper] is provided.
  final double? badgeSizeValue;

  /// The size of the avatar badge, used by the default clipper if no
  /// [customClipper] is provided.
  final Size? badgeSize;

  /// The semantic label for the avatar.
  final String? semanticLabel;

  /// The widget to display as the avatar badge.
  final Widget? badge;

  /// The widget to display within the avatar.
  final Widget content;

  /// Creates a Moon Design raw avatar with circular cutout.
  const MoonRawAvatar({
    super.key,
    this.showBadge = false,
    this.customClipper,
    this.badgeSizeValue = 0,
    this.badgeMarginValue = 0,
    this.badgeAlignment = MoonBadgeAlignment.bottomRight,
    required this.avatarSize,
    this.semanticLabel,
    this.badge,
    required this.content,
  })  : assert(
          badge != null || !showBadge,
          'If showBadge is true, badge can not be null.',
        ),
        avatarClipperBorderRadius = null,
        badgeClipperBorderRadius = null,
        badgeSize = null;

  /// Creates a Moon Design raw avatar with rectangular cutout.
  const MoonRawAvatar.rectangle({
    super.key,
    this.showBadge = false,
    this.customClipper,
    this.badgeSize = Size.zero,
    this.badgeMarginValue = 0,
    this.badgeClipperBorderRadius = BorderRadius.zero,
    this.avatarClipperBorderRadius = BorderRadius.zero,
    this.badgeAlignment = MoonBadgeAlignment.bottomRight,
    required this.avatarSize,
    this.semanticLabel,
    this.badge,
    required this.content,
  })  : assert(
          badge != null || !showBadge,
          'If showBadge is true, badge can not be null.',
        ),
        badgeSizeValue = null;

  bool get _isRectangleClipper =>
      customClipper == null && avatarClipperBorderRadius != null;

  Alignment _avatarAlignmentMapper(BuildContext context) {
    final bool isLTR = Directionality.of(context) == TextDirection.ltr;

    return switch (badgeAlignment) {
      MoonBadgeAlignment.topLeft =>
        isLTR ? Alignment.topLeft : Alignment.topRight,
      MoonBadgeAlignment.topRight =>
        isLTR ? Alignment.topRight : Alignment.topLeft,
      MoonBadgeAlignment.bottomLeft =>
        isLTR ? Alignment.bottomLeft : Alignment.bottomRight,
      MoonBadgeAlignment.bottomRight =>
        isLTR ? Alignment.bottomRight : Alignment.bottomLeft,
    };
  }

  CustomClipper<Path>? _getDefaultClipper(BuildContext context) {
    return avatarClipperBorderRadius != null && badgeClipperBorderRadius != null
        ? AvatarRectangleClipper(
            showBadge: showBadge,
            avatarSize: avatarSize,
            badgeSize: badgeSize!,
            badgeMarginValue: badgeMarginValue,
            badgeAlignment: badgeAlignment,
            textDirection: Directionality.of(context),
            avatarBorderRadius: avatarClipperBorderRadius!,
            badgeBorderRadius: badgeClipperBorderRadius!,
          )
        : AvatarCircleClipper(
            showBadge: showBadge,
            avatarSize: avatarSize,
            badgeSizeValue: badgeSizeValue!,
            badgeMarginValue: badgeMarginValue,
            badgeAlignment: badgeAlignment,
            textDirection: Directionality.of(context),
          );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWebPwa =
        kIsWeb && MediaQueryData.fromView(View.of(context)).size.width < 500;

    return Semantics(
      label: semanticLabel,
      button: false,
      focusable: false,
      child: SizedBox(
        height: avatarSize.height,
        width: avatarSize.width,
        child: Stack(
          alignment: _avatarAlignmentMapper(context),
          children: [
            Positioned.fill(
              child: ClipPath(
                clipper:
                    // Clipper does not work properly on mobile web/PWA,
                    // so it is disabled;
                    isWebPwa
                        ? null
                        : (customClipper ?? _getDefaultClipper(context)),
                child: content,
              ),
            ),
            if (showBadge && badge != null)
              customClipper == null
                  ? SizedBox(
                      width: _isRectangleClipper
                          ? badgeSize!.width
                          : badgeSizeValue,
                      height: _isRectangleClipper
                          ? badgeSize!.height
                          : badgeSizeValue,
                      child: badge,
                    )
                  : badge!,
          ],
        ),
      ),
    );
  }
}
