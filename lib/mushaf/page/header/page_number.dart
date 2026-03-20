import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';

class PageNumberHeader extends ConsumerStatefulWidget {
  const PageNumberHeader({
    super.key,
    required this.currentPgIndex,
    this.pageSide = .none,
  });

  final int currentPgIndex;
  final PageSide pageSide;

  static const double itemHeight = 50.0;
  static const int singlePageItemCount = 604;
  static const int dualPageItemCount = 302;

  @override
  ConsumerState<PageNumberHeader> createState() => _PageNumberHeaderState();
}

class _PageNumberHeaderState extends ConsumerState<PageNumberHeader> {
  final LayerLink link = LayerLink();
  final GlobalKey widgetKey = GlobalKey();

  int getItemPgNumFromIndex({
    required int itemIndex,
    required bool dualPageMode,
    required PageSide pageSide,
  }) {
    if (!dualPageMode) return itemIndex + 1;

    return pageSide == .rightSide ? (itemIndex * 2) + 1 : (itemIndex * 2) + 2;
  }

  int initialIndexFromPage({
    required int currentPgIndex,
    required bool dualPageMode,
  }) {
    return dualPageMode ? currentPgIndex ~/ 2 : currentPgIndex;
  }

  bool isSelectedFromPage({
    required int itemIndex,
    required int currentPgIndex,
    required bool dualPageMode,
    required PageSide pageSide,
  }) {
    final adjustedCurrent = pageSide == .leftSide
        ? currentPgIndex - 1
        : currentPgIndex;

    return dualPageMode
        ? itemIndex * 2 == adjustedCurrent
        : itemIndex == adjustedCurrent;
  }

  bool isSwipeFromPage({
    required int targetUserPage,
    required int userInitPage,
    required bool dualPageMode,
  }) {
    final difference = (targetUserPage - userInitPage).abs();
    return dualPageMode ? difference == 2 : difference == 1;
  }

  @override
  Widget build(BuildContext context) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
    final userInitPage = ref.read(userSettingsProvider)!.initPage;
    final dualPageMode = ref.watch(pageModeProvider);

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          OverlayEntry? overlay;

          final initialIndex = initialIndexFromPage(
            currentPgIndex: widget.currentPgIndex,
            dualPageMode: dualPageMode,
          );

          overlay = context.insertAnimatedOverlay(
            backdropOn: true,
            modalBarrierOn: true,
            onTapOutside: () {
              overlay?.remove();
              overlay = null;
            },
            children: [
              PageHeaderOverlay(
                link: link,
                itemHeight: PageNumberHeader.itemHeight,
                initialIndex: initialIndex,
                widgetKey: widgetKey,
                itemCount: dualPageMode
                    ? PageNumberHeader.dualPageItemCount
                    : PageNumberHeader.singlePageItemCount,
                itemBuilder: (context, itemIndex) {
                  final itemPgNum = getItemPgNumFromIndex(
                    itemIndex: itemIndex,
                    dualPageMode: dualPageMode,
                    pageSide: widget.pageSide,
                  );

                  final isSelected = isSelectedFromPage(
                    itemIndex: itemIndex,
                    currentPgIndex: widget.currentPgIndex,
                    dualPageMode: dualPageMode,
                    pageSide: widget.pageSide,
                  );

                  return Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withAlpha(38)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        overlay?.remove();
                        overlay = null;

                        if (isSelected) return;

                        final targetUserPage = dualPageMode
                            ? itemIndex * 2
                            : itemIndex;

                        final swipe = isSwipeFromPage(
                          targetUserPage: targetUserPage,
                          userInitPage: userInitPage,
                          dualPageMode: dualPageMode,
                        );

                        mushafPgCtrlProv.navigateToPage(
                          targetUserPage: targetUserPage,
                          targetIndex: itemIndex,
                          isSwipe: swipe,
                        );
                      },
                      child: SizedBox(
                        height: PageNumberHeader.itemHeight,
                        child: Center(
                          child: Text(
                            '$itemPgNum',
                            style: TextStyle(
                              fontWeight: isSelected ? .bold : .normal,
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
          '${widget.currentPgIndex + 1}',
          style: const TextStyle(
            decoration: .underline,
            decorationStyle: .dashed,
          ),
        ),
      ),
    );
  }
}
