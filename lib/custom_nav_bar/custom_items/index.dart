import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';

class IndexItem extends ConsumerWidget {
  const IndexItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Index',
      isSelected: false,
      onTap: () {
        ref.read(mushafDataBoxProvider).removeAll();
        ref.read(settingsBoxProvider).removeAll();
        ref.read(userBoxProvider).removeAll();
      },
      child: Icon(MushafAppIcons.index, color: cs.onSurfaceVariant),
    );
  }
}
