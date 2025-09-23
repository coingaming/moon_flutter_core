import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

const String _validatorErrorMessage = "Validator error message";
const String _providedErrorMessage = "Provided error message";

void main() {
  final Finder textInput = find.byType(TextFormField);
  final Finder inputBox = find.byType(Box);
  final Finder validatorErrorMessage = find.text(_validatorErrorMessage);

  testWidgets("MoonRawAuthCode initializes with correct input length", (
    tester,
  ) async {
    await tester.pumpWidget(const _AuthCodeTestWidget(inputFieldCount: 3));

    expect(textInput, findsOneWidget);
    expect(inputBox, findsNWidgets(3));
  });

  testWidgets("Input is updated and rendered correctly", (tester) async {
    await tester.pumpWidget(const _AuthCodeTestWidget(inputFieldCount: 4));

    await tester.enterText(textInput, "1234");
    await tester.pump();

    expect(find.text("1"), findsOneWidget);
    expect(find.text("2"), findsOneWidget);
    expect(find.text("3"), findsOneWidget);
    expect(find.text("5"), findsNothing);
    expect(inputBox, findsNWidgets(4));
  });

  testWidgets("When valid code is entered, error message is not shown", (
    tester,
  ) async {
    await tester.pumpWidget(const _AuthCodeTestWidget());

    await tester.enterText(textInput, "1234");
    await tester.pump();

    expect(validatorErrorMessage, findsNothing);
  });

  testWidgets("When invalid code is entered, error message is shown", (
    tester,
  ) async {
    await tester.pumpWidget(const _AuthCodeTestWidget());

    await tester.enterText(textInput, "1111");
    await tester.pump();

    expect(validatorErrorMessage, findsOneWidget);
  });

  testWidgets("Validator errors take precedence over the provided errorText", (
    tester,
  ) async {
    final Finder providedErrorMessage = find.text(_providedErrorMessage);

    await tester.pumpWidget(
      const _AuthCodeTestWidget(providedErrorMessage: _providedErrorMessage),
    );

    expect(providedErrorMessage, findsOneWidget);

    await tester.enterText(textInput, "1111");
    await tester.pump();

    expect(providedErrorMessage, findsNothing);
    expect(validatorErrorMessage, findsOneWidget);
  });

  testWidgets("'onCompleted' callback is called with correct value", (
    tester,
  ) async {
    String? completedCode;

    await tester.pumpWidget(
      _AuthCodeTestWidget(onCompleted: (String value) => completedCode = value),
    );

    await tester.enterText(textInput, "1111");
    await tester.pump(const Duration(milliseconds: 200));

    expect(completedCode, equals("1111"));
  });

  testWidgets("'onCompleted' callback is not called for empty input", (
    tester,
  ) async {
    String? completedCode;

    await tester.pumpWidget(
      _AuthCodeTestWidget(onCompleted: (String value) => completedCode = value),
    );

    await tester.enterText(textInput, "");
    await tester.pump();

    expect(completedCode, isNull);
  });

  testWidgets("'onChanged' callback is called when input changes", (
    tester,
  ) async {
    String? enteredText;

    await tester.pumpWidget(
      _AuthCodeTestWidget(onChanged: (String value) => enteredText = value),
    );

    await tester.enterText(textInput, "1");
    await tester.pump();

    expect(enteredText, equals("1"));

    await tester.enterText(textInput, "2");
    await tester.pump();

    expect(enteredText, equals("2"));
  });

  testWidgets(
    "Peeking is applied when 'obscureText' and 'peekWhenObscuring' are true",
    (tester) async {
      const Duration customPeekDuration = Duration(milliseconds: 500);

      await tester.pumpWidget(
        const _AuthCodeTestWidget(
          obscureText: true,
          peekWhenObscuring: true,
          peekDuration: customPeekDuration,
        ),
      );

      await tester.enterText(textInput, "9");

      expect(find.text("9"), findsOneWidget);
      expect(find.text("•"), findsNothing);

      await tester.pump(customPeekDuration);

      expect(find.text("•"), findsOneWidget);
    },
  );

  testWidgets("Peeking does not occur when 'peekWhenObscuring' is false", (
    tester,
  ) async {
    await tester.pumpWidget(const _AuthCodeTestWidget(obscureText: true));
    await tester.enterText(textInput, "9");

    await tester.pump();

    expect(find.text("•"), findsOneWidget);
  });

  testWidgets("Input length limit is enforced", (tester) async {
    await tester.pumpWidget(const _AuthCodeTestWidget(inputFieldCount: 4));

    await tester.enterText(find.byType(TextFormField), "123456");
    await tester.pump();

    expect(inputBox, findsNWidgets(4));
    expect(find.text("1234"), findsOneWidget);
    expect(find.text("123456"), findsNothing);
  });
}

class _AuthCodeTestWidget extends StatelessWidget {
  final bool obscureText;
  final bool peekWhenObscuring;
  final Duration? peekDuration;
  final int? inputFieldCount;
  final String? providedErrorMessage;
  final String Function(String)? onCompleted;
  final String Function(String)? onChanged;

  const _AuthCodeTestWidget({
    this.obscureText = false,
    this.peekWhenObscuring = false,
    this.peekDuration,
    this.inputFieldCount,
    this.providedErrorMessage,
    this.onCompleted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonRawAuthCode(
          obscureText: obscureText,
          peekWhenObscuring: peekWhenObscuring,
          peekDuration: peekDuration ?? const Duration(seconds: 1),
          authInputFieldCount: inputFieldCount ?? 4,
          errorText: providedErrorMessage,
          onCompleted: onCompleted,
          onChanged: onChanged,
          validator: (String? pin) =>
              pin?.length == 4 && pin != "1234" ? _validatorErrorMessage : null,
          errorBuilder: (BuildContext _, String? errorText) =>
              Text(errorText ?? ""),
        ),
      ),
    );
  }
}
