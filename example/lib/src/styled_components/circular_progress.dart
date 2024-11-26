import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

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
