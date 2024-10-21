import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix/mix.dart';

import 'package:moon_core/src/mix/context_variants/active_state_variant.dart';

enum ErrorAnimationType {
  noAnimation,
  shake,
}

typedef MoonAuthCodeErrorBuilder = Widget Function(
  BuildContext context,
  String? errorText,
);

class MoonRawAuthCode extends StatefulWidget {
  /// Whether to automatically dismiss the keyboard when the last input is
  /// entered.
  final bool autoDismissKeyboard;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether to automatically unfocus the auth code.
  final bool autoUnfocus;

  /// Whether the auth code is enabled.
  final bool enabled;

  /// Whether to replace all typed characters in the auth code input fields with
  /// the [obscuringCharacter].
  final bool obscureText;

  /// Whether to briefly display the typed character before obscuring it with
  /// the [obscuringCharacter].
  final bool peekWhenObscuring;

  /// Whether to show the cursor in the selected auth code input field.
  final bool showAuthFieldCursor;

  /// Whether to use haptic feedback (vibration) for auth code error state.
  final bool useHapticFeedback;

  /// The cursor color of the auth code input field.
  final Color? authFieldCursorColor;

  /// The duration of the auth code error state animation.
  final Duration errorAnimationDuration;

  /// The duration to display the typed character before it is obscured with
  /// [obscuringCharacter]. The [peekWhenObscuring] has to be set to true.
  final Duration peekDuration;

  /// The curve of the auth code error state animation.
  final Curve errorAnimationCurve;

  /// The animation type for the auth code validation error.
  final ErrorAnimationType errorAnimationType;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The total number of input fields to build for the auth code.
  final int authInputFieldCount;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The error text can be used to force authentication into an error state
  /// (useful for asynchronous errors).
  ///
  /// The validator errors take precedence over the provided [errorText].
  final String? errorText;

  /// The character to use to obscure the text when [obscureText] is true.
  ///
  /// Defaults to Unicode character U+2022 BULLET (•).
  final String obscuringCharacter;

  /// The semantic label for the auth code.
  final String? semanticLabel;

  final Style? inputFieldStyle;

  /// The action to perform by the text input control.
  final TextInputAction textInputAction;

  /// The keyboard [TextInputType] for the auth code.
  final TextInputType keyboardType;

  /// The [TextEditingController] used to edit the text in the auth code input
  /// field.
  final TextEditingController? textController;

  /// The input text validator for the auth code [TextFormField].
  /// The validator errors take precedence over the provided [errorText].
  final FormFieldValidator<String> validator;

  /// The callback that is called when the auth code input text changes.
  final ValueChanged<String>? onChanged;

  /// The callback that is called when all the auth code input fields are
  /// filled.
  final ValueChanged<String>? onCompleted;

  /// The callback that is called when the 'done' or 'next' action is triggered
  /// on the keyboard.
  final ValueChanged<String>? onSubmitted;

  /// The [onEditingComplete] callback runs when editing is finished.
  /// It differs from [onSubmitted] by having a default value which
  /// updates [textController] and yields keyboard focus.
  ///
  /// Set this to empty function if keyboard should not close automatically on
  /// 'done' or 'next' press.
  final VoidCallback? onEditingComplete;

  /// A builder to build the auth code error widget.
  final MoonAuthCodeErrorBuilder errorBuilder;

  /// The character or placeholder to display in the auth code input field when
  /// its value is empty.
  final Widget? hintCharacter;

  /// The widget to obscure the auth code input field text.
  ///
  /// Overrides the [obscuringCharacter].
  final Widget? obscuringWidget;

  /// Creates a Moon Design raw auth code.
  const MoonRawAuthCode({
    super.key,
    this.autoDismissKeyboard = true,
    this.autoFocus = false,
    this.autoUnfocus = true,
    this.enabled = true,
    this.obscureText = false,
    this.peekWhenObscuring = false,
    this.showAuthFieldCursor = true,
    this.useHapticFeedback = false,
    this.authFieldCursorColor,
    this.errorAnimationDuration = const Duration(milliseconds: 200),
    this.peekDuration = const Duration(milliseconds: 200),
    this.errorAnimationCurve = Curves.easeInOutCubic,
    this.errorAnimationType = ErrorAnimationType.noAnimation,
    this.focusNode,
    this.authInputFieldCount = 6,
    this.inputFormatters,
    this.obscuringCharacter = '•',
    this.semanticLabel,
    this.inputFieldStyle,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.errorText,
    this.textController,
    required this.validator,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    required this.errorBuilder,
    this.hintCharacter,
    this.obscuringWidget,
  }) : assert(authInputFieldCount > 0);

  @override
  _MoonRawAuthCodeState createState() => _MoonRawAuthCodeState();
}

class _MoonRawAuthCodeState extends State<MoonRawAuthCode>
    with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late List<String> _inputList;
  late TextEditingController _textEditingController;
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;
  late AnimationController _errorAnimationController;
  late Animation<Offset> _errorOffsetAnimation;

  bool _hasPeeked = false;
  double _effectiveHeight = 0;
  int _selectedIndex = 0;
  Timer? _peekDebounce;
  TextStyle? _effectiveTextStyle;
  List<MixWidgetStateController> _stateControllers = [];

  bool get _isInErrorMode => _stateControllers.any((state) => state.error);

  int get _inputFieldCount => widget.authInputFieldCount;

  void _initializeFields() {
    _initializeFocusNode();
    _initializeInputList();
    _initializeTextEditingController();
    _initializeErrorAnimationListener();
    _initializeAuthFieldCursor();
  }

  void _initializeFocusNode() {
    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(() => setState(() {}));
  }

  void _initializeInputList() {
    _inputList = List<String>.filled(_inputFieldCount, '');
  }

  void _initializeTextEditingController() {
    _textEditingController = widget.textController ?? TextEditingController();

    _textEditingController.addListener(() {
      // Custom error builder requires manual validation via _validateInput()
      // to trigger error, returning an error string or null.
      if (_validateInput() != null) {
        if (widget.errorAnimationType == ErrorAnimationType.shake) {
          _errorAnimationController.forward();

          if (widget.useHapticFeedback) HapticFeedback.lightImpact();
        }
        if (!_isInErrorMode) _setControllerErrorState(true);
      } else if (_isInErrorMode && widget.errorText == null) {
        _setControllerErrorState(false);
      }

      _debounceBlink();

      String currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join() != currentText) {
        if (currentText.length >= _inputFieldCount) {
          if (widget.onCompleted != null) {
            if (currentText.length > _inputFieldCount) {
              currentText = currentText.substring(0, _inputFieldCount);
            }
            Future.delayed(
              const Duration(milliseconds: 100),
              () => widget.onCompleted!(currentText),
            );
          }
          if (widget.autoDismissKeyboard) _focusNode.unfocus();
        }
      }

      _updateTextField(currentText);
    });

    if (_textEditingController.text.isNotEmpty) {
      _updateTextField(_textEditingController.text);
    }
  }

  void _initializeErrorAnimationListener() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (mounted) {
        _errorAnimationController.addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _errorAnimationController.reverse();
          }
        });
      }
    });
  }

  void _initializeAuthFieldCursor() {
    _cursorController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _cursorAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _cursorController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.showAuthFieldCursor) _cursorController.repeat();
  }

  void _debounceBlink() {
    _hasPeeked = true;

    if (widget.peekWhenObscuring &&
        _textEditingController.text.length >
            _inputList.where((x) => x.isNotEmpty).length) {
      _setState(() => _hasPeeked = false);

      if (_peekDebounce?.isActive ?? false) _peekDebounce!.cancel();

      _peekDebounce = Timer(widget.peekDuration, () {
        _setState(() => _hasPeeked = true);
      });
    }
  }

  void _onFocus() {
    if (!widget.autoUnfocus ||
        !_focusNode.hasFocus ||
        MediaQuery.of(context).viewInsets.bottom != 0) {
      _focusNode.requestFocus();
      return;
    }

    _focusNode.unfocus();

    Future.delayed(
      const Duration(milliseconds: 1),
      () => _focusNode.requestFocus(),
    );
  }

  Future<void> _updateTextField(String text) async {
    final List<String> updatedList = List<String>.filled(_inputFieldCount, '');

    for (int i = 0; i < _inputFieldCount; i++) {
      updatedList[i] = text.length > i ? text[i] : '';

      if (_isInErrorMode) {
        _stateControllers[i].error = true;
      } else if (_focusNode.hasFocus) {
        _stateControllers[i].selected = (i == text.length);
      }
    }

    _setState(() {
      _selectedIndex = text.length;
      _inputList = updatedList;
    });
  }

  String? _validateInput() {
    return widget.validator.call(_textEditingController.text);
  }

  void _setState(void Function() function) {
    if (mounted) setState(function);
  }

  void _setControllerErrorState(bool hasError) {
    for (final controller in _stateControllers) {
      controller.error = hasError;
    }
  }

  @override
  void initState() {
    super.initState();

    _initializeFields();

    _stateControllers = List.generate(
      _inputFieldCount,
      (_) => MixWidgetStateController()..error = widget.errorText != null,
    );

    _errorAnimationController = AnimationController(
      duration: widget.errorAnimationDuration,
      vsync: this,
    );

    _errorOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.01, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _errorAnimationController,
        curve: widget.errorAnimationCurve,
      ),
    );
  }

  @override
  void didUpdateWidget(MoonRawAuthCode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.errorText != widget.errorText) {
      _setControllerErrorState(
        widget.errorText != null || _validateInput() != null,
      );
    }
  }

  @override
  void dispose() {
    if (widget.textController == null) _textEditingController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();

    _errorAnimationController.dispose();
    _cursorController.dispose();

    for (final controller in _stateControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Widget _buildChild(int index) {
    final bool isFieldSelected = _selectedIndex == index;
    final bool isLastFieldSelected =
        _selectedIndex == index + 1 && _inputFieldCount == index + 1;
    final bool shouldShowCursor = isFieldSelected || isLastFieldSelected;

    if (shouldShowCursor && _focusNode.hasFocus && widget.showAuthFieldCursor) {
      final double fontSize = _effectiveTextStyle?.fontSize ?? 24;
      final Color effectiveCursorColor = widget.authFieldCursorColor ??
          (_isInErrorMode
              ? _effectiveTextStyle?.color ?? Colors.red
              : Colors.black);

      final Widget cursorChild = Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: isLastFieldSelected ? fontSize / 1.5 : 0,
          ),
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, fontSize),
              painter: _CursorPainter(cursorColor: effectiveCursorColor),
            ),
          ),
        ),
      );

      return isLastFieldSelected
          ? Stack(
              alignment: Alignment.center,
              children: [
                cursorChild,
                _renderAuthInputFieldText(index: index),
              ],
            )
          : cursorChild;
    }

    return _renderAuthInputFieldText(index: index);
  }

  Widget _renderAuthInputFieldText({@required int? index}) {
    assert(index != null);

    final bool isFieldFilled = _inputList[index!].isNotEmpty;
    final bool showObscured = !widget.peekWhenObscuring ||
        (widget.peekWhenObscuring && _hasPeeked) ||
        index != _inputList.where((x) => x.isNotEmpty).length - 1;

    if (showObscured &&
        widget.obscureText &&
        isFieldFilled &&
        widget.obscuringWidget != null) {
      return widget.obscuringWidget!;
    }

    if (!isFieldFilled && widget.hintCharacter != null) {
      return SizedBox(
        key: ValueKey(_inputList[index]),
        child: widget.hintCharacter,
      );
    }

    final String text = (showObscured && widget.obscureText && isFieldFilled)
        ? widget.obscuringCharacter
        : _inputList[index];

    return Text(
      text,
      key: ValueKey(_inputList[index]),
      style: _effectiveTextStyle,
    );
  }

  Widget _getTextFormField() {
    final List<TextInputFormatter> inputFormatters = [
      LengthLimitingTextInputFormatter(_inputFieldCount),
    ];

    if (widget.inputFormatters != null) {
      inputFormatters.addAll(widget.inputFormatters!);
    }

    return Directionality(
      textDirection: Directionality.of(context),
      child: SizedBox(
        height: _effectiveHeight,
        child: TextFormField(
          autocorrect: false,
          autofocus: widget.autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _textEditingController,
          cursorWidth: 0.01,
          enabled: widget.enabled,
          enableInteractiveSelection: false,
          enableSuggestions: false,
          focusNode: _focusNode,
          inputFormatters: inputFormatters,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          scrollPadding: const EdgeInsets.all(24.0),
          showCursor: true,
          smartDashesType: SmartDashesType.disabled,
          textInputAction: widget.textInputAction,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.transparent,
            fontSize: kIsWeb ? 1 : 0.01,
            height: .01,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: RepaintBoundary(
        child: Column(
          children: [
            SlideTransition(
              position: _errorOffsetAnimation,
              child: Stack(
                children: <Widget>[
                  AbsorbPointer(
                    child: AutofillGroup(
                      child: _getTextFormField(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _onFocus(),
                      child: Focus(
                        descendantsAreFocusable: false,
                        focusNode: _focusNode,
                        onFocusChange: (bool hasFocus) {
                          for (final controller in _stateControllers) {
                            controller.selected = false;
                          }

                          if (hasFocus) {
                            final index = _selectedIndex == _inputFieldCount
                                ? _selectedIndex - 1
                                : _selectedIndex;
                            _stateControllers[index].selected = true;
                          }
                        },
                        child: StyledRow(
                          style: widget.inputFieldStyle,
                          children: List.generate(
                            _inputFieldCount,
                            (int index) => RepaintBoundary(
                              child: Pressable(
                                enabled: widget.enabled,
                                controller: _stateControllers[index],
                                child: ActiveStateVariant(
                                  isActive: _selectedIndex > index,
                                  child: Builder(
                                    builder: (BuildContext context) {
                                      _effectiveTextStyle = widget
                                              .inputFieldStyle
                                              ?.of(context)
                                              .resolvableOf<TextSpec,
                                                  TextSpecAttribute>()
                                              ?.style ??
                                          const TextStyle(fontSize: 24);

                                      _effectiveHeight = widget.inputFieldStyle
                                              ?.of(context)
                                              .resolvableOf<BoxSpec,
                                                  BoxSpecAttribute>()
                                              ?.height ??
                                          56;

                                      return Box(
                                        style: Style(
                                          $box.height(_effectiveHeight),
                                          $box.width(48),
                                        ).merge(widget.inputFieldStyle),
                                        child: Center(
                                          child: _buildChild(index),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isInErrorMode)
              widget.errorBuilder(
                context,
                _validateInput() ?? widget.errorText,
              ),
          ],
        ),
      ),
    );
  }
}

class _CursorPainter extends CustomPainter {
  final Color cursorColor;

  _CursorPainter({required this.cursorColor});

  @override
  void paint(Canvas canvas, Size size) {
    const Offset p1 = Offset.zero;
    final Offset p2 = Offset(0, size.height);
    final Paint paint = Paint()
      ..color = cursorColor
      ..strokeWidth = 2;

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
