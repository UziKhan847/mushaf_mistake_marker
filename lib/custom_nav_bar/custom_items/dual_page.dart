import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dual_page.dart';

class DualPageItem extends ConsumerWidget {
  const DualPageItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dualPgTglProv = ref.read(dualPageToggleProvider.notifier);
    final isDualPgTglOn = ref.watch(dualPageToggleProvider);
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Dual Page',
      isSelected: isDualPgTglOn,
      onTap: () {
        dualPgTglProv.switchToggle();
      },
      child: Icon(
        isDualPgTglOn
            ? MushafAppIcons.dual_page
            : MushafAppIcons.dual_page_outlined,
        color: isDualPgTglOn ? cs.primary : cs.onSurfaceVariant,
      ),
    );
  }
}
