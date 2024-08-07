import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/tooltip/tooltip.dart';

class StyledTooltip extends StatefulWidget {
  const StyledTooltip({super.key});

  @override
  State<StyledTooltip> createState() => _StyledTooltipState();
}

class _StyledTooltipState extends State<StyledTooltip> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MoonRawTooltip(
      show: _show,
      onTap: () => setState(() => _show = false),
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      tooltipShadows: const [
        BoxShadow(
          color: Color(0x8E000000),
          blurRadius: 1,
        ),
        BoxShadow(
          color: Color(0xA3000000),
          blurRadius: 6,
          offset: Offset(0, 6),
          spreadRadius: -6,
        ),
      ],
      target: IconButton(
        onPressed: () => setState(() => _show = !_show),
        icon: const Icon(Icons.info, color: Colors.purple,),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is tooltip'),
      ),
    );
  }
}
