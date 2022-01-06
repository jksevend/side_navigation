import 'package:flutter/material.dart';

/// A toggler used for shrinking and expanding a [SideNavigationBar]
///
/// Provides an optional [onToggle] callback where you can react to changes of the expanded state.
class SideBarToggler {
  /// The [IconData] to use when the [SideNavigationBar] is not in its expanded state
  final IconData expandIcon;

  /// The [IconData] to use when the [SideNavigationBar] is in its expanded state.
  final IconData shrinkIcon;

  /// Optional callback to perform actions **AFTER** [SideNavigationBar]'s state changes.
  final VoidCallback? onToggle;

  /// Toggler data
  const SideBarToggler(
      {this.expandIcon = Icons.arrow_right,
      this.shrinkIcon = Icons.arrow_left,
      this.onToggle});
}
