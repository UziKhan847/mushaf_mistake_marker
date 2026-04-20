import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/custom_nav_bar/item.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/icons/mushaf_app_icons_icons.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/back_dismiss_button.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet.dart';
import 'package:mushaf_mistake_marker/widgets/sheets/index_sheet.dart';

class IndexItem extends ConsumerStatefulWidget {
  const IndexItem({super.key});

  @override
  ConsumerState<IndexItem> createState() => _IndexItemState();
}

class _IndexItemState extends ConsumerState<IndexItem> {
  OverlayEntry? overlay;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return NavBarItem(
      iconLabel: 'Index',
      isSelected: false,
      onTap: () {
        overlay = context.insertAnimatedOverlay(
          backdropOn: true,
          modalBarrierOn: true,
          onTapOutside: () {
            context.removeOverlayEntry(overlay);
          },
          children: [
            BackDismissButton(
              onDismiss: () {
                context.removeOverlayEntry(overlay);
              },
            ),
            BottomSideSheetOverlay(
              isFullScreen: true,
              child: IndexSheet(),
            ),
          ],
        );
      },
      child: Icon(MushafAppIcons.index, color: cs.onSurfaceVariant),
    );
  }
}
