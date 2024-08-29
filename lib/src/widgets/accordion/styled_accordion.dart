import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_core/src/utils/extensions.dart';

enum AccordionItems { first, second }

class StyledAccordion extends StatefulWidget {
  const StyledAccordion({super.key});

  @override
  State<StyledAccordion> createState() => _StyledAccordionState();
}

class _StyledAccordionState extends State<StyledAccordion> {
  AccordionItems? _currentlyOpenAccordionItem = AccordionItems.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRawAccordion<AccordionItems>(
          identityValue: AccordionItems.first,
          groupIdentityValue: _currentlyOpenAccordionItem,
          transitionDuration: const Duration(milliseconds: 1000),
          outerContainerStyle: Style(
            $with.iconTheme.data(color: Colors.purple, size: 16),
            $box.borderRadius(24),
            $box.border.all(color: Colors.purple),
            $box.shadows([
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              ),
            ]),
          ),
          headerStyle: Style(
            $box.padding(8, 16),
            $box.color(Colors.purple.shade100),
            $flex.mainAxisAlignment.spaceBetween(),
          ),
          contentStyle: Style(
            $box.height(80),
            $box.color(Colors.purple.shade50),
            $flex.mainAxisAlignment.center(),
          ),
          onExpansionChanged: (AccordionItems? value) =>
              setState(() => _currentlyOpenAccordionItem = value),
          header: const Text('Grouped MoonRawAccordion'),
          trailingWidget: (BuildContext context, Animation<double> animation) =>
              RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
            child: const Icon(Icons.expand_circle_down_outlined),
          ),
          divider: Divider(
            color: Colors.purple.shade200,
            thickness: 1,
            height: 1,
          ),
          children: const [
            Text('This is the content of the accordion.'),
          ],
        ),
        const SizedBox(height: 32),
        MoonRawAccordion<AccordionItems>(
          hasContentOutside: true,
          identityValue: AccordionItems.second,
          groupIdentityValue: _currentlyOpenAccordionItem,
          headerStyle: Style(
            $box.padding(8, 16),
            $box.margin.bottom(8),
            $box.borderRadius(24),
            $box.color(Colors.white),
            $box.border(color: Colors.grey.shade300),
            $with.iconTheme.data.size(20),
            $flex.mainAxisAlignment.spaceBetween(),
          ),
          onExpansionChanged: (AccordionItems? value) =>
              setState(() => _currentlyOpenAccordionItem = value),
          header: const Text('Ungrouped MoonRawAccordion'),
          trailingWidget: (BuildContext context, Animation<double> animation) =>
              Text(animation.value > 0.5 ? 'Close' : 'Open'),
          children: const [
            Text('This is the content of the accordion.'),
          ],
        ),
      ],
    );
  }
}
