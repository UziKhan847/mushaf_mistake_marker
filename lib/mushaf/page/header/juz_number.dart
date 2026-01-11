import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/variables.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/sprite_ids.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

class JuzNumberHeader extends ConsumerWidget {
  const JuzNumberHeader({
    super.key,
    required this.currentPgIndex,
    this.pageSide = .none,
  });

  final int currentPgIndex;
  final PageSide pageSide;
  static const double itemHeight = 50.0;
  static final RegExp _surahRegExp = RegExp(r'j(\d{1,2})');

  static Set<int> getJuzNums({required List<String> pEleIds}) {
    final juzNums = <int>{};

    for (final e in pEleIds) {
      final match = _surahRegExp.firstMatch(e);
      if (match != null) {
        juzNums.add(int.parse(match.group(1)!));
      }
    }

    return juzNums;
  }

  bool isOnJuzStartPage(int currentPg, int clickedIndex, Set<int> juzNums) {
    final clickedJuzNum = juzNums.firstWhere(
      (e) => e == clickedIndex + 1,
      orElse: () => 0,
    );

    if (clickedJuzNum == 0) return false;

    final juzStrtPg = juzStartPage[clickedJuzNum];

    return juzStrtPg == currentPg;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (
      mushafPgCtrl,
      mushafPgCtrlProv,
      sprProv,
      userId,
      dualPageMode,
      pageElementIds,
    ) = (
      ref.read(mushafPgCtrlProvider),
      ref.read(mushafPgCtrlProvider.notifier),
      ref.read(spriteProvider.notifier),
      ref.read(userSettingsProvider)!.initPage,
      ref.watch(pageModeProvider),
      ref.watch(spriteIdsProvider(currentPgIndex)),
    );

    if (pageElementIds == null) return const SizedBox.shrink();

    final juzNums = getJuzNums(pEleIds: pageElementIds);
    if (juzNums.isEmpty) return const SizedBox.shrink();

    final currentJuzNum = juzNums.last;

    final link = LayerLink();
    final widgetKey = GlobalKey();

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          OverlayEntry? overlay;

          overlay = context.insertOverlay(
            onTapOutside: () {
              overlay?.remove();
              overlay = null;
            },
            children: [
              PageHeaderOverlay(
                link: link,
                initialIndex: juzNums.last - 1,
                widgetKey: widgetKey,
                itemHeight: itemHeight,
                itemCount: 30,
                itemBuilder: (context, index) {
                  final isSelected = currentJuzNum == index + 1;

                  return Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withAlpha(38)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        overlay?.remove();
                        overlay = null;

                        final isOnStrtPg = isOnJuzStartPage(
                          currentPgIndex + 1,
                          index,
                          juzNums,
                        );

                        if (isOnStrtPg) return;

                        final targetUserPage = juzStartPage[index + 1]! - 1;
                        final targetIndex = dualPageMode
                            ? targetUserPage ~/ 2
                            : targetUserPage;

                        mushafPgCtrlProv.navigateToPage(
                          targetUserPage: targetUserPage,
                          targetIndex: targetIndex,
                          isSwipe: false,
                        );
                      },
                      child: SizedBox(
                        height: itemHeight,
                        child: Center(
                          child: Text(
                            'Juz ${index + 1}',
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
          'Juz $currentJuzNum',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ),
    );
  }
}
