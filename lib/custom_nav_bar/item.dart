import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.iconLabel,
    required this.child,
  });

  final bool isSelected;
  final String iconLabel;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: iconLabel,
      child: Padding(
        padding: const .all(4),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            width: 34,
            height: 34,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
