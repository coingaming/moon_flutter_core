import 'package:flutter/material.dart';

import 'package:mix/mix.dart';

import 'package:moon_core/moon_core.dart';

typedef MoonRawAccordionTrailingWidgetBuilder =
    Widget Function(BuildContext context, Animation<double> animationView);

class MoonRawAccordion<T> extends StatefulWidget {
  /// Whether to propagate gestures to the [children] of the accordion.
  /// Defaults to true.
  final bool propagateGesturesToChild;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Should gestures provide audible and/or haptic feedback.
  /// On platforms like Android, enabling feedback will result in audible and
  /// tactile responses to certain actions. For example, a tap may produce a
  /// clicking sound, while a long-press may trigger a short vibration.
  final bool enableFeedback;

  /// Whether to display the accordion content outside of its [header].
  final bool hasContentOutside;

  /// Whether the accordion is initially expanded (true) or collapsed
  /// (false, the default).
  ///
  /// If the [identityValue] matches the [groupIdentityValue], this parameter is
  /// disregarded.
  final bool initiallyExpanded;

  /// Whether the accordion is enabled.
  final bool enabled;

  /// Whether to preserve the state of the [children] when the accordion expands
  /// and collapses.
  ///
  /// When true, the [children] remain in the widget tree even when the
  /// accordion is collapsed. When false (default), the [children] are removed
  /// from the tree when the accordion is collapsed and recreated when it is
  /// expanded.
  final bool maintainState;

  /// Whether to show a dividing line between the accordion [header] and the
  /// [children].
  final bool showDivider;

  /// The duration of the accordion transition animation (expand and collapse).
  final Duration transitionDuration;

  /// The curve of the accordion transition animation (expand and collapse).
  final Curve transitionCurve;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the accordion.
  final String? semanticLabel;

  /// The style of the accordion [header] container.
  final FlexBoxStyler? headerStyle;

  /// The style of the accordion container that contains [children].
  final BoxStyler? contentStyle;

  /// The style of the accordion outer container.
  final BoxStyler? outerContainerStyle;

  /// The identity value represented by this accordion.
  final T? identityValue;

  /// The currently selected [identityValue] for a group of accordions.
  ///
  /// This accordion is considered selected if its [identityValue] is equal to
  /// the [groupIdentityValue].
  final T? groupIdentityValue;

  /// The callback that is called when the accordion expands or collapses.
  ///
  /// When the accordion expansion changes, this function is called with the
  /// [identityValue]. If [identityValue] is null, this function returns null.
  final ValueChanged<T?>? onExpansionChanged;

  /// The animation controller for the accordion.
  final AnimationController? animationController;

  /// The widget to display as the header of the accordion.
  final Widget header;

  /// Widget to display as the trailing widget of the accordion [header].
  /// Usually an icon that indicates the accordion is expandable.
  /// If null, defaults to an [Icon] with [Icons.keyboard_arrow_down].
  final MoonRawAccordionTrailingWidgetBuilder? trailingWidget;

  /// Widget to display as the separator of accordion [header] and [children] in
  /// expanded state.
  final Widget? divider;

  /// The list of widgets to display as the content of the accordion when the
  /// accordion expands.
  final List<Widget> children;

  /// Creates a Moon Design raw accordion.
  const MoonRawAccordion({
    super.key,
    this.propagateGesturesToChild = true,
    this.autofocus = false,
    this.enableFeedback = false,
    this.hasContentOutside = false,
    this.initiallyExpanded = false,
    this.enabled = true,
    this.maintainState = false,
    this.showDivider = true,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.focusNode,
    this.semanticLabel,
    this.headerStyle,
    this.contentStyle,
    this.outerContainerStyle,
    this.identityValue,
    this.groupIdentityValue,
    this.onExpansionChanged,
    this.animationController,
    required this.header,
    this.trailingWidget,
    this.divider,
    this.children = const <Widget>[],
  });

  bool get _selected =>
      identityValue != null && identityValue == groupIdentityValue;

  @override
  State<MoonRawAccordion<T>> createState() => _MoonRawAccordionState<T>();
}

class _MoonRawAccordionState<T> extends State<MoonRawAccordion<T>>
    with TickerProviderStateMixin {
  static final Animatable<double> _halfTween = Tween<double>(
    begin: 0.0,
    end: 0.5,
  );

  late AnimationController _expansionAnimationController;
  late CurvedAnimation _expansionCurvedAnimation;

  bool _isExpanded = false;

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  bool get _isClosed =>
      !_isExpanded && _expansionAnimationController.isDismissed;

  bool get _shouldRemoveChildren => _isClosed && !widget.maintainState;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;

      _isExpanded
          ? _expansionAnimationController.forward()
          : _expansionAnimationController.reverse().then<void>((void value) {
              if (mounted) setState(() {}); // Rebuild without widget.children.
            });

      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });

    widget.onExpansionChanged?.call(_isExpanded ? widget.identityValue : null);
  }

  void _animationListener() {
    widget.trailingWidget?.call(context, _expansionAnimationController.view);
  }

  @override
  void initState() {
    super.initState();

    _expansionAnimationController =
        widget.animationController ??
        AnimationController(duration: widget.transitionDuration, vsync: this);

    _expansionCurvedAnimation = CurvedAnimation(
      parent: _expansionAnimationController,
      curve: widget.transitionCurve,
    );

    _isExpanded =
        PageStorage.maybeOf(context)?.readState(context) as bool? ??
        (widget.initiallyExpanded || widget._selected) && widget.enabled;

    _expansionAnimationController.addListener(_animationListener);

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (mounted & _isExpanded) _expansionAnimationController.value = 1.0;
    });
  }

  @override
  void didUpdateWidget(MoonRawAccordion<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled) return;

    if (widget.identityValue == null && widget.groupIdentityValue == null) {
      return;
    }

    _isExpanded = widget._selected;

    setState(() {
      _isExpanded
          ? _expansionAnimationController.forward()
          : _expansionAnimationController.reverse().then<void>((void value) {
              if (mounted) setState(() {}); // Rebuild without widget.children.
            });

      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
  }

  @override
  void dispose() {
    _expansionAnimationController.removeListener(_animationListener);

    if (widget.animationController == null) {
      _expansionAnimationController.dispose();
    }

    super.dispose();
  }

  Widget _buildIcon(BuildContext context) {
    return RotationTransition(
      turns: _halfTween.animate(_expansionCurvedAnimation),
      child: const Icon(Icons.keyboard_arrow_down, size: 24),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    final trailing =
        widget.trailingWidget?.call(
          context,
          _expansionAnimationController.view,
        ) ??
        _buildIcon(context);

    final children = <Widget>[widget.header, trailing];

    if (widget.headerStyle != null) {
      return RowBox(
        style: widget.headerStyle!,
        children: children,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildInteractiveContainer({required Widget child}) {
    final WidgetStatesController controller = WidgetStatesController()
      ..update(WidgetState.disabled, !widget.enabled)
      ..update(WidgetState.selected, _isExpanded);

    final BoxStyler baseStyle = BoxStyler()
        .clipBehavior(Clip.hardEdge)
        .merge(widget.outerContainerStyle);

    return MoonBaseInteractiveWidget(
      autofocus: widget.autofocus,
      focusNode: _effectiveFocusNode,
      enableFeedback: widget.enableFeedback,
      hitTestBehavior: widget.propagateGesturesToChild
          ? HitTestBehavior.translucent
          : HitTestBehavior.opaque,
      stateController: controller,
      enabled: widget.enabled,
      semanticLabel: widget.semanticLabel,
      onTap: widget.enabled ? _handleTap : null,
      style: baseStyle,
      child: child,
    );
  }

  Widget _wrapContent(Widget child) {
    if (widget.contentStyle == null) return child;

    return Box(
      style: widget.contentStyle!,
      child: child,
    );
  }

  Widget _buildContent(BuildContext context, Widget? rootChild) {
    final Widget childWrapper = ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: _expansionCurvedAnimation.value,
        child: rootChild,
      ),
    );

    final Widget header = _buildHeaderRow(context);

    return switch (widget.hasContentOutside) {
      true => Semantics(
        label: widget.semanticLabel,
        enabled: _isExpanded,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildInteractiveContainer(child: header),
            _wrapContent(childWrapper),
          ],
        ),
      ),
      false => Semantics(
        label: widget.semanticLabel,
        enabled: _isExpanded,
        child: _buildInteractiveContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[header, _wrapContent(childWrapper)],
          ),
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _expansionAnimationController.view,
        builder: _buildContent,
        child: _shouldRemoveChildren
            ? null
            : Offstage(
                offstage: _isClosed,
                child: TickerMode(
                  enabled: !_isClosed,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showDivider && !widget.hasContentOutside)
                        widget.divider ?? const SizedBox(height: 1),
                      _wrapContent(
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.children,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
