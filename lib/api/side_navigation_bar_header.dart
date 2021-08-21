import 'package:flutter/material.dart';

class SideNavigationBarHeader extends StatelessWidget {
  final Widget leading;
  final Widget title;

  const SideNavigationBarHeader({
    Key? key,
    required this.leading,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [leading, title],
          )
        ],
      ),
    );
  }
}
