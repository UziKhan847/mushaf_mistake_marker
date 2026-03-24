import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/variables.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/surahs.dart';
import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

class SurahNumberHeader extends ConsumerStatefulWidget {
  const SurahNumberHeader({
    super.key,
    required this.currentPgIndex,
    this.pageSide = .none,
  });

  final int currentPgIndex;
  final PageSide pageSide;
  static const itemHeight = 50.0;
  static final surahRegExp = RegExp(r's(\d{1,3})');

  @override
  ConsumerState<SurahNumberHeader> createState() => _SurahNumberHeaderState();
}

class _SurahNumberHeaderState extends ConsumerState<SurahNumberHeader> {
  final GlobalKey widgetKey = GlobalKey();

  bool isOnSurahStartPage(int currentPg, int clickedIndex, Set<int> surahNums) {
    final clickedSurahNum = surahNums.firstWhere(
      (e) => e == clickedIndex + 1,
      orElse: () => 0,
    );

    if (clickedSurahNum == 0) return false;
    final surahStrtPg = surahStartPage[clickedSurahNum];
    return surahStrtPg == currentPg;
  }

  @override
  Widget build(BuildContext context) {
    final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
    final dualPageMode = ref.watch(pageModeProvider);
    final surahs = ref.watch(pageSurahsProvider(widget.currentPgIndex));

    if (surahs == null || surahs.isEmpty) return const SizedBox.shrink();

    final surahsListLength = surahs.length;
    final surahsNameList = <String>{};
    final surahNums = <int>{};

    for (int i = 0; i < surahsListLength; i++) {
      final surah = surahs[i];

      surahsNameList.add(surah.name);
      surahNums.add(surah.number);
    }

    return TextButton(
      key: widgetKey,
      onPressed: () {
        OverlayEntry? overlay;

        overlay = context.insertAnimatedOverlay(
          backdropOn: true,
          modalBarrierOn: true,
          onTapOutside: () {
            overlay?.remove();
            overlay = null;
          },
          children: [
            PageHeaderOverlay(
              initialIndex: surahNums.first - 1,
              widgetKey: widgetKey,
              itemHeight: SurahNumberHeader.itemHeight,
              itemCount: 114,
              itemBuilder: (context, index) {
                final surahName = surahsData[index]['name'] as String;
                final isSelected = surahsNameList.contains(surahName);

                return Material(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary.withAlpha(38)
                      : Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      overlay?.remove();
                      overlay = null;

                      final isOnStrtPg = isOnSurahStartPage(
                        widget.currentPgIndex + 1,
                        index,
                        surahNums,
                      );

                      if (isOnStrtPg) return;

                      final targetUserPage = surahStartPage[index + 1]! - 1;

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
                      height: SurahNumberHeader.itemHeight,
                      child: Center(
                        child: Text(
                          surahName,
                          textAlign: .center,
                          style: TextStyle(
                            fontWeight: isSelected ? .bold : .normal,
                            fontSize: 12,
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
        surahsNameList.first,
        style: const TextStyle(
          decoration: .underline,
          decorationStyle: .dashed,
        ),
      ),
    );
  }
}
