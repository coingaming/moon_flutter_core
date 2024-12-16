import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

enum _Choice { first, second }

const Key _firstRadioKey = Key("firstRadioKey");
const Key _secondRadioKey = Key("secondRadioKey");

void main() {
  final Finder firstWidget = find.byKey(_firstRadioKey);
  final Finder secondWidget = find.byKey(_secondRadioKey);

  final Finder firstWidgetSelected = find.byWidgetPredicate(
    (Widget widget) =>
        widget is MoonBaseSingleSelectWidget &&
        widget.key == _firstRadioKey &&
        widget.value == widget.groupValue,
  );

  final Finder secondWidgetSelected = find.byWidgetPredicate(
    (Widget widget) =>
        widget is MoonBaseSingleSelectWidget &&
        widget.key == _secondRadioKey &&
        widget.value == widget.groupValue,
  );

  testWidgets("Single select widgets initialize with correct values",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(),
    );

    expect(firstWidget, findsOneWidget);
    expect(secondWidget, findsOneWidget);
    expect(firstWidgetSelected, findsNothing);
    expect(secondWidgetSelected, findsNothing);
  });

  testWidgets("The selection of single select widgets can be changed",
      (tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(),
    );

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsOneWidget);

    await tester.tap(secondWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsNothing);
    expect(secondWidgetSelected, findsOneWidget);

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsOneWidget);
    expect(secondWidgetSelected, findsNothing);
  });

  testWidgets("Single select widget is 'toggleable'",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(
        toggleable: true,
      ),
    );

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsOneWidget);

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsNothing);
  });

  testWidgets(
      "Widget remains selected if its 'groupValue' always matches its value",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(
        firstWidgetGroupValue: _Choice.first,
      ),
    );

    expect(firstWidgetSelected, findsOneWidget);
    expect(secondWidgetSelected, findsNothing);

    await tester.tap(secondWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsOneWidget);
    expect(secondWidgetSelected, findsOneWidget);
  });

  testWidgets(
      "Widget is not selectable if its 'groupValue' never matches its 'value'",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(
        firstWidgetGroupValue: _Choice.second,
      ),
    );

    expect(firstWidgetSelected, findsNothing);
    expect(secondWidgetSelected, findsNothing);

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsNothing);
    expect(secondWidgetSelected, findsNothing);
  });

  testWidgets("Single select widget is disabled when 'onChanged' is null",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(
        customOnChanged: true,
      ),
    );

    await tester.tap(firstWidget);
    await tester.pumpAndSettle();

    expect(firstWidgetSelected, findsNothing);
  });

  testWidgets(
      "Single select widget calls 'onChanged' callback with correct value",
      (WidgetTester tester) async {
    _Choice? selectedValue;

    await tester.pumpWidget(
      _BaseSingleSelectTestWidget(
        customOnChanged: true,
        onChanged: (_Choice? choice) => selectedValue = choice,
      ),
    );

    await tester.tap(secondWidget);
    await tester.pumpAndSettle();

    expect(selectedValue, _Choice.second);
  });

  testWidgets("Single select widget has correct semantic label",
      (WidgetTester tester) async {
    const String firstSemanticLabel = "First widget";
    const String secondSemanticLabel = "Second widget";

    await tester.pumpWidget(
      const _BaseSingleSelectTestWidget(
        firstWidgetSemanticLabel: firstSemanticLabel,
        secondWidgetSemanticLabel: secondSemanticLabel,
      ),
    );

    final Finder firstWidgetWithSemanticLabel =
        find.bySemanticsLabel(firstSemanticLabel);
    final Finder secondWidgetWithSemanticLabel =
        find.bySemanticsLabel(secondSemanticLabel);

    expect(firstWidgetWithSemanticLabel, findsOneWidget);
    expect(secondWidgetWithSemanticLabel, findsOneWidget);
  });
}

class _BaseSingleSelectTestWidget extends StatefulWidget {
  final bool toggleable;
  final bool customOnChanged;
  final _Choice? firstWidgetGroupValue;
  final String? firstWidgetSemanticLabel;
  final String? secondWidgetSemanticLabel;
  final void Function(_Choice?)? onChanged;

  const _BaseSingleSelectTestWidget({
    this.toggleable = false,
    this.customOnChanged = false,
    this.firstWidgetGroupValue,
    this.firstWidgetSemanticLabel,
    this.secondWidgetSemanticLabel,
    this.onChanged,
  });

  @override
  State<_BaseSingleSelectTestWidget> createState() =>
      _BaseSingleSelectTestWidgetState();
}

class _BaseSingleSelectTestWidgetState
    extends State<_BaseSingleSelectTestWidget> {
  _Choice? _value;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MoonBaseSingleSelectWidget(
              key: _firstRadioKey,
              semanticLabel: widget.firstWidgetSemanticLabel,
              toggleable: widget.toggleable,
              value: _Choice.first,
              groupValue: widget.firstWidgetGroupValue ?? _value,
              onChanged: widget.customOnChanged
                  ? widget.onChanged
                  : (_Choice? choice) => setState(() => _value = choice),
              child: const Text("First"),
            ),
            MoonBaseSingleSelectWidget(
              key: _secondRadioKey,
              semanticLabel: widget.secondWidgetSemanticLabel,
              toggleable: widget.toggleable,
              value: _Choice.second,
              groupValue: _value,
              onChanged: widget.customOnChanged
                  ? widget.onChanged
                  : (_Choice? choice) => setState(() => _value = choice),
              child: const Text("Second"),
            ),
          ],
        ),
      ),
    );
  }
}
