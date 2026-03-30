import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';

class EraserItem extends ConsumerWidget {
  const EraserItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final annotateModeProv = ref.read(annotateModeProvider.notifier);
    final annotateMode = ref.watch(annotateModeProvider);
    final cs = Theme.of(context).colorScheme;
    final isSelected = annotateMode == .earser;

    return NavBarItem(
      iconLabel: 'Eraser',
      isSelected: isSelected,
      onTap: () {
        annotateModeProv.setMode(.earser);
      },
      child: Icon(
        isSelected ? MushafAppIcons.eraser : MushafAppIcons.eraser_outlined,
        color: isSelected ? cs.primary : cs.onSurfaceVariant,
      ),
    );
  }
}
