import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

class StyledLinearProgress extends StatelessWidget {
  const StyledLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonRawLinearProgress(
      value: 0.5,
      showMinLabel: true,
      showMaxLabel: true,
      showPin: true,
      backgroundColor: Colors.purple.shade200,
      color: Colors.purple,
      pinStyle: const PinStyle(pinColor: Colors.purple),
    );
  }
}
