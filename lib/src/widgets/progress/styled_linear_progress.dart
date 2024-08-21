import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/progress/linear_progress.dart';
import 'package:moon_core/src/widgets/progress_pin/pin_style.dart';

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
      pinStyle: const PinStyle(
        pinColor: Colors.purple,
      ),
    );
  }
}
