import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';

class EraserItem extends ConsumerWidget {
  const EraserItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final annotateModeProv = ref.read(annotateModeProvider.notifier);
    final annotateMode = ref.watch(annotateModeProvider);

    return NavBarItem(
      iconLabel: 'Eraser',
      isSelected: !annotateMode,
      onTap: () {
        annotateModeProv.switchMode(false);
      },
      selectedAsset: MyFlutterApp.eraser,
      unselectedAsset: MyFlutterApp.eraser_outlined,
    );
  }
}
