import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/variables.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

class SurahNumberHeader extends ConsumerStatefulWidget {
  const SurahNumberHeader({
    super.key,
    required this.pageNumber,
    this.pageSide = .none,
  });

  final int pageNumber;
  final PageSide pageSide;

  @override
  ConsumerState<SurahNumberHeader> createState() => _SurahNumberHeaderState();
}

class _SurahNumberHeaderState extends ConsumerState<SurahNumberHeader> {
  late final mushafPgCtrl = ref.read(mushafPgCtrlProvider);
  late final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
  late final dualPageMode = ref.read(dualPageModeProvider);
  late final sprProv = ref.read(spriteProvider.notifier);

  final link = LayerLink();

  final widgetKey = GlobalKey();

  OverlayEntry? overlay;

  int pageNumberFromIndex({
    required int index,
    required bool dualPageMode,
    required PageSide pageSide,
  }) {
    if (!dualPageMode) return index + 1;

    return pageSide == .rightSide ? (index * 2) + 1 : (index * 2) + 2;
  }

  int initialIndexFromPage({
    required int page,
    required bool dualPageMode,
    required PageSide pageSide,
  }) => dualPageMode ? (page) ~/ 2 : page;

  bool isSelectedFromPage({
    required int index,
    required int currentUserIndex,
    required bool dualPageMode,
  }) =>
      dualPageMode ? index * 2 == currentUserIndex : index == currentUserIndex;

  @override
  Widget build(BuildContext context) {
  

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          final currentUserIndex = ref.read(userSettingsProvider)!.initPage;

          final initialIndex = initialIndexFromPage(
            page: currentUserIndex,
            dualPageMode: dualPageMode,
            pageSide: widget.pageSide,
          );

          overlay = context.insertOverlay(
            onTapOutside: () {
              context.removeOverlayEntry(overlay);
            },
            children: [
              PageHeaderOverlay(
                link: link,
                initialIndex: initialIndex,
                widgetKey: widgetKey,
                itemCount: dualPageMode ? 302 : 604,
                itemBuilder: (context, index) {
                  final displayPageNumber = pageNumberFromIndex(
                    index: index,
                    dualPageMode: dualPageMode,
                    pageSide: widget.pageSide,
                  );

                  final isSelected = isSelectedFromPage(
                    index: index,
                    currentUserIndex: currentUserIndex,
                    dualPageMode: dualPageMode,
                  );

                  return Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withAlpha(38)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.removeOverlayEntry(overlay);
                        if (isSelected) return;

                        sprProv.clearAll();
                        mushafPgCtrlProv.setUserPage(
                          dualPageMode ? index * 2 : index,
                        );
                        mushafPgCtrl.jumpToPage(index);
                      },
                      child: SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            '$displayPageNumber',
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        child: Text(
          '${widget.pageNumber}',
          style: TextStyle(decoration: .underline, decorationStyle: .dashed),
        ),
      ),
    );
  }
}
