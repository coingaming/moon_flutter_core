import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/base_overlay_widget.dart';
import 'package:moon_core/src/widgets/tooltip/tooltip_shape.dart';

class MoonRawTooltip extends StatelessWidget with OverlayPositionResolver {
  /// Whether the tooltip has an arrow (tail).
  final bool show;

  /// Determines whether multiple overlays can be open simultaneously.
  /// Defaults to 'false'.
  /// - If [hideOnTap] is 'true', the overlay will always be dismissed on tap,
  ///   even if [allowMultipleOverlays] is 'true'.
  /// - If [hideOnTap] is 'false' but [onTapOutside] specifies dismissal behavior,
  ///   the overlay will still be dismissed when tapped outside,
  ///   regardless of [allowMultipleOverlays].
  final bool allowMultipleOverlays;

  /// Determines whether the overlay should be dismissed when tapped. For finer
  /// control over dismissal, use [show], [onTap] and [onTapOutside] properties.
  /// If true, the overlay will always be dismissed on tap, regardless of any
  /// logic in [onTap] or [onTapOutside]. The [onTap] and [onTapOutside] callbacks
  /// will still be executed, but the dismissal behavior will take precedence.
  /// Defaults to true.
  final bool hideOnTap;

  /// Whether the preset tooltip has an arrow (tail).
  /// Applies only when [useDefaultTooltipShape] is true.
  final bool hasArrow;

  /// Whether the tooltip has a default preset shape.
  final bool useDefaultTooltipShape;

  /// The background color of the tooltip.
  /// Applies only when [useDefaultTooltipShape] is true.
  final Color? backgroundColor;

  /// The border color of the tooltip. Displayed when [borderWidth] is larger
  /// than 0 and [useDefaultTooltipShape] is true.
  final Color borderColor;

  /// The margin of the tooltip. Prevents the tooltip from touching the edges
  /// of the viewport.
  final double tooltipMargin;

  /// The border radius of the tooltip.
  /// Applies only when [useDefaultTooltipShape] is true.
  final BorderRadiusGeometry? borderRadius;

  /// The width of the tooltip border.
  /// Applies only when [useDefaultTooltipShape] is true.
  final double borderWidth;

  /// The base width of the tooltip arrow (tail).
  /// Applies only when [useDefaultTooltipShape] is true.
  final double arrowBaseWidth;

  /// The length of the tooltip arrow (tail).
  /// Applies only when [useDefaultTooltipShape] is true.
  final double arrowLength;

  /// The offset of the tooltip arrow (tail) from the center of the tooltip.
  /// Applies only when [useDefaultTooltipShape] is true.
  final double arrowOffsetValue;

  /// The distance from the tip of the tooltip arrow (tail) to the [target].
  /// Applies only when [useDefaultTooltipShape] is true.
  final double distanceToTarget;

  /// The duration of the tooltip transition animation (fade in or out).
  final Duration transitionDuration;

  /// The curve of the tooltip transition animation (fade in or out).
  final Curve transitionCurve;

  /// The list of shadows applied to the tooltip.
  /// Applies only when [useDefaultTooltipShape] is true.
  final List<BoxShadow>? tooltipShadows;

  /// The tooltip anchor position relative to the [target].
  /// Applies only when [useDefaultTooltipShape] is true.
  /// Defaults to [OverlayAnchorPosition.top].
  final OverlayAnchorPosition tooltipAnchorPosition;

  /// The semantic label for the tooltip.
  final String? semanticLabel;

  /// The callback that is called when the [child] of the tooltip is tapped.
  final VoidCallback? onTap;

  /// The callback that is called when the area outside of the overlay's [target]
  /// and [child] is tapped.
  final VoidCallback? onTapOutside;

  /// The widget to display as the target of the tooltip.
  final Widget target;

  /// The child widget to display inside the tooltip as its content.
  final Widget child;

  /// Creates a Moon Design raw tooltip.
  const MoonRawTooltip({
    super.key,
    required this.show,
    this.allowMultipleOverlays = false,
    this.hideOnTap = true,
    this.hasArrow = true,
    this.useDefaultTooltipShape = true,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.tooltipMargin = 0.0,
    this.arrowBaseWidth = 16.0,
    this.arrowLength = 8.0,
    this.arrowOffsetValue = 0.0,
    this.distanceToTarget = 8.0,
    this.borderWidth = 1.0,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOutCubic,
    this.tooltipShadows,
    this.tooltipAnchorPosition = OverlayAnchorPosition.top,
    this.semanticLabel,
    this.onTap,
    this.onTapOutside,
    required this.target,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveArrowLength = hasArrow ? arrowLength : 0.0;

    final BorderRadius resolvedBorderRadius =
        borderRadius!.resolve(Directionality.of(context));

    return MoonBaseOverlay(
      key: key,
      show: show,
      allowMultipleOverlays: allowMultipleOverlays,
      hideOnTap: hideOnTap,
      semanticLabel: semanticLabel,
      overlayAnchorPosition: tooltipAnchorPosition,
      distanceToTarget: distanceToTarget + effectiveArrowLength,
      overlayMargin: tooltipMargin,
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
      onTap: onTap,
      onTapOutside: onTapOutside,
      target: target,
      child: useDefaultTooltipShape
          ? Builder(
              builder: (BuildContext _) {
                final RenderBox? targetRenderBox =
                    context.findRenderObject() as RenderBox?;

                final OverlayAnchorPosition overlayPosition =
                    getResolvedOverlayPosition(
                  context,
                  targetRenderBox!,
                  tooltipAnchorPosition,
                );

                return DecoratedBox(
                  decoration: ShapeDecoration(
                    color: backgroundColor,
                    shadows: tooltipShadows,
                    shape: TooltipShape(
                      arrowBaseWidth: arrowBaseWidth,
                      arrowLength: effectiveArrowLength,
                      arrowOffset: arrowOffsetValue,
                      arrowTipDistance: distanceToTarget,
                      borderColor: borderColor,
                      borderRadius: resolvedBorderRadius,
                      borderWidth: borderWidth,
                      childWidth: targetRenderBox.size.width,
                      tooltipPosition: overlayPosition,
                    ),
                  ),
                  child: child,
                );
              },
            )
          : child,
    );
  }
}
