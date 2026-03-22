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

    return NavBarItem(
      iconLabel: 'Highlight',
      isSelected: annotateMode,
      onTap: () {
        annotateModeProv.switchMode(true);
      },
      selectedAsset: MyFlutterApp.highlighter,
      unselectedAsset: MyFlutterApp.highlighter_outlined,
    );
  }
}
