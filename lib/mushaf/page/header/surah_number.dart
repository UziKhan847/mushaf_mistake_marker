import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/page_header_overlay.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/page_controller.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/sprite_ids.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/surah/surah.dart';
import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

class SurahNumberHeader extends ConsumerStatefulWidget {
  const SurahNumberHeader({
    super.key,
    required this.index,
    this.pageSide = .none,
  });

  final int index;
  final PageSide pageSide;

  @override
  ConsumerState<SurahNumberHeader> createState() => _SurahNumberHeaderState();
}

class _SurahNumberHeaderState extends ConsumerState<SurahNumberHeader> {
  late final mushafPgCtrl = ref.read(mushafPgCtrlProvider);
  late final mushafPgCtrlProv = ref.read(mushafPgCtrlProvider.notifier);
  late final dualPageMode = ref.read(pageModeProvider);
  late final sprProv = ref.read(spriteProvider.notifier);
  late final userId = ref.read(userSettingsProvider)!.initPage;
  late final regExp = RegExp(r's(\d{1,3})');

  late final link = LayerLink();

  late final widgetKey = GlobalKey();

  OverlayEntry? overlay;

  Set<int> getSurahNums({
    required List<String> pEleIds,
    required RegExp regExp,
  }) {
    final surahNums = <int>{};

    for (final e in pEleIds) {
      final match = regExp.matchAsPrefix(e);

      if (match != null) surahNums.add(int.parse(match.group(1)!));
    }

    return surahNums;
  }

  List<Surah> getSurahs(Set<int> surahNums) {
    final surahs = <Surah>[];

    for (final num in surahNums) {
      final surah = Surah.fromJson(surahsData[num - 1]);

      surahs.add(surah);
    }

    return surahs;
  }

  @override
  Widget build(BuildContext context) {
    final pageElementIds = ref.watch(spriteIdsProvider(userId));
    if (pageElementIds == null) return const SizedBox.shrink();

    final buffer = StringBuffer();
    final surahNums = getSurahNums(pEleIds: pageElementIds, regExp: regExp);
    if (surahNums.isEmpty) return const SizedBox.shrink();
    final surahs = getSurahs(surahNums);
    if (surahs.isEmpty) return const SizedBox.shrink();
    final surahsListLength = dualPageMode ? surahs.length : 1;

    for (int i = 0; i < surahsListLength; i++) {
      final surah = surahs[i];
      buffer.write('${surah.number} ');
      buffer.write(surah.name);
      buffer.write(' (${surah.numOfVs})');
      if (i > 0) buffer.writeln();
    }

    final surahText = buffer.toString();

    final isSelected = false;

    return CompositedTransformTarget(
      link: link,
      child: TextButton(
        key: widgetKey,
        onPressed: () {
          overlay = context.insertOverlay(
            onTapOutside: () {
              context.removeOverlayEntry(overlay);
            },
            children: [
              PageHeaderOverlay(
                link: link,
                initialIndex: 0,
                widgetKey: widgetKey,
                itemCount: 114,
                itemBuilder: (context, index) {
                  return Material(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withAlpha(38)
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.removeOverlayEntry(overlay);
                        return;

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
                            '${0}',
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
          surahText,
          style: TextStyle(decoration: .underline, decorationStyle: .dashed),
        ),
      ),
    );
  }
}
