import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';

class HighlighterItem extends ConsumerWidget {
  const HighlighterItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final annotateModeProv = ref.read(annotateModeProvider.notifier);
    final annotateMode = ref.watch(annotateModeProvider);
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Highlight',
      isSelected: annotateMode,
      onTap: () {
        annotateModeProv.switchMode(true);
      },
      child: Icon(
        annotateMode ? MyFlutterApp.highlighter : MyFlutterApp.highlighter_outlined,
        color: annotateMode ? cs.primary : cs.onSurfaceVariant,
      ),
    );
  }
}
