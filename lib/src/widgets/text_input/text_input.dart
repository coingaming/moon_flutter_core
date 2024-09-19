import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/widgets/common/error_message_widgets.dart';
import 'package:moon_core/src/widgets/text_input/text_input_configuration.dart';

class MoonRawTextInput extends StatefulWidget {
  /// Defines the behavior and appearance settings for an input text field.
  final MoonTextInputConfiguration textInputConfiguration;

  /// Creates a Moon Design raw text input.
  const MoonRawTextInput({
    super.key,
    required this.textInputConfiguration,
  });

  bool get selectionEnabled =>
      textInputConfiguration.enableInteractiveSelection;

  @override
  State<MoonRawTextInput> createState() => _MoonRawTextInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    textInputDebugFillProperties(properties, textInputConfiguration);
  }
}

class _MoonRawTextInputState extends State<MoonRawTextInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  late final MixWidgetStateController _mixStateController;

  late _MoonTextInputSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  bool _showSelectionHandles = false;
  FocusNode? _focusNode;
  RestorableTextEditingController? _controller;

  bool get _isEnabled => _configuration.enabled;

  bool get _hasErrorText => _configuration.errorText != null;

  bool get _hasError => _hasIntrinsicError || _hasErrorText;

  bool get _hasFocus => _effectiveFocusNode.hasFocus;

  bool get _hasIntrinsicError => _evaluateHasIntrinsicError();

  bool get _canRequestFocus => _evaluateCanRequestFocus();

  bool get _expands => _configuration.expands;

  bool get _animateLabel =>
      _configuration.hasFloatingLabel &&
      (_effectiveFocusNode.hasFocus || editingValue.isNotEmpty);

  bool get _textAlignIsVerticalTop =>
      _configuration.textAlignVertical == TextAlignVertical.top;

  bool get _showHint => editingValue.isEmpty || _configuration.hasFloatingLabel;

  EditableTextState? get _editableText => editableTextKey.currentState;

  int get _currentLength => _effectiveController.value.text.characters.length;

  String get editingValue => _effectiveController.value.text;

  FocusNode get _effectiveFocusNode =>
      _configuration.focusNode ?? (_focusNode ??= FocusNode());

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      _evaluateMaxLengthEnforcement();

  MoonTextInputConfiguration get _configuration =>
      widget.textInputConfiguration;

  TextEditingController get _effectiveController =>
      _configuration.controller ?? _controller!.value;

  TargetPlatform get _platform => Theme.of(context).platform;

  @override
  String? get restorationId => _configuration.restorationId;

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  bool get selectionEnabled => _configuration.enableInteractiveSelection;

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints =
        _configuration.autofillHints?.toList(growable: false);

    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration
        .copyWith(autofillConfiguration: autofillConfiguration);
  }

  bool _evaluateHasIntrinsicError() =>
      _configuration.maxLength != null &&
      _configuration.maxLength! > 0 &&
      (_configuration.controller == null
          ? !restorePending &&
              _effectiveController.value.text.characters.length >
                  _configuration.maxLength!
          : _effectiveController.value.text.characters.length >
              _configuration.maxLength!);

  bool _evaluateCanRequestFocus() {
    final NavigationMode mode =
        MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional;

    return mode != NavigationMode.traditional ||
        (_configuration.canRequestFocus && _isEnabled);
  }

  MaxLengthEnforcement _evaluateMaxLengthEnforcement() =>
      _configuration.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
        _platform,
      );

  void _registerController() {
    assert(_controller != null);

    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);

    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);

    if (!restorePending) _registerController();
  }

  void _requestKeyboard() => _editableText?.requestKeyboard();

  void _handleFocusChanged() {
    setState(() {
      // Rebuilds the widget on focus change to toggle text selection highlight.
    });
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final bool willShowSelectionHandles =
        cause == SelectionChangedCause.longPress ||
            cause == SelectionChangedCause.scribble ||
            _effectiveController.text.isNotEmpty;

    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() => _showSelectionHandles = willShowSelectionHandles);
    }

    if (_platform == TargetPlatform.macOS ||
        _platform == TargetPlatform.linux ||
        _platform == TargetPlatform.windows) {
      if (cause == SelectionChangedCause.drag) _editableText?.hideToolbar();
    }

    if (cause == SelectionChangedCause.longPress) {
      _editableText?.bringIntoView(selection.extent);
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  @override
  void autofill(TextEditingValue newEditingValue) =>
      _editableText!.autofill(newEditingValue);

  @override
  void initState() {
    super.initState();

    if (_configuration.controller == null) {
      _createLocalController(
        _configuration.initialValue != null
            ? TextEditingValue(text: _configuration.initialValue!)
            : null,
      );
    }

    _mixStateController = MixWidgetStateController();

    _selectionGestureDetectorBuilder =
        _MoonTextInputSelectionGestureDetectorBuilder(state: this);

    _effectiveFocusNode.canRequestFocus =
        _configuration.canRequestFocus && _isEnabled;

    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) _registerController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(MoonRawTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final MoonTextInputConfiguration oldConfiguration =
        oldWidget.textInputConfiguration;

    if (_configuration.controller == null &&
        oldConfiguration.controller != null) {
      _createLocalController(oldConfiguration.controller!.value);
    } else if (_configuration.controller != null &&
        oldConfiguration.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (_configuration.focusNode != oldConfiguration.focusNode) {
      (oldConfiguration.focusNode ?? _focusNode)
          ?.removeListener(_handleFocusChanged);
      (_configuration.focusNode ?? _focusNode)
          ?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_hasFocus &&
        _isEnabled &&
        _effectiveController.selection.isCollapsed &&
        _configuration.readOnly != oldConfiguration.readOnly) {
      _showSelectionHandles = !_configuration.readOnly;
    }

    if (oldConfiguration.errorText != _configuration.errorText) {
      _mixStateController.error = _hasError;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    _mixStateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(_configuration.style != null &&
          _configuration.style!.inherit == false &&
          (_configuration.style!.fontSize == null ||
              _configuration.style!.textBaseline == null)),
      'Inherit false style must supply fontSize and textBaseline.',
    );

    final FocusNode focusNode = _effectiveFocusNode;

    final Duration effectiveTransitionDuration =
        _configuration.transitionDuration ?? const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        _configuration.transitionCurve ?? Curves.easeInOutCubic;

    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?_configuration.inputFormatters,
      if (_configuration.maxLength != null)
        LengthLimitingTextInputFormatter(
          _configuration.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    // Disables configuration if unset; otherwise, applies platform-specific
    // misspelling styles unless overridden.
    final SpellCheckConfiguration spellCheckConfiguration =
        defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS
            ? CupertinoTextField.inferIOSSpellCheckConfiguration(
                _configuration.spellCheckConfiguration,
              )
            : TextField.inferAndroidSpellCheckConfiguration(
                _configuration.spellCheckConfiguration,
              );

    // Semantics value length.
    final int? semanticsMaxValueLength =
        (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
                _configuration.maxLength != null &&
                _configuration.maxLength! > 0)
            ? _configuration.maxLength
            : null;

    // Platform specific parameters.
    final Color cursorColor = _hasError
        ? _configuration.cursorErrorColor ?? Colors.red
        : _configuration.cursorColor ?? Colors.black;

    final double devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    bool paintCursorAboveText = false;
    bool? cursorOpacityAnimates = _configuration.cursorOpacityAnimates;
    Color? autocorrectionTextRectColor;
    Color? selectionColor = DefaultSelectionStyle.of(context).selectionColor;
    Offset? cursorOffset;
    Radius? cursorRadius = _configuration.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;
    TextSelectionControls? textSelectionControls =
        _configuration.selectionControls;

    switch (_platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        final cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = defaultTargetPlatform == TargetPlatform.iOS;
        textSelectionControls ??= (defaultTargetPlatform == TargetPlatform.iOS)
            ? cupertinoTextSelectionHandleControls
            : cupertinoDesktopTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= defaultTargetPlatform == TargetPlatform.iOS;
        selectionColor ??= cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / devicePixelRatio, 0);
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          autocorrectionTextRectColor = selectionColor;
        }
        if (defaultTargetPlatform == TargetPlatform.macOS) {
          handleDidGainAccessibilityFocus = () {
            if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
              // Auto-activates MoonTextInput on accessibility focus.
              _effectiveFocusNode.requestFocus();
            }
          };
        }
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        forcePressEnabled = false;
        cursorOpacityAnimates ??= false;
        selectionColor ??=
            Theme.of(context).colorScheme.primary.withOpacity(0.40);
        textSelectionControls ??=
            (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.fuchsia)
                ? materialTextSelectionHandleControls
                : desktopTextSelectionHandleControls;
        if (defaultTargetPlatform == TargetPlatform.windows) {
          handleDidGainAccessibilityFocus = () {
            // Accessibility focus automatically activates MoonTextInput.
            if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
              _effectiveFocusNode.requestFocus();
            }
          };
        }
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          autocorrect: _configuration.autocorrect,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          autofillClient: this,
          autofocus: _configuration.autofocus,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          clipBehavior: _configuration.clipBehavior,
          contentInsertionConfiguration:
              _configuration.contentInsertionConfiguration,
          contextMenuBuilder: _configuration.contextMenuBuilder,
          controller: _effectiveController,
          cursorColor: cursorColor,
          cursorHeight: _configuration.cursorHeight,
          cursorOffset: cursorOffset,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorRadius: cursorRadius,
          cursorWidth: _configuration.cursorWidth,
          dragStartBehavior: _configuration.dragStartBehavior,
          enableIMEPersonalizedLearning:
              _configuration.enableIMEPersonalizedLearning,
          enableInteractiveSelection: _configuration.enableInteractiveSelection,
          enableSuggestions: _configuration.enableSuggestions,
          expands: _configuration.expands,
          focusNode: focusNode,
          inputFormatters: formatters,
          keyboardAppearance:
              _configuration.keyboardAppearance ?? Theme.of(context).brightness,
          keyboardType: _configuration.keyboardType,
          magnifierConfiguration: _configuration.magnifierConfiguration ??
              TextMagnifier.adaptiveMagnifierConfiguration,
          maxLines: _configuration.maxLines,
          minLines: _configuration.minLines,
          mouseCursor: MouseCursor.defer,
          // MoonTextInput will handle the cursor.
          obscureText: _configuration.obscureText,
          obscuringCharacter: _configuration.obscuringCharacter,
          onAppPrivateCommand: _configuration.onAppPrivateCommand,
          onChanged: _configuration.onChanged,
          onEditingComplete: _configuration.onEditingComplete,
          onSelectionChanged: _handleSelectionChanged,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          onSubmitted: _configuration.onSubmitted,
          onTapOutside: _configuration.onTapOutside,
          paintCursorAboveText: paintCursorAboveText,
          readOnly: _configuration.readOnly || !_isEnabled,
          rendererIgnoresPointer: true,
          restorationId: 'editable',
          scribbleEnabled: _configuration.scribbleEnabled,
          scrollController: _configuration.scrollController,
          scrollPadding: _configuration.scrollPadding,
          scrollPhysics: _configuration.scrollPhysics,
          selectionColor: focusNode.hasFocus ? selectionColor : null,
          selectionControls: selectionEnabled ? textSelectionControls : null,
          selectionHeightStyle: _configuration.selectionHeightStyle,
          selectionWidthStyle: _configuration.selectionWidthStyle,
          showCursor: _configuration.showCursor,
          showSelectionHandles: _showSelectionHandles,
          smartDashesType: _configuration.smartDashesType,
          smartQuotesType: _configuration.smartQuotesType,
          spellCheckConfiguration: spellCheckConfiguration,
          strutStyle: _configuration.strutStyle,
          style: _configuration.style ?? const TextStyle(),
          textAlign: _configuration.textAlign,
          textCapitalization: _configuration.textCapitalization,
          textDirection: _configuration.textDirection,
          textInputAction: _configuration.textInputAction,
          undoController: _configuration.undoController,
        ),
      ),
    );

    child = AnimatedBuilder(
      animation: Listenable.merge(
        <Listenable>[focusNode, _effectiveController],
      ),
      builder: (BuildContext context, Widget? child) {
        final effectiveAlignment =
            AlignmentDirectional.topStart.resolve(Directionality.of(context));

        final double? height = _configuration.inputStyle
            ?.of(context)
            .resolvableOf<BoxSpec, BoxSpecAttribute>()
            ?.height;

        final EdgeInsetsGeometry effectivePadding = _configuration.inputStyle
                ?.of(context)
                .resolvableOf<BoxSpec, BoxSpecAttribute>()
                ?.padding ??
            EdgeInsets.zero;

        final EdgeInsets resolvedPadding =
            effectivePadding.resolve(Directionality.of(context));

        final AlignmentDirectional? textAlignVertical =
            switch (_configuration.textAlignVertical) {
          TextAlignVertical.top => AlignmentDirectional.topCenter,
          TextAlignVertical.center => AlignmentDirectional.center,
          TextAlignVertical.bottom => AlignmentDirectional.bottomCenter,
          _ => null,
        };

        final Style defaultInputStyle = Style(
          $box.chain
            ..constraints(
              minHeight: height ?? 40,
              maxHeight: height ?? (_expands ? double.infinity : 40),
            ),
          $flex.crossAxisAlignment(
            _expands ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          ),
        ).animate(
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
        );

        return Pressable(
          enabled: _isEnabled,
          controller: _mixStateController,
          mouseCursor: _configuration.mouseCursor ?? SystemMouseCursors.text,
          onFocusChange: (bool focused) {
            if (focused) _effectiveFocusNode.requestFocus();
          },
          child: Box(
            style: defaultInputStyle.merge(_configuration.inputStyle).add(
                  $box.padding.vertical(0),
                ),
            child: StyledRow(
              inherit: true,
              children: [
                if (_configuration.leading != null) _configuration.leading!,
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: textAlignVertical ??
                            (_configuration.hasFloatingLabel
                                ? Alignment.bottomCenter
                                : Alignment.center),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: resolvedPadding.bottom +
                                _configuration.inputTextVerticalOffsetValue +
                                (_expands || _textAlignIsVerticalTop ? 2 : 0),
                            bottom: resolvedPadding.bottom,
                          ),
                          child: child,
                        ),
                      ),
                      if (_configuration.hint != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: resolvedPadding.top,
                            bottom: resolvedPadding.top,
                          ),
                          child: AnimatedScale(
                            alignment: effectiveAlignment,
                            duration: effectiveTransitionDuration,
                            scale: _animateLabel
                                ? _configuration.floatingLabelScaleValue
                                : 1.0,
                            child: AnimatedAlign(
                              duration: effectiveTransitionDuration,
                              alignment:
                                  _textAlignIsVerticalTop || _animateLabel
                                      ? AlignmentDirectional.topStart
                                      : AlignmentDirectional.centerStart,
                              child: AnimatedOpacity(
                                opacity: _showHint ? 1.0 : 0.0,
                                duration: effectiveTransitionDuration,
                                curve: effectiveTransitionCurve,
                                child: _configuration.hint,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_configuration.trailing != null) _configuration.trailing!,
              ],
            ),
          ),
        );
      },
      child: child,
    );

    child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        if (_configuration.helper != null || (_configuration.errorText != null))
          RepaintBoundary(
            child: FocusableActionDetector(
              enabled: false,
              descendantsAreFocusable: false,
              child: Pressable(
                enabled: _isEnabled,
                controller: _mixStateController,
                child: Box(
                  style: Style().merge(_configuration.helperStyle),
                  child: _configuration.errorText != null
                      ? _configuration.errorBuilder
                              ?.call(context, _configuration.errorText) ??
                          MoonErrorMessage(errorText: _configuration.errorText!)
                      : _configuration.helper ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ),
      ],
    );

    return TextFieldTapRegion(
      child: IgnorePointer(
        ignoring: !_isEnabled,
        child: AnimatedBuilder(
          animation: _effectiveController, // Changes the _currentLength.
          builder: (BuildContext context, Widget? child) {
            final collapsedSelection = TextSelection.collapsed(
              offset: _effectiveController.text.length,
            );

            return Semantics(
              maxValueLength: semanticsMaxValueLength,
              currentValueLength: _currentLength,
              onTap: _configuration.readOnly
                  ? null
                  : () {
                      if (!_effectiveController.selection.isValid) {
                        _effectiveController.selection = collapsedSelection;
                      }
                      _requestKeyboard();
                    },
              onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
              child: child,
            );
          },
          child: _selectionGestureDetectorBuilder.buildGestureDetector(
            behavior: HitTestBehavior.translucent,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _MoonTextInputSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _MoonTextInputSelectionGestureDetectorBuilder({
    required _MoonRawTextInputState state,
  })  : _state = state,
        super(delegate: state);

  final _MoonRawTextInputState _state;

  @override
  bool get onUserTapAlwaysCalled => _state._configuration.onTapAlwaysCalled;

  @override
  void onUserTap() => _state._configuration.onTap?.call();

  @override
  void onForcePressEnd(ForcePressDetails details) {}

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);

    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);

    _state._requestKeyboard();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);

    final TargetPlatform platform = Theme.of(_state.context).platform;
    final bool iOsOrMacOs =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (delegate.selectionEnabled && iOsOrMacOs) {
      Feedback.forLongPress(_state.context);
    }
  }
}
