import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_core/src/widgets/common/base_overlay_widget.dart';

class TooltipShape extends ShapeBorder {
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double arrowOffset;
  final double arrowBaseWidth;
  final double arrowLength;
  final double arrowTipDistance;
  final double childWidth;
  final OverlayPosition tooltipPosition;

  const TooltipShape({
    required this.borderRadius,
    required this.borderColor,
    required this.borderWidth,
    this.arrowOffset = 0,
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.childWidth,
    required this.tooltipPosition,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double topLeftRadius = borderRadius.topLeft.x;
    final double topRightRadius = borderRadius.topRight.x;
    final double bottomLeftRadius = borderRadius.bottomLeft.x;
    final double bottomRightRadius = borderRadius.bottomRight.x;

    Offset tooltipCenter = rect.center;

    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom - bottomLeftRadius)
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: Radius.circular(topLeftRadius),
        )
        ..lineTo(rect.right - topRightRadius, rect.top)
        ..arcToPoint(
          Offset(rect.right, rect.top + topRightRadius),
          radius: Radius.circular(topRightRadius),
        );
    }

    Path getBottomRightPath(Rect rect) {
      return Path()
        ..moveTo(rect.left + bottomLeftRadius, rect.bottom)
        ..lineTo(rect.right - bottomRightRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.right, rect.bottom - bottomRightRadius),
          radius: Radius.circular(bottomRightRadius),
          clockwise: false,
        )
        ..lineTo(rect.right, rect.top + topRightRadius)
        ..arcToPoint(
          Offset(rect.right - topRightRadius, rect.top),
          radius: Radius.circular(topRightRadius),
          clockwise: false,
        );
    }

    if (tooltipPosition == OverlayPosition.right) {
      tooltipCenter =
          rect.centerLeft.translate(-arrowLength - arrowTipDistance, 0);
    } else if (tooltipPosition == OverlayPosition.left) {
      tooltipCenter =
          rect.centerRight.translate(arrowLength + arrowTipDistance, 0);
    }

    return switch (tooltipPosition) {
      OverlayPosition.top => getLeftTopPath(rect)
        ..lineTo(rect.right, rect.bottom - bottomRightRadius)
        ..arcToPoint(
          Offset(rect.right - bottomRightRadius, rect.bottom),
          radius: Radius.circular(bottomRightRadius),
        )
        // To corner of arrow base.
        ..lineTo(
          min(
            max(
              arrowOffset + tooltipCenter.dx + arrowBaseWidth / 2,
              rect.left + bottomLeftRadius + arrowBaseWidth,
            ),
            rect.right - bottomRightRadius,
          ),
          rect.bottom,
        )
        // To arrow tip.
        ..lineTo(arrowOffset + tooltipCenter.dx, rect.bottom + arrowLength)
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset + tooltipCenter.dx - arrowBaseWidth / 2,
              rect.right - bottomRightRadius - arrowBaseWidth,
            ),
            rect.left + bottomLeftRadius,
          ),
          rect.bottom,
        )
        ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - bottomLeftRadius),
          radius: Radius.circular(bottomLeftRadius),
        )
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: Radius.circular(topLeftRadius),
        ),
      OverlayPosition.bottom => getBottomRightPath(rect)
        // To corner of arrow base.
        ..lineTo(
          min(
            max(
              arrowOffset + tooltipCenter.dx + arrowBaseWidth / 2,
              rect.left + topRightRadius + arrowBaseWidth,
            ),
            rect.right - topRightRadius,
          ),
          rect.top,
        )
        // To arrow tip.
        ..lineTo(arrowOffset + tooltipCenter.dx, rect.top - arrowLength)
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset + tooltipCenter.dx - arrowBaseWidth / 2,
              rect.right - topLeftRadius - arrowBaseWidth,
            ),
            rect.left + topLeftRadius,
          ),
          rect.top,
        )
        ..lineTo(rect.left + topLeftRadius, rect.top)
        ..arcToPoint(
          Offset(rect.left, rect.top + topLeftRadius),
          radius: Radius.circular(topLeftRadius),
          clockwise: false,
        )
        ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
        ..arcToPoint(
          Offset(rect.left + bottomLeftRadius, rect.bottom),
          radius: Radius.circular(bottomLeftRadius),
          clockwise: false,
        ),
      OverlayPosition.left => getLeftTopPath(rect)
        // To corner of arrow base.
        ..lineTo(
          rect.right,
          max(
            min(
              -arrowOffset + tooltipCenter.dy - arrowBaseWidth / 2,
              rect.bottom - bottomRightRadius - arrowBaseWidth,
            ),
            rect.top + topRightRadius,
          ),
        )
        // To arrow tip.
        ..lineTo(
          tooltipCenter.dx - arrowTipDistance,
          -arrowOffset + tooltipCenter.dy,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          rect.right,
          min(
            max(
              -arrowOffset + tooltipCenter.dy + arrowBaseWidth / 2,
              rect.top + topRightRadius + arrowBaseWidth,
            ),
            rect.bottom - bottomRightRadius,
          ),
        )
        ..lineTo(rect.right, rect.bottom - bottomRightRadius)
        ..arcToPoint(
          Offset(rect.right - bottomRightRadius, rect.bottom),
          radius: Radius.circular(bottomRightRadius),
        )
        ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - bottomLeftRadius),
          radius: Radius.circular(bottomLeftRadius),
        ),
      OverlayPosition.right => getBottomRightPath(rect)
        ..lineTo(rect.left + topLeftRadius, rect.top)
        ..arcToPoint(
          Offset(rect.left, rect.top + topLeftRadius),
          radius: Radius.circular(topLeftRadius),
          clockwise: false,
        )
        // To corner of arrow base.
        ..lineTo(
          rect.left,
          max(
            min(
              -arrowOffset + tooltipCenter.dy - arrowBaseWidth / 2,
              rect.bottom - bottomLeftRadius - arrowBaseWidth,
            ),
            rect.top + topLeftRadius,
          ),
        )
        // To arrow tip.
        ..lineTo(
          tooltipCenter.dx + arrowTipDistance,
          -arrowOffset + tooltipCenter.dy,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          rect.left,
          min(
            max(
              -arrowOffset + tooltipCenter.dy + arrowBaseWidth / 2,
              rect.top + topLeftRadius + arrowBaseWidth,
            ),
            rect.bottom - bottomLeftRadius,
          ),
        )
        ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
        ..arcToPoint(
          Offset(rect.left + bottomLeftRadius, rect.bottom),
          radius: Radius.circular(bottomLeftRadius),
          clockwise: false,
        ),
      OverlayPosition.topLeft => getLeftTopPath(rect)
        ..lineTo(rect.right, rect.bottom - bottomRightRadius)
        ..arcToPoint(
          Offset(rect.right - bottomRightRadius, rect.bottom),
          radius: Radius.circular(bottomRightRadius),
        )
        // To corner of arrow base.
        ..lineTo(
          min(
            rect.right - bottomRightRadius,
            max(
              arrowOffset +
                  rect.right -
                  (childWidth / 2) +
                  (arrowBaseWidth / 2),
              rect.left + bottomLeftRadius + arrowBaseWidth,
            ),
          ),
          rect.bottom,
        )
        // To arrow tip.
        ..lineTo(
          arrowOffset + rect.right - (childWidth / 2),
          rect.bottom + arrowLength,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset +
                  rect.right -
                  (childWidth / 2) -
                  (arrowBaseWidth / 2),
              rect.right - bottomRightRadius - arrowBaseWidth,
            ),
            rect.left + bottomLeftRadius,
          ),
          rect.bottom,
        )
        ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - bottomLeftRadius),
          radius: Radius.circular(bottomLeftRadius),
        )
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: Radius.circular(topLeftRadius),
        ),
      OverlayPosition.topRight => getLeftTopPath(rect)
        ..lineTo(rect.right, rect.bottom - bottomRightRadius)
        ..arcToPoint(
          Offset(rect.right - bottomRightRadius, rect.bottom),
          radius: Radius.circular(bottomRightRadius),
        )
        // To corner of arrow base.
        ..lineTo(
          min(
            max(
              arrowOffset + rect.left + (childWidth / 2) + (arrowBaseWidth / 2),
              rect.left + bottomLeftRadius + arrowBaseWidth,
            ),
            rect.right - bottomRightRadius,
          ),
          rect.bottom,
        )
        // To arrow tip.
        ..lineTo(
          arrowOffset + rect.left + (childWidth / 2),
          rect.bottom + arrowLength,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset + rect.left + (childWidth / 2) - (arrowBaseWidth / 2),
              rect.right - bottomRightRadius - arrowBaseWidth,
            ),
            rect.left + bottomLeftRadius,
          ),
          rect.bottom,
        )
        ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
        ..arcToPoint(
          Offset(rect.left, rect.bottom - bottomLeftRadius),
          radius: Radius.circular(bottomLeftRadius),
        )
        ..lineTo(rect.left, rect.top + topLeftRadius)
        ..arcToPoint(
          Offset(rect.left + topLeftRadius, rect.top),
          radius: Radius.circular(topLeftRadius),
        ),
      OverlayPosition.bottomLeft => getBottomRightPath(rect)
        // To corner of arrow base.
        ..lineTo(
          min(
            max(
              arrowOffset +
                  rect.right -
                  (childWidth / 2) +
                  (arrowBaseWidth / 2),
              rect.left + topRightRadius + arrowBaseWidth,
            ),
            rect.right - topRightRadius,
          ),
          rect.top,
        )
        // To arrow tip.
        ..lineTo(
          arrowOffset + rect.right - (childWidth / 2),
          rect.top - arrowLength,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset +
                  rect.right -
                  (childWidth / 2) -
                  (arrowBaseWidth / 2),
              rect.right - bottomRightRadius - arrowBaseWidth,
            ),
            rect.left + topLeftRadius,
          ),
          rect.top,
        )
        ..lineTo(rect.left + topLeftRadius, rect.top)
        ..arcToPoint(
          Offset(rect.left, rect.top + topLeftRadius),
          radius: Radius.circular(topLeftRadius),
          clockwise: false,
        )
        ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
        ..arcToPoint(
          Offset(rect.left + bottomLeftRadius, rect.bottom),
          radius: Radius.circular(bottomLeftRadius),
          clockwise: false,
        ),
      OverlayPosition.bottomRight => getBottomRightPath(rect)
        // To corner of arrow base.
        ..lineTo(
          min(
            max(
              arrowOffset + rect.left + (childWidth / 2) + (arrowBaseWidth / 2),
              rect.left + topRightRadius + arrowBaseWidth,
            ),
            rect.right - topRightRadius,
          ),
          rect.top,
        )
        // To arrow tip.
        ..lineTo(
          arrowOffset + rect.left + (childWidth / 2),
          rect.top - arrowLength,
        )
        // To opposite corner of arrow base.
        ..lineTo(
          max(
            min(
              arrowOffset + rect.left + (childWidth / 2) - (arrowBaseWidth / 2),
              rect.right - bottomRightRadius - arrowBaseWidth,
            ),
            rect.left + topLeftRadius,
          ),
          rect.top,
        )
        ..lineTo(rect.left + topLeftRadius, rect.top)
        ..arcToPoint(
          Offset(rect.left, rect.top + topLeftRadius),
          radius: Radius.circular(topLeftRadius),
          clockwise: false,
        )
        ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
        ..arcToPoint(
          Offset(rect.left + bottomLeftRadius, rect.bottom),
          radius: Radius.circular(bottomLeftRadius),
          clockwise: false,
        ),
      _ => throw AssertionError(tooltipPosition),
    };
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint paint = Paint()
      // If borderWidth is set to 0, set the color to be transparent to avoid
      // strange behavior with border.
      ..color = borderWidth == 0 ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);
    canvas.clipPath(getOuterPath(rect));
  }

  @override
  ShapeBorder scale(double t) {
    return TooltipShape(
      tooltipPosition: tooltipPosition,
      arrowOffset: arrowOffset,
      arrowBaseWidth: arrowBaseWidth,
      arrowLength: arrowLength,
      arrowTipDistance: arrowTipDistance,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      childWidth: childWidth,
      borderColor: borderColor,
    );
  }
}
