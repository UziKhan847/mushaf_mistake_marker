import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/theme_provider.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/items_data.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_icons/sub_nav/sub_nav_bar_icon.dart';

class DarkModeIcon extends ConsumerWidget {
  const DarkModeIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (themeProv, isDarkMode) = (
      ref.read(themeProvider.notifier),
      ref.watch(themeProvider),
    );

    return SubNavBarIcon(
      item: darkMode,
      isSelected: isDarkMode,
      onTap: () {
        themeProv.switchTheme();
      },
      showIndicator: true,
    );
  }
}
