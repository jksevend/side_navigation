import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

/// This class provides customizable styling of a [SideNavigationBar] and for [SideNavigationBarItem]
class SideNavigationBarTheme {
  /// The background color of [SideNavigationBar].
  /// If nothing or null is passed it defaults to the color of the parent container
  final Color? backgroundColor;

  /// The theme of a [SideNavigationBarItem]
  final ItemTheme itemTheme;

  /// The theme of a [SideBarToggler]
  final TogglerTheme togglerTheme;

  /// Whether to show a [Divider] between [SideNavigationBarHeader] and [SideNavigationBar.items]
  final bool showHeaderDivider;

  /// Whether to show a [Divider] between [SideNavigationBar] and the content in the [Expanded]
  final bool showMainDivider;

  /// Whether to show a [Divider] between the [SideNavigationBar.items] and [SideNavigationBarFooter]
  final bool showFooterDivider;

  const SideNavigationBarTheme({
    required this.backgroundColor,
    required this.itemTheme,
    required this.togglerTheme,
    required this.showHeaderDivider,
    required this.showMainDivider,
    required this.showFooterDivider,
  });

  /// Default theme
  factory SideNavigationBarTheme.standard() => SideNavigationBarTheme(
        // Inherit from parent unless specifically set
        backgroundColor: null,
        itemTheme: ItemTheme.standard(),
        togglerTheme: TogglerTheme.standard(),
        showHeaderDivider: true,
        showMainDivider: true,
        showFooterDivider: true,
      );
}

/// Customize the styling of [SideNavigationBarItem]
class ItemTheme {
  /// The color of an selected [SideNavigationBarItem].
  /// If nothing or null is passed it defaults to Colors.blue[200]
  final Color? selectedItemColor;

  /// The color of an unselected [SideNavigationBarItem].
  /// If nothing or null is passed it defaults to the appropriate colors based
  /// on the brightness for [Icon] and [Text]
  final Color? unselectedItemColor;

  const ItemTheme({this.selectedItemColor, this.unselectedItemColor});

  /// Default theme
  factory ItemTheme.standard() => ItemTheme(
        selectedItemColor: Colors.blue[200]!,
        // Brightness dependant
        unselectedItemColor: null,
      );
}

/// Customize the styling of [SideBarToggler]
class TogglerTheme {
  /// The color of [SideBarToggler.expandIcon].
  /// If nothing or null is passed it defaults to native brightness colors
  final Color? expandIconColor;

  /// The color of [SideBarToggler.shrinkIcon].
  /// If nothing or null is passed it defaults to native brightness colors
  final Color? shrinkIconColor;

  const TogglerTheme({this.expandIconColor, this.shrinkIconColor});

  /// Default theme
  factory TogglerTheme.standard() => const TogglerTheme(
        // Brightness dependant
        expandIconColor: null,
        shrinkIconColor: null,
      );
}
