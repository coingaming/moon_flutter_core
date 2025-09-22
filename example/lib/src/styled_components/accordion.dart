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

  Style get _accordionStyle => Style(
    $box.chain
      ..color(Colors.purple.shade50)
      ..borderRadius(8)
      ..foregroundDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple),
      )
      ..shadows([
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          spreadRadius: 1,
          offset: const Offset(0, 1),
        ),
      ]),
    $on.focus(
      $box.foregroundDecoration(
        border: Border.all(color: Colors.purple, width: 2),
      ),
    ),
    $on.hover($box.color(Colors.purple.shade100)),
  ).animate();

  Style get _headerStyle => Style(
    $box.chain
      ..padding(8, 16)
      ..borderRadius(8),
    $flex.mainAxisAlignment.spaceBetween(),
  );

  Style get _contentStyle => Style(
    $box.chain
      ..height(80)
      ..borderRadius(8),
    $flex.mainAxisAlignment.center(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawAccordion<AccordionItems>(
          identityValue: AccordionItems.first,
          groupIdentityValue: _currentlyOpenAccordionItem,
          transitionDuration: const Duration(milliseconds: 1000),
          outerContainerStyle: _accordionStyle,
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
          outerContainerStyle: _accordionStyle,
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
