import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';

class MarkerItem extends ConsumerWidget {
  const MarkerItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (markupModeProv, markupMode) = (
      ref.read(markupModeProvider.notifier),
      ref.watch(markupModeProvider),
    );

    return NavBarItem(
      iconLabel: 'Marker',
      isSelected: markupMode == .mark,
      onTap: () {
        markupModeProv.switchMarkupMode(.mark);
      },
      selectedAsset: MyFlutterApp.marker,
      unselectedAsset: MyFlutterApp.marker,
    );
  }
}
