import 'package:flutter/material.dart';

import 'package:moon_core/moon_core.dart';

class StyledLinearLoader extends StatelessWidget {
  const StyledLinearLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonRawLinearLoader(color: Colors.purple);
  }
}
