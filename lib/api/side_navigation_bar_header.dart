import 'package:flutter/material.dart';

/// This acts as a data holder for a header that displays 2 images, one when expanded and one when collapsed
class SideNavigationBarHeader {
  final String collapsedAsset;
  final String expandedAsset;
  final double height;
  const SideNavigationBarHeader(
      {required this.expandedAsset, required this.collapsedAsset, required this.height});

  Widget generateWidget(final BuildContext context, final bool expanded, final double width) {
    Color c = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey;
    String asset = expanded ? expandedAsset : collapsedAsset;

    return Image.asset(
      asset,
      color: c,
      height: height,
      width: width,
    );
  }
}
