import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_scope.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';

class AppThemeItem extends ConsumerStatefulWidget {
  const AppThemeItem({super.key});

  @override
  ConsumerState<AppThemeItem> createState() => _AppThemeItemState();
}

class _AppThemeItemState extends ConsumerState<AppThemeItem> {
  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    final appThemeProv = ref.read(appThemeProvider.notifier);
    final theme = ref.watch(appThemeProvider);
    final cs = Theme.of(context).colorScheme;
    final isDarkMode = Theme.brightnessOf(context) == .dark;
    final iconColor = isDarkMode ? theme.darkSeed : theme.lightSeed;

    return NavBarItem(
      iconLabel: 'Theme',
      isSelected: false,
      onTap: () {
        final navBarSize = NavBarScope.of(context)?.renderBox.size;
        if (navBarSize == null) return;

        overlay = context.insertAnimatedOverlay(
          modalBarrierOn: true,
          onTapOutside: () {
            context.removeOverlayEntry(overlay);
          },
          children: [],
        );
      },
      child: Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: BoxBorder.all(width: 1.5, color: cs.primary),
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
