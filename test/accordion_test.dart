import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

enum _AccordionItems { first, second }

const Key _singleAccordionKey = Key("singleAccordionKey");
const Key _singleAccordionChildKey = Key("singleAccordionChildKey");
const Key _firstAccordionKey = Key("firstAccordionKey");
const Key _firstAccordionChildKey = Key("firstAccordionChildKey");
const Key _secondAccordionKey = Key("secondAccordionKey");
const Key _secondAccordionChildKey = Key("secondAccordionChildKey");

const String _accordionLabel = "Label";
const String _accordionContent = "Content";

void main() {
  group("Single accordion", () {
    final Finder accordion = find.byKey(_singleAccordionKey);
    final Finder child = find.byKey(_singleAccordionChildKey);
    final Finder header = find.text(_accordionLabel);
    final Finder content = find.text(_accordionContent);

    testWidgets("Initial expansion state is respected", (tester) async {
      await tester.pumpWidget(
        const _SingleAccordionTestWidget(initiallyExpanded: true),
      );

      expect(accordion, findsOneWidget);
      expect(child, findsOneWidget);
    });

    testWidgets("Accordion expands when tapped", (tester) async {
      await tester.pumpWidget(const _SingleAccordionTestWidget());

      expect(accordion, findsOneWidget);
      expect(header, findsOneWidget);
      expect(child, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsOneWidget);
    });

    testWidgets("Disabled accordion does not expand/collapse when tapped", (
      tester,
    ) async {
      await tester.pumpWidget(const _SingleAccordionTestWidget(enabled: false));

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsNothing);
    });

    testWidgets("Accordion toggles on header tap", (tester) async {
      await tester.pumpWidget(const _SingleAccordionTestWidget());

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsOneWidget);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsNothing);
    });

    testWidgets("Provided trailing widget is used and animation works", (
      tester,
    ) async {
      const String open = "Open";
      const String close = "Close";

      final Finder trailingOpen = find.text(open);
      final Finder trailingClose = find.text(close);

      await tester.pumpWidget(
        _SingleAccordionTestWidget(
          trailingWidget: (BuildContext _, Animation<double> animation) {
            return Text(animation.value > 0.5 ? close : open);
          },
        ),
      );

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);

      expect(trailingOpen, findsOneWidget);
      expect(trailingClose, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(accordion, findsOneWidget);
      expect(child, findsOneWidget);

      expect(trailingOpen, findsNothing);
      expect(trailingClose, findsOneWidget);
    });

    testWidgets("Animation interruption is handled", (tester) async {
      await tester.pumpWidget(const _SingleAccordionTestWidget());

      await tester.tap(accordion);
      await tester.pump();
      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsNothing);
    });

    testWidgets(
      "Accordion has content inside header, when 'hasContentOutside' is true",
      (WidgetTester tester) async {
        final Finder decoratedBox = find.byType(DecoratedBox);

        await tester.pumpWidget(
          const _SingleAccordionTestWidget(hasContentOutside: true),
        );

        expect(header, findsOneWidget);

        await tester.tap(header);
        await tester.pumpAndSettle();

        expect(content, findsOneWidget);
        expect(decoratedBox, findsOneWidget);
        expect(
          find.descendant(of: decoratedBox, matching: header),
          findsOneWidget,
        );
        expect(
          find.descendant(of: decoratedBox, matching: content),
          findsNothing,
        );
      },
    );

    testWidgets(
      "Accordion has content inside, when 'hasContentOutside' is false",
      (WidgetTester tester) async {
        final Finder decoratedBox = find.byType(DecoratedBox);

        await tester.pumpWidget(const _SingleAccordionTestWidget());

        expect(header, findsOneWidget);

        await tester.tap(header);
        await tester.pumpAndSettle();

        expect(content, findsOneWidget);
        expect(decoratedBox, findsOneWidget);
        expect(
          find.descendant(of: decoratedBox, matching: header),
          findsOneWidget,
        );
        expect(
          find.descendant(of: decoratedBox, matching: content),
          findsOneWidget,
        );
      },
    );
  });

  group("Grouped accordion", () {
    final Finder accordion1 = find.byKey(_firstAccordionKey);
    final Finder accordion2 = find.byKey(_secondAccordionKey);
    final Finder child1 = find.byKey(_firstAccordionChildKey);
    final Finder child2 = find.byKey(_secondAccordionChildKey);

    testWidgets("Group behavior works correctly", (tester) async {
      await tester.pumpWidget(const _GroupedAccordionTestWidget());

      expect(accordion1, findsOneWidget);
      expect(accordion2, findsOneWidget);
      expect(child1, findsOneWidget);
      expect(child2, findsNothing);

      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child1, findsNothing);
      expect(child2, findsOneWidget);

      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child1, findsNothing);
      expect(child2, findsNothing);
    });

    testWidgets(
      "When expansion changes, 'onExpansionChanged' callback is triggered",
      (tester) async {
        _AccordionItems? currentValue;

        await tester.pumpWidget(
          _GroupedAccordionTestWidget(
            onExpansionChanged: (value) => currentValue = value,
          ),
        );

        expect(accordion1, findsOneWidget);
        expect(accordion2, findsOneWidget);

        await tester.tap(accordion1);
        await tester.pumpAndSettle();

        expect(currentValue, equals(_AccordionItems.first));

        await tester.tap(accordion2);
        await tester.pumpAndSettle();

        expect(currentValue, equals(_AccordionItems.second));
      },
    );

    testWidgets("Grouped accordion handles rapid multiple taps", (
      tester,
    ) async {
      await tester.pumpWidget(const _GroupedAccordionTestWidget());

      await tester.tap(accordion1);
      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child1, findsNothing);
      expect(child2, findsOneWidget);
    });

    testWidgets(
      "All grouped accordions with identical 'identityValue' expand and collapse at the same time",
      (tester) async {
        await tester.pumpWidget(
          const _GroupedAccordionTestWidget(
            accordion2Identity: _AccordionItems.first,
          ),
        );

        expect(accordion1, findsOneWidget);
        expect(accordion2, findsOneWidget);
        expect(child1, findsOneWidget);
        expect(child2, findsOneWidget);

        await tester.tap(accordion1);
        await tester.pumpAndSettle();

        expect(child1, findsNothing);
        expect(child2, findsNothing);
      },
    );

    testWidgets("Grouped accordion handles null 'identityValue", (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: const [
                MoonRawAccordion<_AccordionItems>(
                  key: _firstAccordionKey,
                  groupIdentityValue: _AccordionItems.first,
                  header: Text(_accordionLabel),
                  children: [
                    Text(key: _firstAccordionChildKey, _accordionContent),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(accordion1);
      await tester.pumpAndSettle();

      expect(child1, findsOneWidget);
    });
  });
}

class _SingleAccordionTestWidget extends StatelessWidget {
  final bool enabled;
  final bool initiallyExpanded;
  final bool hasContentOutside;
  final Widget Function(BuildContext, Animation<double>)? trailingWidget;

  const _SingleAccordionTestWidget({
    this.enabled = true,
    this.initiallyExpanded = false,
    this.hasContentOutside = false,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawAccordion<_AccordionItems>(
          key: _singleAccordionKey,
          enabled: enabled,
          initiallyExpanded: initiallyExpanded,
          hasContentOutside: hasContentOutside,
          header: const Text(_accordionLabel),
          trailingWidget: trailingWidget,
          children: const [
            Text(key: _singleAccordionChildKey, _accordionContent),
          ],
        ),
      ),
    );
  }
}

class _GroupedAccordionTestWidget extends StatefulWidget {
  final ValueChanged<_AccordionItems>? onExpansionChanged;
  final _AccordionItems? accordion2Identity;

  const _GroupedAccordionTestWidget({
    this.onExpansionChanged,
    this.accordion2Identity = _AccordionItems.second,
  });

  @override
  State<_GroupedAccordionTestWidget> createState() =>
      _GroupedAccordionTestWidgetState();
}

class _GroupedAccordionTestWidgetState
    extends State<_GroupedAccordionTestWidget> {
  _AccordionItems? _currentlyOpenAccordionItem = _AccordionItems.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            MoonRawAccordion<_AccordionItems>(
              key: _firstAccordionKey,
              identityValue: _AccordionItems.first,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (_AccordionItems? value) =>
                  widget.onExpansionChanged != null
                  ? widget.onExpansionChanged?.call(
                      value ?? _AccordionItems.first,
                    )
                  : setState(() => _currentlyOpenAccordionItem = value),
              header: const Text(_accordionLabel),
              children: const [
                Text(key: _firstAccordionChildKey, _accordionContent),
              ],
            ),
            MoonRawAccordion<_AccordionItems>(
              key: _secondAccordionKey,
              identityValue: widget.accordion2Identity,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (_AccordionItems? value) =>
                  widget.onExpansionChanged != null
                  ? widget.onExpansionChanged?.call(
                      value ?? _AccordionItems.first,
                    )
                  : setState(() => _currentlyOpenAccordionItem = value),
              header: const Text(_accordionLabel),
              children: const [
                Text(key: _secondAccordionChildKey, _accordionContent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
