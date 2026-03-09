import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.selectedAsset,
    required this.unselectedAsset,
    required this.iconLabel,
  });

  final bool isSelected;
  final IconData selectedAsset;
  final IconData unselectedAsset;
  final String iconLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.onSurfaceVariant;
    final iconColor = isSelected ? selectedColor : unselectedColor;

    final circleColor = isSelected ? selectedColor.withAlpha(30) : null;

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
            decoration: circleColor != null
                ? BoxDecoration(shape: .circle, color: circleColor)
                : null,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Icon(
                isSelected ? selectedAsset : unselectedAsset,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
