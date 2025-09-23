import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

class StyledCircularLoader extends StatelessWidget {
  const StyledCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonRawCircularLoader(color: Colors.purple);
  }
}
