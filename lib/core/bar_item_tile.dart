import 'package:flutter/material.dart';

import 'package:side_navigation/api/side_navigation_bar_item.dart';
import 'package:side_navigation/api/side_navigation_bar.dart';

/// This widget uses the [icon] and [label] value from the [SideNavigationBarItem]
/// to generate a completely new widget which provides an [onTap] callback while
/// it also holds the [index] of its position defined in the [SideNavigationBar]'s
/// [SideNavigationBar.items]
class SideNavigationBarItemTile extends StatefulWidget {
  /// From [SideNavigationBarItem]
  /// What [IconData] to display
  final IconData icon;

  /// From [SideNavigationBarItem]
  /// Info text about the choosable navigation option
  final String label;

  /// From [SideNavigationBar]
  /// What to do on item tap
  final ValueChanged<int> onTap;

  /// From [SideNavigationBar]
  /// The currently selected index which the end user chooses
  final int index;

  final Color color;
  final bool collapsed;
  const SideNavigationBarItemTile(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onTap,
      required this.index,
      required this.color,
      required this.collapsed})
      : super(key: key);

  @override
  _SideNavigationBarItemTileState createState() =>
      _SideNavigationBarItemTileState();
}

class _SideNavigationBarItemTileState extends State<SideNavigationBarItemTile> {
  @override
  Widget build(BuildContext context) {
    // Get the data holders from the parent
    final List<SideNavigationBarItem> barItems =
        SideNavigationBar.of(context).widget.items;
    // Get the current selected index from the parent
    final int selectedIndex =
        SideNavigationBar.of(context).widget.selectedIndex;
    // Check if this tile is selected
    final bool isSelected = _isTileSelected(barItems, selectedIndex);

    /// Return a basic listtile for now
    return widget.collapsed
        ? IconButton(
            icon: Icon(
              widget.icon,
              color: _getTileColor(isSelected),
            ),
            onPressed: () {
              widget.onTap(widget.index);
            },
          )
        : ListTile(
            leading: Icon(
              widget.icon,
              color: _getTileColor(isSelected),
            ),
            title: Text(
              widget.label,
              style: TextStyle(
                color: _getTileColor(isSelected),
              ),
            ),
            onTap: () {
              widget.onTap(widget.index);
            },
          );
  }

  /// Determines if this tile is currently selected
  ///
  /// Looks at the both item labels to compare wheter they are equal
  /// and compares the parents [index] with this tiles index
  bool _isTileSelected(
      final List<SideNavigationBarItem> items, final int index) {
    for (final SideNavigationBarItem item in items) {
      if (item.label == widget.label && index == widget.index) {
        return true;
      }
    }
    return false;
  }

  /// Check if this item [isSelected] and return the passed [widget.color]
  /// If it is not selected return either [Colors.white] or [Colors.grey] based on the
  /// [Brightness]
  Color _getTileColor(final bool isSelected) {
    return isSelected
        ? widget.color
        : (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.grey);
  }
}
