import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

enum AccordionItems { first, second }

class StyledAccordion extends StatefulWidget {
  const StyledAccordion({super.key});

  @override
  State<StyledAccordion> createState() => _StyledAccordionState();
}

class _StyledAccordionState extends State<StyledAccordion> {
  AccordionItems? _currentlyOpenAccordionItem = AccordionItems.first;

  BoxStyler get _outerContainerStyle => BoxStyler()
      .padding(
        EdgeInsetsGeometryMix.symmetric(horizontal: 16, vertical: 12),
      )
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(12)),
      )
      .border(
        BorderMix.all(
          BorderSideMix.value(
            BorderSide(color: Colors.purple.shade400, width: 1.5),
          ),
        ),
      )
      .color(Colors.purple.shade50)
      .shadows([
        BoxShadowMix.value(
          BoxShadow(
            color: Colors.purple.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ),
      ])
      .onHovered(BoxStyler().color(Colors.purple.shade100))
      .onFocused(
        BoxStyler().border(
          BorderMix.all(
            BorderSideMix.value(
              const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),
      )
          .animate(
        AnimationConfig.ease(const Duration(milliseconds: 200)),
      );

  FlexBoxStyler get _headerStyle => FlexBoxStyler()
      .mainAxisAlignment(MainAxisAlignment.spaceBetween)
      .crossAxisAlignment(CrossAxisAlignment.center)
      .spacing(12);

  BoxStyler get _contentStyle => BoxStyler()
      .padding(EdgeInsetsGeometryMix.all(16))
      .borderRadius(
        BorderRadiusGeometryMix.value(BorderRadius.circular(8)),
      )
      .color(Colors.white)
      .wrapDefaultTextStyle(
        TextStyleMix(
          color: Colors.purple.shade800,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawAccordion<AccordionItems>(
          identityValue: AccordionItems.first,
          groupIdentityValue: _currentlyOpenAccordionItem,
          transitionDuration: const Duration(milliseconds: 280),
          outerContainerStyle: _outerContainerStyle,
          contentStyle: _contentStyle,
          headerStyle: _headerStyle,
          onExpansionChanged: (AccordionItems? value) =>
              setState(() => _currentlyOpenAccordionItem = value),
          header: const Text("Grouped MoonRawAccordion"),
          trailingWidget: (BuildContext context, Animation<double> animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
              child: const Icon(
                Icons.expand_circle_down_outlined,
                size: 20,
                color: Colors.purple,
              ),
            );
          },
          divider: Divider(
            color: Colors.purple.shade200,
            thickness: 1,
            height: 1,
          ),
          children: const [Text("This is the content of the accordion.")],
        ),
        const SizedBox(height: 32),
        MoonRawAccordion<AccordionItems>(
          hasContentOutside: true,
          identityValue: AccordionItems.second,
          groupIdentityValue: _currentlyOpenAccordionItem,
          outerContainerStyle: _outerContainerStyle,
          contentStyle: _contentStyle,
          headerStyle: _headerStyle,
          onExpansionChanged: (AccordionItems? value) =>
              setState(() => _currentlyOpenAccordionItem = value),
          header: const Text("Ungrouped MoonRawAccordion"),
          trailingWidget: (BuildContext context, Animation<double> animation) =>
              Text(animation.value > 0.5 ? "Close" : "Open"),
          children: const [Text("This is the content of the accordion.")],
        ),
      ],
    );
  }
}
