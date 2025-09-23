import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const IconData _avatarIcon = Icons.person;
const String _badgeText = "3";

void main() {
  final Finder avatar = find.byType(MoonRawAvatar);
  final Finder badge = find.text(_badgeText);

  testWidgets("Avatar displays the 'avatarSize' correctly", (tester) async {
    final Finder avatarIcon = find.byIcon(_avatarIcon);

    await tester.pumpWidget(const _AvatarTestWidget(avatarSize: Size(40, 40)));

    expect(avatarIcon, findsOneWidget);
    expect(badge, findsOneWidget);

    final avatarWidget = tester.firstWidget(avatar) as MoonRawAvatar;

    expect(avatarWidget.avatarSize.width, 40);
    expect(avatarWidget.avatarSize.height, 40);
  });

  testWidgets("Badge is displayed when 'showBadge' is true", (tester) async {
    await tester.pumpWidget(const _AvatarTestWidget());

    expect(badge, findsOneWidget);
  });

  testWidgets("Badge is not displayed when 'showBadge' is false", (
    tester,
  ) async {
    await tester.pumpWidget(const _AvatarTestWidget(showBadge: false));

    expect(badge, findsNothing);
  });

  testWidgets("Badge is aligned correctly according to 'badgeAlignment'", (
    tester,
  ) async {
    final List<MoonBadgeAlignment> badgeAlignment = [
      MoonBadgeAlignment.topLeft,
      MoonBadgeAlignment.bottomLeft,
      MoonBadgeAlignment.bottomRight,
      MoonBadgeAlignment.topRight,
    ];

    for (final alignment in badgeAlignment) {
      await tester.pumpWidget(_AvatarTestWidget(badgeAlignment: alignment));

      expect(avatar, findsOneWidget);
      expect(badge, findsOneWidget);

      final avatarPosition = tester.getCenter(avatar);
      final badgePosition = tester.getCenter(badge);

      switch (alignment) {
        case MoonBadgeAlignment.topLeft:
          expect(badgePosition.dy, lessThan(avatarPosition.dy));
          expect(badgePosition.dx, lessThan(avatarPosition.dx));
        case MoonBadgeAlignment.bottomLeft:
          expect(badgePosition.dy, greaterThan(avatarPosition.dy));
          expect(badgePosition.dx, lessThan(avatarPosition.dx));
        case MoonBadgeAlignment.bottomRight:
          expect(badgePosition.dy, greaterThan(avatarPosition.dy));
          expect(badgePosition.dx, greaterThan(avatarPosition.dx));
        case MoonBadgeAlignment.topRight:
          expect(badgePosition.dy, lessThan(avatarPosition.dy));
          expect(badgePosition.dx, greaterThan(avatarPosition.dx));
      }
    }
  });

  testWidgets(
    "Custom clipper is applied to the avatar, if 'customClipper' is provided",
    (tester) async {
      final CustomClipper<Path> customClipper = _CustomClipper();

      await tester.pumpWidget(_AvatarTestWidget(customClipper: customClipper));

      final clipPathFinder = find.byType(ClipPath);
      final clipPathWidget = tester.firstWidget(clipPathFinder) as ClipPath;

      expect(clipPathFinder, findsOneWidget);
      expect(clipPathWidget.clipper, isNotNull);
      expect(clipPathWidget.clipper, isA<_CustomClipper>());
    },
  );

  testWidgets(
    "Default clipper is applied to the avatar if 'customClipper' is not provided",
    (tester) async {
      await tester.pumpWidget(const _AvatarTestWidget());

      final clipPathFinder = find.byType(ClipPath);
      final clipPathWidget = tester.firstWidget(clipPathFinder) as ClipPath;

      expect(clipPathFinder, findsOneWidget);
      expect(clipPathWidget.clipper, isNotNull);
      expect(clipPathWidget.clipper, isA<AvatarCircleClipper>());
    },
  );
}

class _AvatarTestWidget extends StatefulWidget {
  final bool showBadge;
  final CustomClipper<Path>? customClipper;
  final MoonBadgeAlignment badgeAlignment;
  final Size avatarSize;

  const _AvatarTestWidget({
    this.showBadge = true,
    this.customClipper,
    this.badgeAlignment = MoonBadgeAlignment.bottomRight,
    this.avatarSize = const Size(56, 56),
  });

  @override
  State<_AvatarTestWidget> createState() => _AvatarTestWidgetState();
}

class _AvatarTestWidgetState extends State<_AvatarTestWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawAvatar(
          showBadge: widget.showBadge,
          avatarSize: widget.avatarSize,
          customClipper: widget.customClipper,
          badgeAlignment: widget.badgeAlignment,
          badge: const Text(_badgeText),
          content: const Icon(_avatarIcon),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  _CustomClipper();

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) => Path();
}
