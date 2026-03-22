import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.selectedAsset,
    required this.unselectedAsset,
    required this.iconLabel,
    this.customIconColor,
  });

  final bool isSelected;
  final IconData selectedAsset;
  final IconData unselectedAsset;
  final String iconLabel;
  final Color? customIconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.onSurfaceVariant;
    final iconColor = isSelected ? selectedColor : unselectedColor;

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
              child: Icon(
                isSelected ? selectedAsset : unselectedAsset,
                color: customIconColor ?? iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
