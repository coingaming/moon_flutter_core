import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/carousel/carousel.dart';

class StyledCarousel extends StatefulWidget {
  const StyledCarousel({super.key});

  @override
  State<StyledCarousel> createState() => _StyledCarouselState();
}

class _StyledCarouselState extends State<StyledCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: MoonRawCarousel(
        itemCount: 10,
        itemExtent: 114,
        isCentered: false,
        clampMaxExtent: true,
        itemBuilder: (BuildContext context, int itemIndex, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "${itemIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
