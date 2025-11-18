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

  Color saturateColor(bool isDarkMode, Color color, [double amount = -0.05]) {
    if (isDarkMode) {
      return color;
    }

    final hsl = HSLColor.fromColor(color);
    final newSaturation = (hsl.saturation - amount).clamp(0, 1.0) as double;
    final newColor = hsl.withSaturation(newSaturation).toColor();
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final selectedColor = saturateColor(isDarkMode, colorScheme.primary);
    final unselectedColor = colorScheme.onSurfaceVariant;

    final color = isSelected ? selectedColor : unselectedColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 60, minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedAsset : unselectedAsset,
                color: color,
                size: 20,
              ),
              const SizedBox(height: 4),
              IconLabel(labelText: iconLabel, textColor: color),
            ],
          ),
        ),
      ),
    );
  }
}
