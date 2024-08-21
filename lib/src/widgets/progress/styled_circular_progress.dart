import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/progress/circular_progress.dart';

class StyledCircularProgress extends StatelessWidget {
  const StyledCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonRawCircularProgress(
      value: 0.5,
      color: Colors.purple,
      backgroundColor: Colors.purple.shade200,
    );
  }
}
