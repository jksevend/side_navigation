import 'package:flutter/material.dart';

/// Interface to provide information about the header widget of a [SideNavigationBar]
class SideNavigationBarHeader {
  /// A widget to be displayed at the left side of the header
  final Widget image;

  /// A title widget next to the header
  final Widget title;

  /// A subtitle widget beneath the title
  final Widget subtitle;

  /// Header data
  const SideNavigationBarHeader({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
