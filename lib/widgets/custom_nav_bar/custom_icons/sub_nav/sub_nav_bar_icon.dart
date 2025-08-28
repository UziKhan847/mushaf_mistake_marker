import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/items_data.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/sub_nav/sub_nav_bar_indicator.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/nav_bar_item_data.dart';

class SubNavBarIcon extends StatelessWidget {
  const SubNavBarIcon({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.labelFontSize = 10.0,
    this.showIndicator = false,
    this.indicatorOnColor,
    this.indicatorOffColor,
    this.indicatorSize,
  });

  final NavBarItemData item;

  final bool isSelected;
  final VoidCallback onTap;

  final double labelFontSize;

  final bool showIndicator;
  final Color? indicatorOnColor;
  final Color? indicatorOffColor;
  final double? indicatorSize;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedTextColor = isDark ? Colors.white : Colors.black;
    final unselectedTextColor = isDark ? Colors.grey.shade400 : Colors.grey;

    final svg = SvgPicture.asset(
      isSelected ? item.selectedAsset : item.unSelectedAsset,
      width: iconSize,
      height: iconSize,
      semanticsLabel: '${item.label} ${isSelected ? 'selected' : 'unselected'}',
    );

    final dotSize = indicatorSize ?? (iconSize * 0.36);
    final dotPosition = -dotSize / 2;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 72, minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(child: svg),
                      if (showIndicator)
                        Positioned(
                          top: dotPosition,
                          right: dotPosition,
                          child: SubNavBarIndicator(
                            isOn: isSelected,
                            iconSize: iconSize,
                            indicatorOnColor: indicatorOnColor,
                            indicatorOffColor: indicatorOffColor,
                            indicatorSize: indicatorSize,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: labelFontSize,
                    color: isSelected ? selectedTextColor : unselectedTextColor,
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
