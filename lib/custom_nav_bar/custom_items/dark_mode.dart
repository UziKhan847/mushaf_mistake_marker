import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dark_mode.dart';

class DarkModeItem extends ConsumerWidget {
  const DarkModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeProv = ref.read(darkModeProvider.notifier);
    final isDarkMode = ref.watch(darkModeProvider);

    return NavBarItem(
      iconLabel: 'Dark Mode',
      isSelected: isDarkMode,
      onTap: () {
        darkModeProv.switchTheme();
      },
      selectedAsset: MyFlutterApp.night_mode,
      unselectedAsset: MyFlutterApp.night_mode_outlined,
    );
  }
}
