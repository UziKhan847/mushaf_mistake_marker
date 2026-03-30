import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';

class AudioModeItem extends ConsumerWidget {
  const AudioModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final annotateModeProv = ref.read(annotateModeProvider.notifier);
    final annotateMode = ref.watch(annotateModeProvider);
    final cs = Theme.of(context).colorScheme;
    final isSelected = annotateMode == .audio;

    return NavBarItem(
      iconLabel: 'Audio Mode',
      isSelected: isSelected,
      onTap: () {
        annotateModeProv.setMode(.audio);
      },
      child: Icon(
        isSelected ? MushafAppIcons.audio : MushafAppIcons.audio_outlined,
        color: isSelected ? cs.primary : cs.onSurfaceVariant,
      ),
    );
  }
}
