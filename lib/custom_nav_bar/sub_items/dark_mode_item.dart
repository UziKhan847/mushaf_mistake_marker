import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme_provider.dart';

class DarkModeItem extends ConsumerWidget {
  const DarkModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (themeProv, isDarkMode) = (
      ref.read(themeProvider.notifier),
      ref.watch(themeProvider),
    );

    return NavBarItem(
      iconLabel: 'darkmode',
      isSelected: isDarkMode,
      onTap: () {
        themeProv.switchTheme();
      },
      selectedAsset: MyFlutterApp.night_mode,
      unselectedAsset: MyFlutterApp.night_mode_outlined,
    );
  }
}
