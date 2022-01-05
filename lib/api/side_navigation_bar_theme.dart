import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar_footer.dart';

/// This class provides customizable styling of a [SideNavigationBar], its'
/// [SideNavigationBarHeader], [SideNavigationBarFooter] and for [SideNavigationBarItem]
class SideNavigationBarTheme {
  /// The background color of [SideNavigationBar].
  /// If nothing or null is passed it defaults to the color of the parent container
  final Color? backgroundColor;
  final HeaderTheme headerTheme;
  final FooterTheme footerTheme;
  final ItemTheme itemTheme;
  final bool showHeaderDivider;
  final bool showMainDivider;
  final bool showFooterDivider;

  SideNavigationBarTheme({
    required this.backgroundColor,
    required this.headerTheme,
    required this.footerTheme,
    required this.itemTheme,
    required this.showHeaderDivider,
    required this.showMainDivider,
    required this.showFooterDivider,
  });

  /// Default theme
  factory SideNavigationBarTheme.standard() => SideNavigationBarTheme(
        // Inherit from parent unless specifically set
        backgroundColor: null,
        headerTheme: HeaderTheme.standard(),
        footerTheme: FooterTheme.standard(),
        itemTheme: ItemTheme.standard(),
        showHeaderDivider: true,
        showMainDivider: true,
        showFooterDivider: true,
      );
}

/// Customize the styling of [SideNavigationBarHeader]
class HeaderTheme {
  HeaderTheme();

  /// Default theme
  factory HeaderTheme.standard() => HeaderTheme();
}

/// Customize the styling of [SideNavigationBarFooter]
class FooterTheme {
  FooterTheme();

  /// Default theme
  factory FooterTheme.standard() => FooterTheme();
}

/// Customize the styling of [SideNavigationBarItem]
class ItemTheme {
  /// The [Color] of an selected [SideNavigationBarItem].
  /// If nothing or null is passed it defaults to Colors.blue[200]
  final Color? selectedItemColor;
  ItemTheme({this.selectedItemColor});

  /// Default theme
  factory ItemTheme.standard() => ItemTheme(
    selectedItemColor: Colors.blue[200]!,
  );
}
