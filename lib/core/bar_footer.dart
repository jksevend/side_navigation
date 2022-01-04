import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar_footer.dart';

/// Represents the footer widget which is rendered on the screen
///
/// Makes use of the [SideNavigationBarFooter] data interface to build the footer
class SideNavigationBarFooterWidget extends StatefulWidget {
  /// Footer data obtained from user
  final SideNavigationBarFooter footerData;

  /// Whether [SideNavigationBar] is expandable at all
  final bool expandable;

  /// The current expanded state of [SideNavigationBar]
  final bool expanded;

  /// What to do when the toggler is pressed
  final VoidCallback onToggle;

  const SideNavigationBarFooterWidget({
    Key? key,
    required this.footerData,
    required this.expandable,
    required this.expanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  _SideNavigationBarFooterWidgetState createState() => _SideNavigationBarFooterWidgetState();
}

class _SideNavigationBarFooterWidgetState extends State<SideNavigationBarFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return _determineFooterWidget();
  }

  /// Determines the footer widget based on [expandable] and [expanded]
  Widget _determineFooterWidget() {
    if (widget.expandable) {
      if (widget.expanded) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              widget.footerData.label,
              _togglerWidget(),
            ],
          ),
        );
      } else {
        return _togglerWidget();
      }
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(),
      );
    }
  }

  /// Returns the toggler widget for the footer
  Widget _togglerWidget() => IconButton(
        icon: Icon(
          widget.expanded ? widget.footerData.shrinkIcon : widget.footerData.expandIcon,
        ),
        onPressed: widget.onToggle,
      );
}
