import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/icon/custom_icon_data.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item_tile.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.iconName,
    required this.isSelected,
    required this.onTap,
  });

  final String iconName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> iconMap = iconsData[iconName]!;
    final iconData = CustomIconData.fromJson(iconMap);

    return NavBarItemTile(
      isSelected: isSelected,
      onTap: onTap,
      iconLabel: iconData.label,
      selectedAsset: iconData.selectedAsset,
      unselectedAsset: iconData.unselectedAsset,
    );
  }
}
