import 'package:flutter/material.dart';
import 'package:side_navigation/api/side_navigation_bar_header.dart';

/// Represents the header widget which is rendered on the screen
///
/// Makes use of the [SideNavigationBarHeader] data interface to build this widget
class SideNavigationBarHeaderWidget extends StatefulWidget {
  /// Header data obtained from user
  final SideNavigationBarHeader headerData;

  /// Whether [SideNavigationBar] is expandable
  final bool expandable;

  /// The current expandable state of [SideNavigationBar]
  final bool expanded;

  const SideNavigationBarHeaderWidget({
    Key? key,
    required this.headerData,
    required this.expandable,
    required this.expanded,
  }) : super(key: key);

  @override
  _SideNavigationBarHeaderWidgetState createState() => _SideNavigationBarHeaderWidgetState();
}

class _SideNavigationBarHeaderWidgetState extends State<SideNavigationBarHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return _determineHeaderWidget();
  }

  /// Determines the header widget based on [expandable] and [expanded]
  Widget _determineHeaderWidget() {
    if (widget.expandable) {
      if (widget.expanded) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 12.0),
          child: Row(
            children: [
              widget.headerData.image,
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.headerData.title,
                        widget.headerData.subtitle,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: widget.headerData.image,
        );
      }
    } else {
      return Container();
    }
  }
}
