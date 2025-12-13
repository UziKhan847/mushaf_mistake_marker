import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/highlighter.dart';

class HighlighterItem extends ConsumerWidget {
  const HighlighterItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (highlightProv, ishighlightMode) = (
      ref.read(highlightProvider.notifier),
      ref.watch(highlightProvider),
    );

    return NavBarItem(
      iconLabel: 'Highlight',
      isSelected: ishighlightMode,
      onTap: () {
        highlightProv.switchColorMode();
      },
      selectedAsset: MyFlutterApp.highlighter,
      unselectedAsset: MyFlutterApp.highlighter_outlined,
    );
  }
}
