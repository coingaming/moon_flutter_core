import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_core/moon_core.dart';

const Key _textInputKey = Key("textInputKey");
const Key _submitButtonKey = Key("submitButtonKey");
const Key _clearButtonKey = Key("clearButtonKey");

const String _hintText = "Hint text";
const String _errorText = "Error text";
const String _customErrorText = "Custom error text";
const String _helperText = "Helper text";
const String _validInput = "Valid text";
const String _invalidInput = "Invalid text";
const IconData _textInputLeadingIcon = Icons.person;
const IconData _textInputTrailingIcon = Icons.close;

void main() {
  final Finder textInput = find.byKey(_textInputKey);
  final Finder editableText = find.byType(EditableText);
  final Finder submitButton = find.byKey(_submitButtonKey);
  final Finder clearButton = find.byKey(_clearButtonKey);

  final Finder hint = find.text(_hintText);
  final Finder validInput = find.text(_validInput);
  final Finder invalidInput = find.text(_invalidInput);
  final Finder error = find.text(_errorText);

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }

  group('Error state related tests', () {
    testWidgets(
        "When invalid text is entered and submitted, validation error is displayed",
        (tester) async {
      await tester.pumpWidget(
        const _TextInputTestWidget(),
      );

      await tester.enterText(textInput, _invalidInput);

      expect(invalidInput, findsOneWidget);

      await submit(tester);

      expect(error, findsOneWidget);
    });

    testWidgets(
        "When valid text is entered and submitted, validation error is not displayed",
        (tester) async {
      await tester.pumpWidget(
        const _TextInputTestWidget(),
      );

      await tester.enterText(textInput, _validInput);

      expect(validInput, findsOneWidget);

      await submit(tester);

      expect(error, findsNothing);
    });

    testWidgets(
        "Custom 'errorBuilder' is shown with correct error text when 'errorText' is not null",
        (tester) async {
      await tester.pumpWidget(
        _TextInputTestWidget(
          errorText: _customErrorText,
          errorBuilder: (BuildContext context, String? error) {
            return Text(
              error ?? '',
              style: const TextStyle(color: Colors.red),
            );
          },
        ),
      );

      final Finder customError = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data == _customErrorText &&
            widget.style!.color == Colors.red,
      );

      expect(customError, findsOneWidget);
    });

    testWidgets("Validator errors take precedence over 'errorText'",
        (tester) async {
      await tester.pumpWidget(
        _TextInputTestWidget(
          errorText: _customErrorText,
          errorBuilder: (BuildContext context, String? error) {
            return Text(
              error ?? '',
              style: const TextStyle(color: Colors.red),
            );
          },
        ),
      );

      final Finder customError = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data == _customErrorText &&
            widget.style!.color == Colors.red,
      );

      expect(customError, findsOneWidget);
      expect(error, findsNothing);
      await tester.enterText(textInput, _invalidInput);
      await tester.pump();
      await submit(tester);
      await tester.pumpAndSettle();

      expect(customError, findsNothing);
      expect(error, findsOneWidget);
    });
  });

  group("Visual appearance tests", () {
    testWidgets("Text input initializes with 'initialValue'", (tester) async {
      const String initialValueText = "Initial value";
      final Finder initialValue = find.text(initialValueText);

      await tester.pumpWidget(
        const _TextInputTestWidget(
          initialValue: initialValueText,
        ),
      );

      expect(initialValue, findsOneWidget);
    });

    testWidgets("Text input displays 'helper' widget if set to true",
        (tester) async {
      final Finder helper = find.text(_helperText);

      await tester.pumpWidget(
        const _TextInputTestWidget(
          showHelper: true,
        ),
      );

      expect(helper, findsOneWidget);
    });

    testWidgets("Text input displays 'hint' widget if set to true",
        (tester) async {
      final Finder hint = find.text(_hintText);

      await tester.pumpWidget(
        const _TextInputTestWidget(
          showHint: true,
        ),
      );

      expect(hint, findsOneWidget);
    });

    testWidgets(
        "Text input displays 'leading' and 'trailing' widget if set to true",
        (tester) async {
      final Finder leadingIcon = find.byIcon(_textInputLeadingIcon);
      final Finder trailingIcon = find.byIcon(_textInputTrailingIcon);

      await tester.pumpWidget(
        const _TextInputTestWidget(
          showLeading: true,
          showTrailing: true,
        ),
      );

      expect(leadingIcon, findsOneWidget);
      expect(trailingIcon, findsOneWidget);
    });

    testWidgets("Text input respects 'maxLength'", (tester) async {
      const int maxLength = 5;
      const String longText = "This is a long text";

      final Finder fullLengthText = find.text(longText);
      final Finder maxLengthText = find.text(longText.substring(0, maxLength));

      await tester.pumpWidget(
        const _TextInputTestWidget(
          maxLength: maxLength,
        ),
      );

      await tester.enterText(textInput, longText);
      await tester.pump();

      expect(maxLengthText, findsOneWidget);
      expect(fullLengthText, findsNothing);
    });

    testWidgets("Long press on text input opens the text selection toolbar",
        (tester) async {
      final Finder textSelectionToolbar =
          find.byType(AdaptiveTextSelectionToolbar);

      await tester.pumpWidget(
        const _TextInputTestWidget(),
      );

      expect(textSelectionToolbar, findsNothing);

      await tester.longPress(textInput);
      await tester.pumpAndSettle();

      expect(textSelectionToolbar, findsOneWidget);
    });

    testWidgets(
        "'textAlignVertical' aligns input and hint correctly based on its value",
        (WidgetTester tester) async {
      const double delta = 2;
      const List<TextAlignVertical> verticalAlignments = [
        TextAlignVertical.top,
        TextAlignVertical.center,
        TextAlignVertical.bottom,
      ];

      for (final verticalAlign in verticalAlignments) {
        await tester.pumpWidget(
          _TextInputTestWidget(
            textAlignVertical: verticalAlign,
            showHint: true,
          ),
        );

        await tester.pumpAndSettle();

        final hintTopDy = tester.getTopLeft(hint).dy;
        final hintCenterDy = tester.getCenter(hint).dy;
        final hintBottomDy = tester.getBottomLeft(hint).dy;

        final editableTopDy = tester.getTopLeft(editableText).dy;
        final editableCenterDy = tester.getCenter(editableText).dy;
        final editableBottomDy = tester.getBottomLeft(editableText).dy;

        final inputTopDy = tester.getTopLeft(textInput).dy;

        switch (verticalAlign) {
          case TextAlignVertical.top:
            expect(hintTopDy, closeTo(inputTopDy, delta));
            expect(editableTopDy, closeTo(inputTopDy, delta));
          case TextAlignVertical.center:
            expect(hintCenterDy, greaterThan(hintTopDy));
            expect(editableCenterDy, greaterThan(editableTopDy));
          case TextAlignVertical.bottom:
            expect(hintBottomDy, greaterThan(hintCenterDy));
            expect(editableBottomDy, greaterThan(editableCenterDy));
        }
      }
    });

    testWidgets(
        "'textAlign' aligns input and hint correctly based on its value",
        (WidgetTester tester) async {
      const double delta = 1;
      const List<TextAlign> textAlignments = [
        TextAlign.start,
        TextAlign.center,
        TextAlign.end,
      ];

      for (final textAlign in textAlignments) {
        await tester.pumpWidget(
          _TextInputTestWidget(
            textAlign: textAlign,
            showHint: true,
          ),
        );

        await tester.pumpAndSettle();

        final RenderBox textRenderBox = tester.renderObject(textInput);
        final double inputOffsetDx =
            textRenderBox.localToGlobal(Offset.zero).dx;
        final double inputWidth = textRenderBox.size.width;

        final double hintStartDx = tester.getTopLeft(hint).dx;
        final double hintCenterDx = tester.getCenter(hint).dx;
        final double hintEndDx = tester.getTopRight(hint).dx;

        final double editableStartDx = tester.getTopLeft(editableText).dx;
        final double editableCenterDx = tester.getCenter(editableText).dx;
        final double editableEndDx = tester.getTopRight(editableText).dx;

        final double inputEndOffsetDx = inputOffsetDx + inputWidth;

        switch (textAlign) {
          case TextAlign.start:
            expect(editableStartDx, closeTo(inputOffsetDx, delta));
            expect(hintStartDx, closeTo(inputOffsetDx, delta));
          case TextAlign.center:
            expect(editableCenterDx, closeTo(inputEndOffsetDx / 2, delta));
            expect(hintCenterDx, closeTo(inputEndOffsetDx / 2, delta));
          case TextAlign.end:
            expect(editableEndDx, closeTo(inputEndOffsetDx, delta));
            expect(hintEndDx, closeTo(inputEndOffsetDx, delta));
          default:
        }
      }
    });
  });

  group('Callback related tests', () {
    testWidgets("'onChanged' callback is triggered", (tester) async {
      String? changedText;

      await tester.pumpWidget(
        _TextInputTestWidget(
          onChanged: (text) => changedText = text,
        ),
      );

      await tester.enterText(textInput, _validInput);
      await tester.pump();

      expect(changedText, _validInput);
    });

    testWidgets("'onSubmitted' callback is triggered", (tester) async {
      String? submittedText;

      await tester.pumpWidget(
        _TextInputTestWidget(
          onSubmitted: (text) => submittedText = text,
        ),
      );

      await tester.enterText(textInput, _validInput);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedText, _validInput);
    });

    testWidgets("'onTap' callback is triggered", (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        _TextInputTestWidget(
          onTap: () => tapped = true,
        ),
      );

      await tester.tap(textInput);
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets("'onTapOutside' callback is triggered", (tester) async {
      bool tappedOutside = false;

      await tester.pumpWidget(
        _TextInputTestWidget(
          onTapOutside: (PointerDownEvent event) => tappedOutside = true,
        ),
      );

      await tester.tapAt(tester.getCenter(textInput));
      await tester.pump();
      await tester.tapAt(Offset.zero);

      expect(tappedOutside, isTrue);
    });
  });

  group('Miscellaneous tests', () {
    testWidgets("When text input is 'disabled', input can not be entered",
        (tester) async {
      await tester.pumpWidget(
        const _TextInputTestWidget(
          enabled: false,
        ),
      );
      expect(validInput, findsNothing);

      await tester.enterText(textInput, _validInput);

      expect(validInput, findsNothing);
    });

    testWidgets("Text input is read-only if 'readOnly' is set to true",
        (tester) async {
      await tester.pumpWidget(
        const _TextInputTestWidget(
          readOnly: true,
        ),
      );

      await tester.enterText(textInput, _validInput);
      await tester.pump();

      expect(validInput, findsNothing);
    });

    testWidgets("Text input can gain and lose focus", (tester) async {
      final FocusNode focusNode = FocusNode();

      await tester.pumpWidget(
        _TextInputTestWidget(
          focusNode: focusNode,
        ),
      );

      expect(focusNode.hasFocus, isFalse);

      await tester.tap(textInput);
      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets("Text input can be cleared", (tester) async {
      await tester.pumpWidget(
        const _TextInputTestWidget(
          showTrailing: true,
        ),
      );

      await tester.enterText(textInput, _validInput);
      await tester.pump();

      expect(validInput, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump();

      expect(validInput, findsNothing);
    });

    testWidgets("Passed in 'controller' works as expected", (tester) async {
      final TextEditingController controller = TextEditingController();

      await tester.pumpWidget(
        _TextInputTestWidget(textEditingController: controller),
      );

      await tester.enterText(textInput, _validInput);
      await tester.pump();

      expect(controller.text, _validInput);

      controller.text = _invalidInput;

      expect(invalidInput, findsOneWidget);
    });
  });
}

class _TextInputTestWidget extends StatelessWidget {
  final bool enabled;
  final bool readOnly;
  final bool showHelper;
  final bool showHint;
  final bool showLeading;
  final bool showTrailing;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? errorText;
  final TextEditingController? textEditingController;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onTap;
  final Widget Function(BuildContext, String?)? errorBuilder;

  const _TextInputTestWidget({
    this.enabled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.showHelper = false,
    this.showHint = false,
    this.showLeading = false,
    this.showTrailing = false,
    this.maxLength,
    this.initialValue,
    this.errorText,
    this.textEditingController,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MoonRawFormTextInput(
                    key: _textInputKey,
                    textInputConfiguration: MoonTextInputConfiguration(
                      enabled: enabled,
                      initialValue: initialValue,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      maxLength: maxLength,
                      readOnly: readOnly,
                      focusNode: focusNode,
                      errorText: errorText,
                      controller: textEditingController,
                      onTap: onTap,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      onTapOutside: onTapOutside,
                      errorBuilder: errorBuilder,
                      helper: const Text(_helperText),
                      hint: showHint ? const Text(_hintText) : null,
                      leading: showLeading
                          ? const Icon(_textInputLeadingIcon)
                          : null,
                      trailing: showTrailing
                          ? IconButton(
                              key: _clearButtonKey,
                              icon: const Icon(_textInputTrailingIcon),
                              onPressed: () => Form.of(context).reset(),
                            )
                          : null,
                    ),
                    validator: (String? value) =>
                        value != null && value.length > 10 ? _errorText : null,
                  ),
                  MoonBaseInteractiveWidget(
                    key: _submitButtonKey,
                    onTap: () => Form.of(context).validate(),
                    child: const Text("Submit"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
