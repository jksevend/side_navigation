import 'package:flutter/material.dart';
import 'package:side_navigation/core/bar_item_tile.dart';

import 'side_navigation_bar_item.dart';

/// Takes the data from [items] and builds [SideNavigationBarItemTile] with it.
///
/// [selectedIndex] is handled by the user. It defines what item of the navigation
/// options is currently selected.
///
/// Use [onTap] to provide a callback that [selectedIndex] has changed.
///
class SideNavigationBar extends StatefulWidget {
  /// The current index of the navigation bar
  final int selectedIndex;

  /// The items to put into the bar
  final List<SideNavigationBarItem> items;

  /// What to do when an item as been tapped
  final ValueChanged<int> onTap;

  /// The [Color] of an selected item. If nothing or null is passed it defaults to
  /// Colors.blue[200]
  final Color? selectedItemColor;
  const SideNavigationBar(
      {Key? key,
      required this.selectedIndex,
      required this.items,
      required this.onTap,
      this.selectedItemColor})
      : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();

  static _SideNavigationBarState of(BuildContext context) =>
      context.findAncestorStateOfType<_SideNavigationBarState>()!;
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  final double width = 225;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey[700]!
                : Colors.white,
          ),
        ),
      ),
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: ListView(
          children: _generateItems(),
        ),
      ),
    );
  }

  /// Takes [SideNavigationBarItem] data and builds new widgets with it.
  List<SideNavigationBarItemTile> _generateItems() {
    return widget.items.asMap().entries.map<SideNavigationBarItemTile>(
        (MapEntry<int, SideNavigationBarItem> entry) {
      return SideNavigationBarItemTile(
          icon: entry.value.icon,
          label: entry.value.label,
          onTap: widget.onTap,
          index: entry.key,
          color: _validateSelectedItemColor());
    }).toList();
  }

  /// Checks what was passed as [widget.selectedItemColor]
  /// If nothing was passed return the default value
  /// If a color was passed use that
  Color _validateSelectedItemColor() {
    final Color? color;
    if (widget.selectedItemColor == null) {
      color = Colors.blue[200]!;
    } else {
      color = widget.selectedItemColor!;
    }
    return color;
  }
}
