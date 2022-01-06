import 'package:flutter/material.dart';

/// Interface to provide information about the footer widget of a [SideNavigationBar]
class SideNavigationBarFooter {
  /// A [Widget] to display above the [expandIcon] and [shrinkIcon]
  final Widget label;

  /// Footer data
  const SideNavigationBarFooter({required this.label});
}
