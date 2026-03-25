import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_scope.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/widgets/theme_item_swatch.dart';

class AppThemeItem extends ConsumerStatefulWidget {
  const AppThemeItem({super.key});

  @override
  ConsumerState<AppThemeItem> createState() => _AppThemeItemState();
}

class _AppThemeItemState extends ConsumerState<AppThemeItem> {
  OverlayEntry? overlay;
  final widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appThemeProv = ref.read(appThemeProvider.notifier);
    final theme = ref.watch(appThemeProvider);
    final isDarkMode = Theme.brightnessOf(context) == .dark;
    final iconColor = isDarkMode ? theme.darkSeed : theme.lightSeed;

    return NavBarItem(
      key: widgetKey,
      iconLabel: 'Theme',
      isSelected: false,
      onTap: () {
        final navBarRenderBox = NavBarScope.of(context)?.renderBox;
        if (navBarRenderBox == null) return;
        final navBarSize = navBarRenderBox.size;

        print('NavBarSize: $navBarSize');

        overlay = context.insertAnimatedOverlay(
          modalBarrierOn: true,
          onTapOutside: () {
            context.removeOverlayEntry(overlay);
          },
          children: [
            NavBarItemOverlay(
              widgetKey: widgetKey,
              navBarSize: navBarSize,
              itemCount: AppTheme.values.length,
              itemBuilder: (context, index) {
                final itemTheme = AppTheme.fromThemeIndex(index);
                final itemColor = isDarkMode
                    ? itemTheme.darkSeed
                    : itemTheme.lightSeed;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      appThemeProv.setTheme(itemTheme);
                    },
                    child: SizedBox(
                      height: 50,
                      child: ThemeItemSwatch(
                        color: itemColor,
                        borderColor: itemColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
      child: ThemeItemSwatch(color: iconColor),
    );
  }
}
