import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mushaf_mistake_marker/variables.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/main_nav_bar_icon_data.dart';

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
  State<MainNavBarIcon> createState() => _MainNavBarIconState();
}

class _MainNavBarIconState extends State<MainNavBarIcon> {
  late final List<MainNavBarIconData> items = navItems.map((data) {
    return MainNavBarIconData(
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected ? item.selectedIcon : item.unSelectedIcon,
            Text(
              item.labelText,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Color(0xFFaf955e) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
