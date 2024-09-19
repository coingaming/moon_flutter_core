import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/text_input/text_input.dart';
import 'package:moon_core/src/widgets/text_input/text_input_configuration.dart';

typedef MoonFormTextInputValidationStatusCallback = void Function(
  String? validationErrorText,
);

class MoonRawFormTextInput extends FormField<String> {
  final MoonTextInputConfiguration configuration;

  /// Creates a Moon Design raw form text input with the [MoonRawTextInput].
  ///
  /// Validator errors take precedence over the provided [errorText].
  MoonRawFormTextInput({
    super.key,
    super.onSaved,
    super.validator,
    super.restorationId,
    AutovalidateMode? autovalidateMode,
    MoonTextInputConfiguration? textInputConfiguration,
    MoonFormTextInputValidationStatusCallback? validationStatusCallback,
  })  : configuration =
            textInputConfiguration ?? const MoonTextInputConfiguration(),
        super(
          enabled: textInputConfiguration?.enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          initialValue: textInputConfiguration?.controller?.text ??
              textInputConfiguration?.initialValue ??
              "",
          builder: (FormFieldState<String> field) {
            final MoonTextInputConfiguration configuration =
                textInputConfiguration ?? const MoonTextInputConfiguration();

            validationStatusCallback?.call(field.errorText);

            void onChangedHandler(String value) {
              field.didChange(value);

              if (textInputConfiguration?.onChanged != null) {
                textInputConfiguration!.onChanged!(value);
              }
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: MoonRawTextInput(
                textInputConfiguration: configuration.copyWith(
                  restorationId: 'editable',
                  errorText:
                      field.errorText ?? textInputConfiguration?.errorText,
                  controller:
                      (field as _MoonFormTextInputState)._effectiveController,
                  onChanged: onChangedHandler,
                ),
              ),
            );
          },
        );

  static Widget defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) =>
      AdaptiveTextSelectionToolbar.editableText(
        editableTextState: editableTextState,
      );

  @override
  FormFieldState<String> createState() => _MoonFormTextInputState();
}

class _MoonFormTextInputState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  MoonRawFormTextInput get _moonFormTextInput =>
      super.widget as MoonRawFormTextInput;

  TextEditingController get _effectiveController =>
      _moonFormTextInput.configuration.controller ?? _controller!.value;

  TextEditingController? get _providedControlled =>
      _moonFormTextInput.configuration.controller;

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

  void _handleControllerChanged() {
    // Ignore internal changes from this class. If a controller is provided, a
    // listener is registered. Notifications (e.g., from reset()) may trigger,
    // but the FormField value is already updated.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  @override
  void initState() {
    super.initState();

    _providedControlled == null
        ? _createLocalController(
            widget.initialValue != null
                ? TextEditingValue(text: widget.initialValue!)
                : null,
          )
        : _providedControlled!.addListener(_handleControllerChanged);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);

    if (_controller != null) _registerController();
    // Sync the internal FormFieldState value with the text controller.
    setValue(_effectiveController.text);
  }

  @override
  void didUpdateWidget(MoonRawFormTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    final TextEditingController? oldController =
        oldWidget.configuration.controller;

    if (_providedControlled != oldController) {
      oldController?.removeListener(_handleControllerChanged);
      _providedControlled?.addListener(_handleControllerChanged);

      if (oldController != null && _providedControlled == null) {
        _createLocalController(oldController.value);
      }

      if (_providedControlled != null) {
        setValue(_providedControlled!.text);
        if (oldController == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _providedControlled?.removeListener(_handleControllerChanged);
    _controller?.dispose();

    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? "";
    }
  }

  @override
  void reset() {
    // SetState is handled by the superclass, no extra call needed.
    _effectiveController.text = widget.initialValue ?? '';

    super.reset();
  }
}
