import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar.dart';
import 'package:side_navigation/api/side_navigation_bar_item.dart';

/// This widget uses information obtained from [SideNavigationBarItem]
/// to generate the widget which provides an [onTap] callback while
/// it also holds the [index] of its position defined in the [SideNavigationBar]'s
/// [SideNavigationBar.items] field.
class SideNavigationBarItemWidget extends StatefulWidget {
  /// The icon to display
  final IconData icon;

  /// Info text about the route
  final String label;

  /// What to do on item tap
  final ValueChanged<int> onTap;

  /// The currently selected index which the user chooses
  final int index;

  /// The color of the tile
  final Color color;

  /// The current [expanded] state of [SideNavigationBar]
  final bool expanded;

  const SideNavigationBarItemWidget(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onTap,
      required this.index,
      required this.color,
      required this.expanded})
      : super(key: key);

  @override
  _SideNavigationBarItemWidgetState createState() => _SideNavigationBarItemWidgetState();
}

class _SideNavigationBarItemWidgetState extends State<SideNavigationBarItemWidget> {
  @override
  Widget build(BuildContext context) {
    // Get the data holders from the parent
    final List<SideNavigationBarItem> barItems = SideNavigationBar.of(context).widget.items;
    // Get the current selected index from the parent
    final int selectedIndex = SideNavigationBar.of(context).widget.selectedIndex;
    // Check if this tile is selected
    final bool isSelected = _isTileSelected(barItems, selectedIndex);

    /// Return a basic list-tile for now
    return widget.expanded
        ? ListTile(
            leading: Icon(
              widget.icon,
              color: _getSelectedTileColor(isSelected),
            ),
            title: Text(
              widget.label,
              style: TextStyle(
                color: _getSelectedTileColor(isSelected),
              ),
            ),
            onTap: () {
              widget.onTap(widget.index);
            },
          )
        : IconButton(
            icon: Icon(
              widget.icon,
              color: _getSelectedTileColor(isSelected),
            ),
            onPressed: () {
              widget.onTap(widget.index);
            },
          );
  }

  /// Determines if this tile is currently selected
  ///
  /// Looks at the both item labels to compare whether they are equal
  /// and compares the parents [index] with this tiles index
  bool _isTileSelected(final List<SideNavigationBarItem> items, final int index) {
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
  Color _getSelectedTileColor(final bool isSelected) {
    return isSelected
        ? widget.color
        : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey);
  }
}
