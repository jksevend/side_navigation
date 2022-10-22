import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

/// This class provides customizable styling of a [SideNavigationBar] and for [SideNavigationBarItem]
class SideNavigationBarTheme {
  /// The background color of [SideNavigationBar].
  /// If nothing or null is passed it defaults to the color of the parent container
  final Color? backgroundColor;

  /// The theme of a [SideNavigationBarItem]
  final SideNavigationBarItemTheme itemTheme;

  /// The theme of a [SideBarToggler]
  final SideNavigationBarTogglerTheme togglerTheme;

  /// The theme of [Divider]s
  final SideNavigationBarDividerTheme dividerTheme;

  const SideNavigationBarTheme({
    required this.itemTheme,
    required this.togglerTheme,
    required this.dividerTheme,
    this.backgroundColor,
  });

  /// Default theme
  factory SideNavigationBarTheme.standard() => SideNavigationBarTheme(
        // Inherit from parent unless specifically set
        backgroundColor: null,
        itemTheme: SideNavigationBarItemTheme.standard(),
        togglerTheme: SideNavigationBarTogglerTheme.standard(),
        dividerTheme: SideNavigationBarDividerTheme.standard(),
      );
}

/// Customize the styling of [SideNavigationBarItem]
class SideNavigationBarItemTheme {
  /// Default color for text and icon of selected item
  static final Color defaultSelectedItemColor = Colors.blue[200]!;

  /// The color of an selected [SideNavigationBarItem].
  /// If nothing or null is passed it defaults to Colors.blue[200]
  final Color? selectedItemColor;

  /// The color of an unselected [SideNavigationBarItem].
  /// If nothing or null is passed it defaults to the appropriate colors based
  /// on the brightness for [Icon] and [Text]
  final Color? unselectedItemColor;

  /// The background color for an selected [SideNavigationBarItem]
  final Color? selectedBackgroundColor;

  /// The background color for a non-selected [SideNavigationBarItem]
  final Color? unselectedBackgroundColor;

  /// The shape for [SideNavigationBarItem.icon] when the [SideNavigationBar] is minimized
  final ShapeBorder iconShape;

  /// The size of an [SideNavigationBarItem.icon]
  /// If nothing or null is passed flutter will do the sizing
  final double? iconSize;

  /// Styling of label text [SideNavigationBarItem.label]
  /// If nothing or null is passed flutter will handle styling although they will **ALWAYS**
  /// be overridden with [selectedItemColor] and [unselectedItemColor]
  final TextStyle? labelTextStyle;

  /// Named Constructor
  SideNavigationBarItemTheme({
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.iconShape = const CircleBorder(),
    this.iconSize,
    this.labelTextStyle,
  });

  /// Default theme
  factory SideNavigationBarItemTheme.standard() => SideNavigationBarItemTheme(
        selectedItemColor: defaultSelectedItemColor,
        // Brightness dependant
        unselectedItemColor: null,
        iconSize: null,
        labelTextStyle: null,
        selectedBackgroundColor: null,
        iconShape: const CircleBorder(),
        unselectedBackgroundColor: null,
      );
}

/// Customize the styling of [SideBarToggler]
class SideNavigationBarTogglerTheme {
  /// The color of [SideBarToggler.expandIcon].
  /// If nothing or null is passed it defaults to native brightness colors
  final Color? expandIconColor;

  /// The color of [SideBarToggler.shrinkIcon].
  /// If nothing or null is passed it defaults to native brightness colors
  final Color? shrinkIconColor;

  const SideNavigationBarTogglerTheme(
      {this.expandIconColor, this.shrinkIconColor});

  /// Default theme
  factory SideNavigationBarTogglerTheme.standard() =>
      const SideNavigationBarTogglerTheme(
        // Brightness dependant
        expandIconColor: null,
        shrinkIconColor: null,
      );
}

class SideNavigationBarDividerTheme {
  /// Whether to show a [Divider] between [SideNavigationBarHeader] and [SideNavigationBar.items]
  final bool showHeaderDivider;

  /// The color of the header divider
  final Color? headerDividerColor;

  /// The thickness of the header divider
  final double? headerDividerThickness;

  /// Whether to show a [Divider] between [SideNavigationBar] and the content in the [Expanded]
  final bool showMainDivider;

  /// The color of the main divider
  final Color? mainDividerColor;

  /// The thickness of the main divider
  final double? mainDividerThickness;

  /// Whether to show a [Divider] between the [SideNavigationBar.items] and [SideNavigationBarFooter]
  final bool showFooterDivider;

  /// The color of the footer divider
  final Color? footerDividerColor;

  /// The thickness of the footer divider
  final double? footerDividerThickness;

  /// Constructor
  const SideNavigationBarDividerTheme({
    required this.showHeaderDivider,
    required this.showMainDivider,
    required this.showFooterDivider,
    this.headerDividerColor,
    this.headerDividerThickness,
    this.mainDividerColor,
    this.mainDividerThickness,
    this.footerDividerColor,
    this.footerDividerThickness,
  });

  /// Returns default values
  factory SideNavigationBarDividerTheme.standard() =>
      const SideNavigationBarDividerTheme(
        showHeaderDivider: true,
        headerDividerColor: null,
        headerDividerThickness: null,
        showMainDivider: true,
        mainDividerColor: null,
        mainDividerThickness: null,
        showFooterDivider: true,
        footerDividerColor: null,
        footerDividerThickness: null,
      );
}
