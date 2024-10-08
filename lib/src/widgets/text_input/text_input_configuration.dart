import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix/mix.dart';

typedef MoonTextInputErrorBuilder = Widget Function(
  BuildContext context,
  String? errorText,
);

class MoonTextInputConfiguration {
  /// If [maxLength] is set to this value, only the "current input length" part
  /// of the character counter is displayed.
  static const int noMaxLength = -1;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // Moon Design System properties.
  /// Whether the text input has floating label.
  final bool hasFloatingLabel;

  /// The vertical offset applied to the input text. Provides more detailed
  /// control over text input positioning.
  final double inputTextVerticalOffsetValue;

  /// Scale value for floating label animation.
  final double floatingLabelScaleValue;

  /// The duration of the text input transition animation.
  final Duration? transitionDuration;

  /// The curve of the text input transition animation.
  final Curve? transitionCurve;

  /// A builder to build the text input error widget.
  final MoonTextInputErrorBuilder? errorBuilder;

  /// The error text can be used to force text input into an error state
  /// (useful for asynchronous errors).
  ///
  /// The validator errors take precedence over the provided [errorText].
  final String? errorText;

  /// The initial value of the text input. If [controller] is provided,
  /// this value is ignored and [controller]'s value is used.
  final String? initialValue;

  /// The style of the text input container.
  final Style? inputStyle;

  /// The style of the helper/error container.
  final Style? helperStyle;

  /// The widget to display before the text input.
  final Widget? leading;

  /// The widget to display after the text input.
  final Widget? trailing;

  /// The widget to display below the text input. Not displayed in error state.
  final Widget? helper;

  /// The widget to display as the hint text.
  final Widget? hint;

  // Flutter properties.
  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Determines whether this text field can request the primary focus.
  ///
  /// Defaults to true. If false, the text field will not request focus
  /// when tapped, or when its context menu is displayed. If false it will not
  /// be possible to move the focus to the text field with tab key.
  final bool canRequestFocus;

  /// {@macro flutter.widgets.editableText.cursorOpacityAnimates}
  final bool? cursorOpacityAnimates;

  /// If false the text field is "disabled".
  final bool enabled;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// Whether [onTap] should be called for every tap.
  ///
  /// Defaults to false, so [onTap] is only called for each distinct tap.
  /// When enabled, [onTap] is called for every tap including consecutive taps.
  final bool onTapAlwaysCalled;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  /// If unset, defaults to [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// The color of the cursor.
  ///
  /// The cursor indicates the current location of text insertion point in
  /// the field.
  final Color? cursorColor;

  /// The color of the cursor when the input is showing an error.
  final Color? cursorErrorColor;

  /// {@macro flutter.widgets.editableText.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.EditableText.contextMenuBuilder}
  ///
  /// If not provided, will build a default menu based on the platform.
  ///
  /// See also:
  ///
  ///  * [AdaptiveTextSelectionToolbar], which is built by default.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that is typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it is not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@template flutter.material.textfield.onTap}
  /// Called for the first tap in a series of taps.
  ///
  /// The text field builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the text field with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the text field's
  /// internal gesture detector, provide this callback.
  ///
  /// If the text field is created with [enabled] false, taps will not be
  /// recognized.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// text field's internal gesture detector, use a [Listener].
  /// {@endtemplate}
  ///
  /// If [onTapAlwaysCalled] is enabled, this will also be called for
  /// consecutive taps.
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.maxLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? minLines;

  /// The maximum number of characters (unicode grapheme clusters) to allow in
  /// the text field.
  ///
  /// If set, a character counter will be displayed below the field showing how
  /// many characters have been entered. If set to a number greater than 0, it
  /// will also display the maximum number allowed.
  /// If set to [MoonTextInput.noMaxLength] then only the current character
  /// count is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  ///
  /// The text field enforces the length with a[LengthLimitingTextInputFormatter],
  /// which is evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null, [MoonTextInput.noMaxLength], or greater
  /// than 0. If null (the default) then there is no limit to the number of
  /// characters that can be entered. If set to [MoonTextInput.noMaxLength],
  /// then no limit will be enforced, but the number of characters entered will
  /// still be displayed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// If [maxLengthEnforcement] is [MaxLengthEnforcement.none], then more than
  /// [maxLength] characters may be entered, but the error counter and divider
  /// will switch to the [decoration]'s [InputDecoration.errorStyle] when the
  /// limit is exceeded.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Determines how the [maxLength] limit should be enforced.
  ///
  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  final MouseCursor? mouseCursor;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType smartQuotesType;

  /// {@macro flutter.widgets.EditableText.spellCheckConfiguration}
  ///
  /// If [SpellCheckConfiguration.misspelledTextStyle] is not specified in this
  /// configuration, then [materialMisspelledTextStyle] is used by default.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// If non-null, the text field will persist and restore its current scroll
  /// offset and - if no [controller] has been provided - the content of the
  /// text field. If a [controller] has been provided, it is the responsibility
  /// of the owner of that controller to persist and restore it, e.g. by using
  /// a [RestorableTextEditingController].
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  /// {@endtemplate}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.onTapOutside}
  ///
  /// {@tool dartpad}
  /// This example shows how to use a 'TextFieldTapRegion' to wrap a set of
  /// "spinner" buttons that increment and decrement a value in the
  /// [MoonTextInput] without causing the text field to lose keyboard focus.
  ///
  /// This example includes a generic 'SpinnerField<T>' class that you can copy
  /// into your own project and customize.
  ///
  /// ** See code in examples/api/lib/widgets/tap_region/text_field_tap_region.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [TapRegion] for how the region group is determined.
  final TapRegionCallback? onTapOutside;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// Controls the input text.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// {@template flutter.widgets.TextField.textInputAction}
  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  /// {@endtemplate}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// {@macro flutter.widgets.magnifier.TextMagnifierConfiguration.intro}
  ///
  /// {@macro flutter.widgets.magnifier.intro}
  ///
  /// {@macro flutter.widgets.magnifier.TextMagnifierConfiguration.details}
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier]
  /// on Android, and builds nothing on all other platforms. If it is desired to
  /// suppress the magnifier, consider passing
  /// [TextMagnifierConfiguration.disabled].
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to customize the magnifier that this text
  /// field uses.
  ///
  /// ** See code in examples/api/lib/widgets/text_magnifier/text_magnifier.0.dart **
  /// {@end-tool}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// The text style of the input text.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to 'titleMedium' text style from the current [Theme].
  final TextStyle? style;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// {@macro flutter.widgets.undoHistory.controller}
  final UndoHistoryController? undoController;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  const MoonTextInputConfiguration({
    // Moon Design System properties.
    this.hasFloatingLabel = false,
    this.inputTextVerticalOffsetValue = 0,
    this.floatingLabelScaleValue = 0.75,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.errorBuilder,
    this.errorText,
    this.initialValue,
    this.inputStyle,
    this.helperStyle,
    this.leading,
    this.trailing,
    this.helper,
    this.hint,

    // Flutter properties.
    this.onAppPrivateCommand,
    this.autocorrect = true,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.cursorOpacityAnimates,
    this.enabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.obscureText = false,
    this.onTapAlwaysCalled = false,
    this.readOnly = false,
    this.scribbleEnabled = true,
    this.showCursor,
    this.keyboardAppearance,
    this.clipBehavior = Clip.hardEdge,
    this.cursorColor = Colors.black,
    this.cursorErrorColor = Colors.red,
    this.contentInsertionConfiguration,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.focusNode,
    this.onTap,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofillHints = const <String>[],
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.mouseCursor,
    this.cursorRadius,
    this.scrollPhysics,
    this.scrollController,
    this.spellCheckConfiguration,
    this.obscuringCharacter = '•',
    this.restorationId,
    this.strutStyle,
    this.onTapOutside,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.controller,
    this.textInputAction,
    this.magnifierConfiguration,
    this.selectionControls,
    this.style = const TextStyle(fontSize: 14),
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.undoController,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    bool? enableInteractiveSelection,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    TextInputType? keyboardType,
  })  : enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        assert(maxLength == null || maxLength == noMaxLength || maxLength > 0),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "MinLines can't be greater than maxLines.",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'MinLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        // Ensure no unexpected changes occur in the users set value.
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using '
          'TextInputAction.newline on a multiline MoonTextInput.',
        ),
        assert(
          !hasFloatingLabel || !expands,
          'Expandable text input cannot have a floating label.',
        );

  MoonTextInputConfiguration copyWith({
    AppPrivateCommandCallback? onAppPrivateCommand,
    bool? autocorrect,
    bool? autofocus,
    bool? canRequestFocus,
    bool? cursorOpacityAnimates,
    bool? enabled,
    bool? enableIMEPersonalizedLearning,
    bool? enableSuggestions,
    bool? enableInteractiveSelection,
    bool? expands,
    bool? hasFloatingLabel,
    bool? obscureText,
    bool? onTapAlwaysCalled,
    bool? readOnly,
    bool? scribbleEnabled,
    bool? showCursor,
    Brightness? keyboardAppearance,
    Clip? clipBehavior,
    Color? cursorColor,
    Color? cursorErrorColor,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    Curve? transitionCurve,
    double? inputTextVerticalOffsetValue,
    double? floatingLabelScaleValue,
    double? cursorHeight,
    double? cursorWidth,
    DragStartBehavior? dragStartBehavior,
    Duration? transitionDuration,
    EdgeInsets? scrollPadding,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    FocusNode? focusNode,
    GestureTapCallback? onTap,
    int? maxLength,
    int? maxLines,
    int? minLines,
    List<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    MaxLengthEnforcement? maxLengthEnforcement,
    MouseCursor? mouseCursor,
    Radius? cursorRadius,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    SpellCheckConfiguration? spellCheckConfiguration,
    String? errorText,
    String? initialValue,
    String? obscuringCharacter,
    String? restorationId,
    StrutStyle? strutStyle,
    Style? helperStyle,
    Style? inputStyle,
    TapRegionCallback? onTapOutside,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    TextCapitalization? textCapitalization,
    TextDirection? textDirection,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    TextMagnifierConfiguration? magnifierConfiguration,
    TextSelectionControls? selectionControls,
    TextStyle? style,
    ui.BoxHeightStyle? selectionHeightStyle,
    ui.BoxWidthStyle? selectionWidthStyle,
    UndoHistoryController? undoController,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onEditingComplete,
    Widget Function(BuildContext, String?)? errorBuilder,
    Widget? helper,
    Widget? hint,
    Widget? leading,
    Widget? trailing,
  }) {
    return MoonTextInputConfiguration(
      autocorrect: autocorrect ?? this.autocorrect,
      autofillHints: autofillHints ?? this.autofillHints,
      autofocus: autofocus ?? this.autofocus,
      canRequestFocus: canRequestFocus ?? this.canRequestFocus,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      contentInsertionConfiguration:
          contentInsertionConfiguration ?? this.contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder ?? this.contextMenuBuilder,
      controller: controller ?? this.controller,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      enabled: enabled ?? this.enabled,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      errorText: errorText ?? this.errorText,
      expands: expands ?? this.expands,
      inputTextVerticalOffsetValue:
          inputTextVerticalOffsetValue ?? this.inputTextVerticalOffsetValue,
      floatingLabelScaleValue:
          floatingLabelScaleValue ?? this.floatingLabelScaleValue,
      focusNode: focusNode ?? this.focusNode,
      hasFloatingLabel: hasFloatingLabel ?? this.hasFloatingLabel,
      helper: helper ?? this.helper,
      helperStyle: helperStyle ?? this.helperStyle,
      hint: hint ?? this.hint,
      initialValue: initialValue ?? this.initialValue,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      inputStyle: inputStyle ?? this.inputStyle,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      keyboardType: keyboardType ?? this.keyboardType,
      leading: leading ?? this.leading,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      maxLength: maxLength ?? this.maxLength,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      obscureText: obscureText ?? this.obscureText,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      onAppPrivateCommand: onAppPrivateCommand ?? this.onAppPrivateCommand,
      onChanged: onChanged ?? this.onChanged,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onTap: onTap ?? this.onTap,
      onTapAlwaysCalled: onTapAlwaysCalled ?? this.onTapAlwaysCalled,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      readOnly: readOnly ?? this.readOnly,
      restorationId: restorationId ?? this.restorationId,
      scribbleEnabled: scribbleEnabled ?? this.scribbleEnabled,
      scrollController: scrollController ?? this.scrollController,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      selectionControls: selectionControls ?? this.selectionControls,
      selectionHeightStyle: selectionHeightStyle ?? this.selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle ?? this.selectionWidthStyle,
      showCursor: showCursor ?? this.showCursor,
      smartDashesType: smartDashesType ?? this.smartDashesType,
      smartQuotesType: smartQuotesType ?? this.smartQuotesType,
      spellCheckConfiguration:
          spellCheckConfiguration ?? this.spellCheckConfiguration,
      strutStyle: strutStyle ?? this.strutStyle,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textDirection: textDirection ?? this.textDirection,
      textInputAction: textInputAction ?? this.textInputAction,
      trailing: trailing ?? this.trailing,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      undoController: undoController ?? this.undoController,
    );
  }
}

void textInputDebugFillProperties(
  DiagnosticPropertiesBuilder properties,
  MoonTextInputConfiguration textInputConfiguration,
) {
  properties.add(
    DiagnosticsProperty<TextEditingController>(
      'controller',
      textInputConfiguration.controller,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<FocusNode>(
      'focusNode',
      textInputConfiguration.focusNode,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<UndoHistoryController>(
      'undoController',
      textInputConfiguration.undoController,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'enabled',
      textInputConfiguration.enabled,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<TextInputType>(
      'keyboardType',
      textInputConfiguration.keyboardType,
      defaultValue: TextInputType.text,
    ),
  );
  properties.add(
    DiagnosticsProperty<TextStyle>(
      'style',
      textInputConfiguration.style,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'autofocus',
      textInputConfiguration.autofocus,
      defaultValue: false,
    ),
  );
  properties.add(
    DiagnosticsProperty<String>(
      'obscuringCharacter',
      textInputConfiguration.obscuringCharacter,
      defaultValue: '•',
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'obscureText',
      textInputConfiguration.obscureText,
      defaultValue: false,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'autocorrect',
      textInputConfiguration.autocorrect,
      defaultValue: true,
    ),
  );
  properties.add(
    EnumProperty<SmartDashesType>(
      'smartDashesType',
      textInputConfiguration.smartDashesType,
      defaultValue: textInputConfiguration.obscureText
          ? SmartDashesType.disabled
          : SmartDashesType.enabled,
    ),
  );
  properties.add(
    EnumProperty<SmartQuotesType>(
      'smartQuotesType',
      textInputConfiguration.smartQuotesType,
      defaultValue: textInputConfiguration.obscureText
          ? SmartQuotesType.disabled
          : SmartQuotesType.enabled,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'enableSuggestions',
      textInputConfiguration.enableSuggestions,
      defaultValue: true,
    ),
  );
  properties.add(
    IntProperty(
      'maxLines',
      textInputConfiguration.maxLines,
      defaultValue: 1,
    ),
  );
  properties.add(
    IntProperty(
      'minLines',
      textInputConfiguration.minLines,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'expands',
      textInputConfiguration.expands,
      defaultValue: false,
    ),
  );
  properties.add(
    IntProperty(
      'maxLength',
      textInputConfiguration.maxLength,
      defaultValue: null,
    ),
  );
  properties.add(
    EnumProperty<MaxLengthEnforcement>(
      'maxLengthEnforcement',
      textInputConfiguration.maxLengthEnforcement,
      defaultValue: null,
    ),
  );
  properties.add(
    EnumProperty<TextInputAction>(
      'textInputAction',
      textInputConfiguration.textInputAction,
      defaultValue: null,
    ),
  );
  properties.add(
    EnumProperty<TextCapitalization>(
      'textCapitalization',
      textInputConfiguration.textCapitalization,
      defaultValue: TextCapitalization.none,
    ),
  );
  properties.add(
    EnumProperty<TextAlign>(
      'textAlign',
      textInputConfiguration.textAlign,
      defaultValue: TextAlign.start,
    ),
  );
  properties.add(
    DiagnosticsProperty<TextAlignVertical>(
      'textAlignVertical',
      textInputConfiguration.textAlignVertical,
      defaultValue: null,
    ),
  );
  properties.add(
    EnumProperty<TextDirection>(
      'textDirection',
      textInputConfiguration.textDirection,
      defaultValue: null,
    ),
  );
  properties.add(
    DoubleProperty(
      'cursorWidth',
      textInputConfiguration.cursorWidth,
      defaultValue: 2.0,
    ),
  );
  properties.add(
    DoubleProperty(
      'cursorHeight',
      textInputConfiguration.cursorHeight,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<Radius>(
      'cursorRadius',
      textInputConfiguration.cursorRadius,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'cursorOpacityAnimates',
      textInputConfiguration.cursorOpacityAnimates,
      defaultValue: null,
    ),
  );
  properties.add(
    ColorProperty(
      'cursorColor',
      textInputConfiguration.cursorColor,
      defaultValue: null,
    ),
  );
  properties.add(
    ColorProperty(
      'cursorErrorColor',
      textInputConfiguration.cursorErrorColor,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<Brightness>(
      'keyboardAppearance',
      textInputConfiguration.keyboardAppearance,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<EdgeInsetsGeometry>(
      'scrollPadding',
      textInputConfiguration.scrollPadding,
      defaultValue: const EdgeInsets.all(20.0),
    ),
  );
  properties.add(
    FlagProperty(
      'selectionEnabled',
      value: textInputConfiguration.enableInteractiveSelection,
      defaultValue: true,
      ifFalse: 'selection disabled',
    ),
  );
  properties.add(
    DiagnosticsProperty<TextSelectionControls>(
      'selectionControls',
      textInputConfiguration.selectionControls,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<ScrollController>(
      'scrollController',
      textInputConfiguration.scrollController,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<ScrollPhysics>(
      'scrollPhysics',
      textInputConfiguration.scrollPhysics,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<Clip>(
      'clipBehavior',
      textInputConfiguration.clipBehavior,
      defaultValue: Clip.hardEdge,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'scribbleEnabled',
      textInputConfiguration.scribbleEnabled,
      defaultValue: true,
    ),
  );
  properties.add(
    DiagnosticsProperty<bool>(
      'enableIMEPersonalizedLearning',
      textInputConfiguration.enableIMEPersonalizedLearning,
      defaultValue: true,
    ),
  );
  properties.add(
    DiagnosticsProperty<SpellCheckConfiguration>(
      'spellCheckConfiguration',
      textInputConfiguration.spellCheckConfiguration,
      defaultValue: null,
    ),
  );
  properties.add(
    DiagnosticsProperty<List<String>>(
      'contentCommitMimeTypes',
      textInputConfiguration.contentInsertionConfiguration?.allowedMimeTypes ??
          const <String>[],
      defaultValue: textInputConfiguration.contentInsertionConfiguration == null
          ? const <String>[]
          : kDefaultContentInsertionMimeTypes,
    ),
  );
}
