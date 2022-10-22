import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

/// This widget uses information obtained from [SideNavigationBarItem]
/// to generate the widget which provides an [onTap] callback while
/// it also holds the [index] of its position defined in the [SideNavigationBar]'s
/// [SideNavigationBar.items] field.
class SideNavigationBarItemWidget extends StatefulWidget {
  /// Item data obtained from user
  final SideNavigationBarItem itemData;

  /// What to do on item tap
  final ValueChanged<int> onTap;

  /// The currently selected index which the user chooses
  final int index;

  /// Style customizations
  final SideNavigationBarItemTheme itemTheme;

  /// The current [expanded] state of [SideNavigationBar]
  final bool expanded;

  const SideNavigationBarItemWidget({
    Key? key,
    required this.itemData,
    required this.onTap,
    required this.index,
    required this.itemTheme,
    required this.expanded,
  }) : super(key: key);

  @override
  _SideNavigationBarItemWidgetState createState() =>
      _SideNavigationBarItemWidgetState();
}

class _SideNavigationBarItemWidgetState
    extends State<SideNavigationBarItemWidget> {
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
    // The color of the icon and text to be displayed
    final Color? currentColor = _evaluateColor(context, isSelected);

    /// Return a basic list-tile for now
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: widget.itemData.label,
      child: widget.expanded
          ? ListTile(
              tileColor: _evaluateBackgroundColor(isSelected),
              leading: Icon(
                widget.itemData.icon,
                color: currentColor,
                size: widget.itemTheme.iconSize,
              ),
              title: Text(
                widget.itemData.label,
                style: _evaluateTextStyle(currentColor),
              ),
              onTap: () {
                widget.onTap(widget.index);
              },
            )
          : Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: _evaluateBackgroundColor(isSelected),
                  shape: widget.itemTheme.iconShape,
                ),
                child: IconButton(
                  icon: Icon(
                    widget.itemData.icon,
                    color: currentColor,
                    size: widget.itemTheme.iconSize,
                  ),
                  onPressed: () {
                    widget.onTap(widget.index);
                  },
                ),
              ),
            ),
    );
  }

  /// Determines if this tile is currently selected
  ///
  /// Looks at the both item labels to compare whether they are equal
  /// and compares the parents [index] with this tiles index
  bool _isTileSelected(
      final List<SideNavigationBarItem> items, final int index) {
    for (final SideNavigationBarItem item in items) {
      if (item.label == widget.itemData.label && index == widget.index) {
        return true;
      }
    }
    return false;
  }

  /// Check if this item [isSelected] and return the passed [widget.selectedColor]
  /// If it is not selected return either [Colors.white] or [Colors.grey] based on the
  /// [Brightness]
  Color? _evaluateColor(final BuildContext context, final bool isSelected) {
    final Brightness brightness = Theme.of(context).brightness;
    return isSelected
        // If selectedItemColor is null we pass the default
        ? widget.itemTheme.selectedItemColor ??
            SideNavigationBarItemTheme.defaultSelectedItemColor
        // If unselectedItemColor is null we evaluate current brightness and return either grey or white
        : widget.itemTheme.unselectedItemColor ??
            (brightness == Brightness.light ? Colors.grey : Colors.white);
  }

  /// Check if item [isSelected] and return appropriate background color
  Color? _evaluateBackgroundColor(final bool isSelected) {
    return isSelected
        ? widget.itemTheme.selectedBackgroundColor
        : widget.itemTheme.unselectedBackgroundColor;
  }

  /// Evaluate what text style to use for an item based on a
  /// previously [evaluatedColor] based whether this item is selected
  TextStyle? _evaluateTextStyle(final Color? evaluatedColor) {
    // No custom styled passed via theme - using default empty theme with color
    if (widget.itemTheme.labelTextStyle == null) {
      return TextStyle(
        color: evaluatedColor,
      );
    }
    // Return custom text style overridden with evaluated color
    return widget.itemTheme.labelTextStyle!.apply(color: evaluatedColor);
  }
}
