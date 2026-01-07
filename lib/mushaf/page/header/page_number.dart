import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';

class PageNumberHeader extends ConsumerWidget {
  const PageNumberHeader({
    super.key,
    required this.currentPgIndex,
    this.pageSide = PageSide.none,
  });

  final int currentPgIndex;
  final PageSide pageSide;

  static const double itemHeight = 50.0;
  static const int singlePageItemCount = 604;
  static const int dualPageItemCount = 302;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final (mushafPgCtrl, mushafPgCtrlProv, userInitPage, dualPageMode) = (
      ref.read(mushafPgCtrlProvider),
      ref.read(mushafPgCtrlProvider.notifier),
      ref.read(userSettingsProvider)!.initPage,
      ref.watch(pageModeProvider),
    );

    final link = LayerLink();
    final widgetKey = GlobalKey();

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          OverlayEntry? overlay;

          final initialIndex = initialIndexFromPage(
            currentPgIndex: currentPgIndex,
            dualPageMode: dualPageMode,
          );

          overlay = context.insertOverlay(
            onTapOutside: () {
              overlay?.remove();
              overlay = null;
            },
            children: [
              PageHeaderOverlay(
                link: link,
                itemHeight: itemHeight,
                initialIndex: initialIndex,
                widgetKey: widgetKey,
                itemCount: dualPageMode
                    ? dualPageItemCount
                    : singlePageItemCount,
                itemBuilder: (context, itemIndex) {
                  final itemPgNum = getItemPgNumFromIndex(
                    itemIndex: itemIndex,
                    dualPageMode: dualPageMode,
                    pageSide: pageSide,
                  );

                  final isSelected = isSelectedFromPage(
                    itemIndex: itemIndex,
                    currentPgIndex: currentPgIndex,
                    dualPageMode: dualPageMode,
                    pageSide: pageSide,
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

                        if (swipe) {
                          mushafPgCtrl.jumpToPage(itemIndex);
                          return;
                        }

                        mushafPgCtrlProv.navigateToPage(
                          targetUserPage: targetUserPage,
                          targetIndex: itemIndex,
                          isSwipe: false,
                        );
                      },
                      child: SizedBox(
                        height: itemHeight,
                        child: Center(
                          child: Text(
                            '$itemPgNum',
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
          '${currentPgIndex + 1}',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ),
    );
  }
}
