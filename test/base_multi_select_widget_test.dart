import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

void main() {
  final Finder checkbox = find.byType(MoonBaseMultiSelectWidget);

  testWidgets("Multi select widget initializes with the correct value",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseMultiSelectTestWidget(
        value: true,
      ),
    );

    final checkboxWidget = tester.widget<MoonBaseMultiSelectWidget>(checkbox);

    expect(checkboxWidget.value, true);
  });

  testWidgets("Multi select widget changes state when tapped",
      (WidgetTester tester) async {
    bool? checkboxValue = false;

    await tester.pumpWidget(
      _BaseMultiSelectTestWidget(
        onChanged: (value) => checkboxValue = value,
      ),
    );

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, true);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, false);
  });

  testWidgets(
      "Multi select widget cycles through 'tristate' values when tapped and 'tristate' is set to true",
      (WidgetTester tester) async {
    bool? checkboxValue = false;

    await tester.pumpWidget(
      _BaseMultiSelectTestWidget(
        isTristate: true,
        onChanged: (value) => checkboxValue = value,
      ),
    );

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, true);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, null);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, false);
  });

  testWidgets("Multi select widget is disabled when 'onChanged' is null",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const _BaseMultiSelectTestWidget(
        customOnChangedValue: true,
      ),
    );

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    final Finder checkboxIsChecked = find.byWidgetPredicate(
      (widget) => widget is MoonBaseMultiSelectWidget && widget.value == true,
    );

    expect(checkboxIsChecked, findsNothing);
  });

  testWidgets(
      "Multi select widget calls 'onChanged' callback with correct value",
      (WidgetTester tester) async {
    bool? selectedValue;

    await tester.pumpWidget(
      _BaseMultiSelectTestWidget(
        customOnChangedValue: true,
        value: true,
        onChanged: (bool? value) => selectedValue = value,
      ),
    );

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(selectedValue, false);
  });

  testWidgets("Multi select widget has the correct semantic label",
      (WidgetTester tester) async {
    const String semanticLabel = "Test Semantic Label";

    await tester.pumpWidget(
      const _BaseMultiSelectTestWidget(
        semanticLabel: semanticLabel,
      ),
    );

    final Finder checkBoxWithSemanticLabel =
        find.bySemanticsLabel(semanticLabel);

    expect(checkBoxWithSemanticLabel, findsOneWidget);
  });
}

class _BaseMultiSelectTestWidget extends StatefulWidget {
  final bool? value;
  final bool customOnChangedValue;
  final bool isTristate;
  final String? semanticLabel;
  final void Function(bool?)? onChanged;

  const _BaseMultiSelectTestWidget({
    this.value = false,
    this.customOnChangedValue = false,
    this.isTristate = false,
    this.semanticLabel,
    this.onChanged,
  });

  @override
  State<_BaseMultiSelectTestWidget> createState() =>
      _BaseMultiSelectTestWidgetState();
}

class _BaseMultiSelectTestWidgetState
    extends State<_BaseMultiSelectTestWidget> {
  bool? _checkboxValue = false;

  @override
  void initState() {
    super.initState();

    _checkboxValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonBaseMultiSelectWidget(
          semanticLabel: widget.semanticLabel,
          tristate: widget.isTristate,
          value: _checkboxValue,
          onChanged: widget.customOnChangedValue
              ? widget.onChanged
              : (bool? newValue) {
                  setState(() => _checkboxValue = newValue);
                  widget.onChanged?.call(newValue);
                },
          child: const Icon(Icons.remove),
        ),
      ),
    );
  }
}
