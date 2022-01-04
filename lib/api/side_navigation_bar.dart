import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar_footer.dart';
import 'package:side_navigation/api/side_navigation_bar_header.dart';
import 'package:side_navigation/core/bar_footer.dart';
import 'package:side_navigation/core/bar_header.dart';
import 'package:side_navigation/core/bar_item.dart';

import 'side_navigation_bar_item.dart';

/// The main widget for building a side navigation bar.
///
/// * [selectedIndex] defines what item of the navigation options is currently selected.
/// * [items] are the main options for creating different routes
/// * [onTap] provides a callback that [selectedIndex] has changed.
/// * [header] is the widget to display at the top of the bar
/// * [footer] is the widget to display at the bottom of the bar. it also includes the toggler widget
/// * [color] for the background of the bar
/// * [selectedItemColor] is the color an item has when it is selected
/// * [expandable] defines whether this bar should be expandable at all.
/// * [initiallyExpanded] defines if the bar should be expanded on startup.
class SideNavigationBar extends StatefulWidget {
  /// The current index of the navigation bar
  final int selectedIndex;

  /// The items to put into the bar
  final List<SideNavigationBarItem> items;

  /// What to do when an item as been tapped
  final ValueChanged<int> onTap;

  /// The header of the bar
  final SideNavigationBarHeader header;

  /// The footer of the bar
  final SideNavigationBarFooter footer;

  /// The background [Color] of the [SideNavigationBar]
  /// If nothing or null is passed it defaults to the color of the parent container
  final Color? color;

  /// The [Color] of an selected [SideNavigationBarItem]
  /// If nothing or null is passed it defaults to Colors.blue[200]
  final Color? selectedItemColor;

  /// Specifies whether that [SideNavigationBar] is expandable or not
  /// True by default
  final bool expandable;

  /// Specifies whether [SideNavigationBar] should be expanded when building it.
  /// True by default
  final bool initiallyExpanded;

  const SideNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    required this.header,
    required this.footer,
    this.color,
    this.selectedItemColor,
    this.expandable = true,
    this.initiallyExpanded = true,
  }) : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();

  /// Access [_SideNavigationBarState] from outside based on [context]
  static _SideNavigationBarState of(final BuildContext context) {
    final _SideNavigationBarState? state =
        context.findAncestorStateOfType<_SideNavigationBarState>();
    if (state == null) {
      throw StateError('Trying to access null state _SideNavigationBarState');
    }
    return state;
  }
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  /// TODO: Maybe find some way using layout out builder here
  final double _minWidth = 50;
  final double _maxWidth = 230;

  /// The width of the bar used for animation
  late double _width;

  /// Whether this bar is in its expanded state
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _evaluateInitialStructure();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          right: BorderSide(
            width: 0.5,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey[700]!
                : Colors.white,
          ),
        ),
      ),
      child: AnimatedSize(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 350),
        child: SizedBox(
          width: _width,
          height: double.infinity,
          child: Column(
            children: [
              // Header
              SideNavigationBarHeaderWidget(
                headerData: widget.header,
                expandable: widget.expandable,
                expanded: _expanded,
              ),
              const Divider(),
              // Navigation content
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: _generateItems(),
                  ),
                ),
              ),
              const Divider(),
              // Footer
              SideNavigationBarFooterWidget(
                footerData: widget.footer,
                expandable: widget.expandable,
                expanded: _expanded,
                onToggle: () => toggle(),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Toggles this widget. Determine width here for now
  void toggle() {
    setState(() {
      if (_expanded) {
        _width = _minWidth;
      } else {
        _width = _maxWidth;
      }
      _expanded = !_expanded;
    });
  }

  /// Sets the [_width] value of the container which is animated
  /// This happens based on whether the bar is [expandable] (Default true) at all and
  /// if the bar should be [initiallyExpanded] (Default true)
  void _evaluateInitialStructure() {
    // If the bar need to be expandable
    if (widget.expandable) {
      // Work out what initiallyExpanded value is
      if (widget.initiallyExpanded) {
        _expanded = widget.initiallyExpanded;
        _width = _maxWidth;
      } else {
        _expanded = widget.initiallyExpanded;
        _width = _minWidth;
      }
      // Bar should not be expandable - default is expanded state
    } else {
      _expanded = true;
      _width = _maxWidth;
    }
  }

  /// Generates [SideNavigationBarItemWidget] based on data provided in the interface
  /// [SideNavigationBarItem]
  List<Widget> _generateItems() {
    List<Widget> _items = widget.items
        .asMap()
        .entries
        .map<SideNavigationBarItemWidget>(
            (MapEntry<int, SideNavigationBarItem> entry) => SideNavigationBarItemWidget(
                  icon: entry.value.icon,
                  label: entry.value.label,
                  onTap: widget.onTap,
                  index: entry.key,
                  expanded: _expanded,
                  color: _evaluateSelectedItemColor(),
                ))
        .toList();
    return _items;
  }

  /// Checks what was passed as [widget.selectedItemColor]
  /// If nothing was passed return the default value
  /// If a color was passed use that
  Color _evaluateSelectedItemColor() {
    final Color? color;
    if (widget.selectedItemColor == null) {
      color = Colors.blue[200]!;
    } else {
      color = widget.selectedItemColor!;
    }
    return color;
  }
}
