import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/items_data.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/nav_bar_icon_data.dart';

class MainNavBarIcon extends StatefulWidget {
  const MainNavBarIcon({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<MainNavBarIcon> createState() => _NavBarIconState();
}

class _NavBarIconState extends State<MainNavBarIcon> {
  late final List<NavBarIconData> items = navItems.map((data) {
    return NavBarIconData(
      selectedIcon: SvgPicture.asset(
        data.selectedAsset,
        width: 24,
        height: 24,
        semanticsLabel: '${data.label} selected',
      ),
      unSelectedIcon: SvgPicture.asset(
        data.unSelectedAsset,
        width: 24,
        height: 24,
        semanticsLabel: '${data.label} unselected',
      ),
      labelText: data.label,
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final item = items[index];
    final isSelected = widget.isSelected;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 72, minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected ? item.selectedIcon : item.unSelectedIcon,
                const SizedBox(height: 4),
                Text(
                  item.labelText,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Color(0xFFaf955e) : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
