import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MoonRawDrawer extends StatelessWidget {
  /// Semantic label for the drawer.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	[Semantics] widget.
  final String? semanticLabel;

  /// The style of the drawer.
  final Style? style;

  /// The child widget to display inside the drawer as its content.
  final Widget child;

  const MoonRawDrawer({
    super.key,
    this.semanticLabel,
    this.style,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      namesRoute: true,
      scopesRoute: true,
      label: semanticLabel,
      child: Box(
        style: style,
        child: child,
      ),
    );
  }
}
