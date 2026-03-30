import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';

class UndoItem extends ConsumerWidget {
  const UndoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Undo',
      onTap: () {},
      child: Icon(MushafAppIcons.undo, color: cs.onSurfaceVariant),
    );
  }
}
