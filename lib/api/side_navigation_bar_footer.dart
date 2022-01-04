import 'package:flutter/material.dart';

/// Interface to provide information about the footer widget of a [SideNavigationBar]
class SideNavigationBarFooter {
  /// The [IconData] to use when the [SideNavigationBar] is not in its expanded state
  final IconData expandIcon;

  /// The [IconData] to use when the [SideNavigationBar] is in its expanded state.
  final IconData shrinkIcon;

  /// A [Widget] to display above the [expandIcon] and [shrinkIcon]
  final Widget label;

  /// Footer data
  const SideNavigationBarFooter({
    this.expandIcon = Icons.arrow_right,
    this.shrinkIcon = Icons.arrow_left,
    required this.label,
  });
}
