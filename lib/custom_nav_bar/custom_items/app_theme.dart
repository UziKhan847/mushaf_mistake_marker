import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dark_mode.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';

class AppThemeItem extends ConsumerWidget {
  const AppThemeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeProv = ref.read(appThemeProvider.notifier);
    final theme = ref.watch(appThemeProvider);
    final isDarkMode = Theme.brightnessOf(context) == .dark;
    final iconColor = isDarkMode ? theme.darkSeed : theme.lightSeed;

    return NavBarItem(
      iconLabel: 'Theme',
      isSelected: false,
      onTap: () {
        appThemeProv.setTheme(AppTheme.gold);
      },
      selectedAsset: Icons.square,
      unselectedAsset: Icons.square,
      customIconColor: iconColor,
    );
  }
}
