import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

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

  /// [SideNavigationBar.initiallyExpanded] value
  final bool initiallyExpanded;

  const SideNavigationBarHeaderWidget({
    Key? key,
    required this.headerData,
    required this.expandable,
    required this.expanded,
    required this.initiallyExpanded,
  }) : super(key: key);

  @override
  _SideNavigationBarHeaderWidgetState createState() =>
      _SideNavigationBarHeaderWidgetState();
}

class _SideNavigationBarHeaderWidgetState
    extends State<SideNavigationBarHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return _determineHeaderWidget();
  }

  /// Determines the header widget based on [expandable] and [expanded]
  Widget _determineHeaderWidget() {
    if (widget.expandable) {
      if (widget.expanded) {
        return _ExpandedHeaderWidget(headerData: widget.headerData);
      } else {
        return _ShrinkedHeaderWidget(image: widget.headerData.image);
      }
    } else {
      if (widget.initiallyExpanded) {
        return _ExpandedHeaderWidget(headerData: widget.headerData);
      } else {
        return _ShrinkedHeaderWidget(image: widget.headerData.image);
      }
    }
  }
}

/// Internal widget to display data when [SideNavigationBar] is expanded
class _ExpandedHeaderWidget extends StatefulWidget {
  final SideNavigationBarHeader headerData;

  const _ExpandedHeaderWidget({Key? key, required this.headerData})
      : super(key: key);

  @override
  _ExpandedHeaderWidgetState createState() => _ExpandedHeaderWidgetState();
}

class _ExpandedHeaderWidgetState extends State<_ExpandedHeaderWidget> {
  @override
  Widget build(BuildContext context) {
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
  }
}

/// Internal widget to display data when [SideNavigationBar] is not expanded
class _ShrinkedHeaderWidget extends StatefulWidget {
  final Widget image;

  const _ShrinkedHeaderWidget({Key? key, required this.image})
      : super(key: key);

  @override
  _ShrinkedHeaderWidgetState createState() => _ShrinkedHeaderWidgetState();
}

class _ShrinkedHeaderWidgetState extends State<_ShrinkedHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: widget.image,
    );
  }
}
