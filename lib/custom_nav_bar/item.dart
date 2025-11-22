import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/icon_label.dart';

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

  Color saturateColor(bool isDarkMode, Color color, [double amount = 0.05]) {
    if (isDarkMode) {
      return color;
    }

    final hsl = HSLColor.fromColor(color);
    final newSaturation = (hsl.saturation + amount).clamp(0, 1.0) as double;
    final newColor = hsl.withSaturation(newSaturation).toColor();
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == .dark;

    final selectedColor = saturateColor(isDarkMode, colorScheme.primary);
    final unselectedColor = colorScheme.onSurfaceVariant;

    final color = isSelected ? selectedColor : unselectedColor;

    return Semantics(
      button: true,
      selected: isSelected,
      label: iconLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, minHeight: 56),
          child: Padding(
            padding: const .all(8.0),
            child: Column(
              spacing: 2,
              mainAxisAlignment: .center,
              children: [
                Icon(
                  isSelected ? selectedAsset : unselectedAsset,
                  color: color,
                ),
                IconLabel(labelText: iconLabel, textColor: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
