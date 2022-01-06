import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:side_navigation/src/core/bar_footer.dart';
import 'package:side_navigation/src/core/bar_header.dart';
import 'package:side_navigation/src/core/bar_item.dart';
import 'package:side_navigation/src/core/bar_toggler.dart';

/// The main widget for building a side navigation bar.
///
/// * [selectedIndex] defines what item of the navigation options is currently selected.
/// * [items] are the main options for creating different routes
/// * [onTap] provides a callback that [selectedIndex] has changed.
/// * [header] is the widget to display at the top of the bar
/// * [footer] is the widget to display at the bottom of the bar. it also includes the toggler widget
/// * [toggler] is the toggler used when expanding/shrinking the bar.
/// * [theme] provides a configuration to customize certain parts of the bar
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
  final SideNavigationBarHeader? header;

  /// The footer of the bar
  final SideNavigationBarFooter? footer;

  /// Optional toggler widget
  final SideBarToggler? toggler;

  /// Theme data of the bar.
  /// If nothing or null is passed it defaults to [SideNavigationBarTheme.standard]
  final SideNavigationBarTheme? theme;

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
    this.header,
    this.footer,
    this.toggler,
    this.theme,
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

  /// Chooses [SideNavigationBarTheme.standard] or [widget.theme]
  late SideNavigationBarTheme theme;

  @override
  void initState() {
    super.initState();
    _evaluateInitialStructure();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: _evaluateMainDivider(),
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
              _evaluateHeaderWidget(),
              _evaluateHeaderDivider(),
              // Navigation content
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: _generateItems(),
                  ),
                ),
              ),
              _evaluateFooterDivider(),
              // Footer
              _evaluateFooterWidget(),
              _evaluateTogglerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// Toggles this widget. Determine width here for now.
  /// Optionally calls a [SideBarToggler.onToggle] call to react to [_expanded] changes
  void _toggle() {
    setState(() {
      if (_expanded) {
        _width = _minWidth;
      } else {
        _width = _maxWidth;
      }
      _expanded = !_expanded;
    });
    // Check if a custom onToggle is provided and call after (or before?) internal logic
    widget.toggler?.onToggle?.call();
  }

  /// Evaluate whether [theme] should be the [SideNavigationBarTheme.standard] or provided
  /// [SideNavigationBar.theme].
  ///
  /// Also ,it sets the [_width] value of the container which is animated
  /// This happens based on whether the bar is [expandable] (Default true) at all and
  /// if the bar should be [initiallyExpanded] (Default true)
  void _evaluateInitialStructure() {
    // Evaluate the theme
    theme = widget.theme ?? SideNavigationBarTheme.standard();
    // If the bar need to be expandable
    if (widget.expandable) {
      _evaluateInitiallyExpanded();
    } else {
      _evaluateInitiallyExpanded();
    }
  }

  /// Evaluate that initial state of the [SideNavigationBar]
  void _evaluateInitiallyExpanded() {
    if (widget.initiallyExpanded) {
      _expanded = widget.initiallyExpanded;
      _width = _maxWidth;
    } else {
      _expanded = widget.initiallyExpanded;
      _width = _minWidth;
    }
  }

  /// Generates [SideNavigationBarItemWidget] based on data provided in the interface
  /// [SideNavigationBarItem]
  List<Widget> _generateItems() {
    List<Widget> _items = widget.items
        .asMap()
        .entries
        .map<SideNavigationBarItemWidget>(
            (MapEntry<int, SideNavigationBarItem> entry) =>
                SideNavigationBarItemWidget(
                  itemData: entry.value,
                  onTap: widget.onTap,
                  itemTheme: theme.itemTheme,
                  index: entry.key,
                  expanded: _expanded,
                ))
        .toList();
    return _items;
  }

  /// Determines if a [SideNavigationBarHeader] was provided
  Widget _evaluateHeaderWidget() {
    if (widget.header != null) {
      return SideNavigationBarHeaderWidget(
        headerData: widget.header!,
        expandable: widget.expandable,
        expanded: _expanded,
        initiallyExpanded: widget.initiallyExpanded,
      );
    }
    return Container();
  }

  /// Determines if a [SideNavigationBarFooter] was provided
  Widget _evaluateFooterWidget() {
    if (widget.footer != null) {
      return SideNavigationBarFooterWidget(
        footerData: widget.footer!,
        expandable: widget.expandable,
        expanded: _expanded,
        initiallyExpanded: widget.initiallyExpanded,
      );
    }
    return Container();
  }

  /// Logic to handle building the toggler widget.
  ///
  /// If [SideNavigationBar.expandable] is false but a [SideBarToggler] is provided
  /// a StateError is thrown.
  ///
  /// If [SideNavigationBar.expandable] is false no toggler is returned.
  ///
  /// Then figure out if a toggler was provided or not and build the [SideBarTogglerWidget]
  Widget _evaluateTogglerWidget() {
    // We dont want that
    if (!widget.expandable && widget.toggler != null) {
      throw StateError(
          'SideNavigationBar is not expandable but a SideBarToggler is given.');
    }

    // Toggler is not needed if the bar is not expandable
    if (!widget.expandable) {
      return Container();
    }

    // Toggler is provided, use it
    if (widget.toggler != null) {
      return SideBarTogglerWidget(
        togglerTheme: theme.togglerTheme,
        togglerData: widget.toggler!,
        expanded: _expanded,
        onToggle: () => _toggle(),
      );
    } else {
      // Create the default toggler and use it
      const SideBarToggler barToggler = SideBarToggler();
      return SideBarTogglerWidget(
        togglerTheme: theme.togglerTheme,
        togglerData: barToggler,
        expanded: _expanded,
        onToggle: () => _toggle(),
      );
    }
  }

  /// Determines whether to put a [Border] between the bar and the main content
  ///
  /// Influenced by [SideNavigationBarTheme.showMainDivider]
  Border? _evaluateMainDivider() {
    if (!theme.showMainDivider) {
      return null;
    }
    return Border(
      right: BorderSide(
        width: 0.5,
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.grey[700]!
            : Colors.white,
      ),
    );
  }

  /// Determines if a [Divider] should be displayed between the [SideNavigationBarHeaderWidget] and
  /// the [SideNavigationBar.items]
  ///
  /// Influenced by [SideNavigationBarTheme.showHeaderDivider]
  /// If no [SideNavigationBarHeader] was provided no Divider is returned
  Widget _evaluateHeaderDivider() {
    if (!theme.showHeaderDivider) {
      return Container();
    }

    if (widget.header == null) {
      return Container();
    }
    return const Divider();
  }

  /// Determines if a [Divider] should be displayed between the [SideNavigationBarFooterWidget] and
  /// the [SideNavigationBar.items]
  ///
  /// Influenced by [SideNavigationBarTheme.showFooterDivider]
  /// If no [SideNavigationBarFooter] was provided no Divider is returned
  /// If [SideNavigationBar.expandable] is false no Divider is returned
  Widget _evaluateFooterDivider() {
    if (!theme.showFooterDivider) {
      return Container();
    }

    if (widget.footer == null) {
      return Container();
    }

    if (!widget.expandable) {
      return Container();
    }

    return const Divider();
  }
}
