import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MoonErrorMessage extends StatefulWidget {
  final String errorText;
  final Duration duration;
  final Curve curve;

  /// Creates a default error message widget, utilized in [MoonRawTextInput]
  /// and [MoonRawTextFormInput].
  const MoonErrorMessage({
    super.key,
    required this.errorText,
    this.duration = const Duration(milliseconds: 167),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<MoonErrorMessage> createState() => _MoonErrorMessageState();
}

class _MoonErrorMessageState extends State<MoonErrorMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
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
          StyledIcon(
            style: Style($icon.size(16)),
            Icons.info_outline,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: StyledText(widget.errorText),
          ),
        ],
      ),
    );
  }
}
