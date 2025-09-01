import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/nav_bar_item.dart';
import 'package:mushaf_mistake_marker/providers/highlighter_provider.dart';

class HighlighterItem extends ConsumerWidget {
  const HighlighterItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (highlightProv, ishighlightMode) = (
      ref.read(highlightProvider.notifier),
      ref.watch(highlightProvider),
    );

    return NavBarItem(
      iconName: 'highlighter',
      isSelected: ishighlightMode,
      onTap: () {
        highlightProv.switchColorMode();
      },
    );
  }
}
