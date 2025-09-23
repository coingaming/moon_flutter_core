import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

class MoonMessage extends StatefulWidget {
  final String text;
  final Icon? icon;
  final double horizontalGap;
  final Duration duration;
  final Curve curve;

  /// Creates a default error message widget, utilized in [MoonRawTextInput] and
  /// [MoonRawTextFormInput].
  const MoonMessage({
    super.key,
    required this.text,
    this.icon,
    this.horizontalGap = 4,
    this.duration = const Duration(milliseconds: 167),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<MoonMessage> createState() => _MoonMessageState();
}

class _MoonMessageState extends State<MoonMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.curve.flipped,
    );
    _controller
      ..value = 0.0
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Row(
        children: [
          widget.icon ??
              StyledIcon(
                icon: Icons.error_outline_rounded,
                style: IconStyler().size(16),
              ),
          SizedBox(width: widget.horizontalGap),
          Flexible(child: StyledText(widget.text)),
        ],
      ),
    );
  }
}
