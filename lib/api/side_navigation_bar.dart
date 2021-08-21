import 'package:flutter/material.dart';
import 'package:side_navigation/core/bar_item_tile.dart';

import 'side_navigation_bar_header.dart';
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

  /// A simple header widget
  final SideNavigationBarHeader header;

  /// The background [Color] of the [SideNavigationBar]. If nothing or null is passed it defaults to the
  /// color of the parent container
  final Color? color;

  /// The [Color] of an selected [SideNavigationBarItem]. If nothing or null is passed it defaults to
  /// Colors.blue[200]
  final Color? selectedItemColor;

  /// Specifies wheter that [SideNavigationBar] is collapsable or not. Default is true
  final bool collapsable;

  const SideNavigationBar(
      {Key? key,
      required this.selectedIndex,
      required this.items,
      required this.onTap,
      required this.header,
      this.color,
      this.selectedItemColor,
      this.collapsable = true})
      : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();

  static _SideNavigationBarState of(BuildContext context) =>
      context.findAncestorStateOfType<_SideNavigationBarState>()!;
}

class _SideNavigationBarState extends State<SideNavigationBar>
    with SingleTickerProviderStateMixin {
  final double minWidth = 50;
  final double maxWidth = 200;
  late double width;

  bool collapsed = false;

  @override
  void initState() {
    super.initState();
    width = maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          right: BorderSide(
            width: 1,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey[700]!
                : Colors.white,
          ),
        ),
      ),
      child: AnimatedSize(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 350),
        vsync: this,
        child: SizedBox(
            width: width,
            height: double.infinity,
            child: Column(
              children: [
                // Header
                collapsed
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: widget.header.leading,
                      )
                    : widget.header,
                const Divider(),
                // Navigation content
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: _generateItems(collapsed),
                    ),
                  ),
                ),
                // Toggler widget (Footer)
                widget.collapsable
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: Icon(
                              collapsed ? Icons.arrow_right : Icons.arrow_left),
                          onPressed: () {
                            setState(() {
                              if (collapsed) {
                                width = maxWidth;
                              } else {
                                width = minWidth;
                              }
                              collapsed = !collapsed;
                            });
                          },
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(),
                      ),
              ],
            )),
      ),
    );
  }

  /// Takes [SideNavigationBarItem] data and builds new widgets with it.
  List<Widget> _generateItems(final bool _expanded) {
    List<Widget> _items = widget.items
        .asMap()
        .entries
        .map<SideNavigationBarItemTile>(
            (MapEntry<int, SideNavigationBarItem> entry) {
      return SideNavigationBarItemTile(
          icon: entry.value.icon,
          label: entry.value.label,
          onTap: widget.onTap,
          index: entry.key,
          collapsed: collapsed,
          color: _validateSelectedItemColor());
    }).toList();
    return _items;
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
