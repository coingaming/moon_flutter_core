import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MoonRawBreadcrumbItem {
  /// The semantic label for the breadcrumb item.
  final String? semanticLabel;

  /// The style of the breadcrumb item.
  final Style? style;

  /// The callback that is called when the breadcrumb item is tapped or pressed.
  /// If the [onTap] is null, the breadcrumb item is disabled.
  ///
  /// For [MoonRawBreadcrumb.showMoreWidget], if [onTap] is null, default
  /// action to show all collapsed items is applied.
  final VoidCallback? onTap;

  /// The main content of the breadcrumb item.
  final Widget child;

  /// Creates a Moon Design breadcrumb item.
  const MoonRawBreadcrumbItem({
    this.semanticLabel,
    this.style,
    this.onTap,
    required this.child,
  });
}
