import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/loaders/circular_loader.dart';

class StyledCircularLoader extends StatelessWidget {
  const StyledCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonRawCircularLoader(
      color: Colors.purple,
    );
  }
}
