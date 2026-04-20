import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/bottom_side_sheet.dart';
import 'package:mushaf_mistake_marker/widgets/index/tab_view.dart';

// ─────────────────────────────────────────────
//  PLACEHOLDER DATA
// ─────────────────────────────────────────────

final surahs = List.generate(
  10,
  (i) => IndexEntry(
    title: [
      'Al-Fātihah',
      'Al-Baqarah',
      'Āli-ʿImrān',
      'An-Nisāʾ',
      'Al-Māʾidah',
      'Al-Anʿām',
      'Al-Aʿrāf',
      'Al-Anfāl',
      'At-Tawbah',
      'Yūnus',
    ][i],
    subtitle: [
      'Makki • 7 v',
      'Madani • 286 v',
      'Madani • 200 v',
      'Madani • 176 v',
      'Madani • 120 v',
      'Makki • 165 v',
      'Makki • 206 v',
      'Madani • 75 v',
      'Madani • 129 v',
      'Makki • 109 v',
    ][i],
    page: [1, 2, 50, 77, 106, 128, 151, 177, 187, 208][i],
    stats: IndexStats(
      mistakes: i * 2,
      oldMistakes: i,
      doubts: i,
      tajwidMistakes: i + 1,
    ),
  ),
);

final juzList = List.generate(
  10,
  (i) => IndexEntry(
    title: 'Juzʾ ${i + 1}',
    subtitle: juzSubtitles[i],
    page: juzPages[i],
    stats: IndexStats(
      mistakes: i * 3,
      oldMistakes: i + 1,
      doubts: i + 1,
      tajwidMistakes: i * 2,
      revisions: i,
    ),
  ),
);

const juzSubtitles = [
  'Starts at Al-Fātihah 1:1',
  'Starts at Al-Baqarah 2:142',
  'Starts at Al-Baqarah 2:253',
  'Starts at Āli-ʿImrān 3:92',
  'Starts at An-Nisāʾ 4:24',
  'Starts at An-Nisāʾ 4:148',
  'Starts at Al-Māʾidah 5:82',
  'Starts at Al-Anʿām 6:111',
  'Starts at Al-Aʿrāf 7:88',
  'Starts at Al-Anfāl 8:41',
];
const juzPages = [1, 22, 42, 62, 82, 102, 121, 142, 162, 182];

final pages = List.generate(
  10,
  (i) => IndexEntry(
    title: 'Page ${i + 1}',
    subtitle: 'Surah Al-Fātihah',
    page: i + 1,
    stats: IndexStats(
      mistakes: i,
      oldMistakes: i ~/ 2,
      doubts: i ~/ 2,
      tajwidMistakes: i,
      revisions: i * 2,
    ),
  ),
);

final hizb = List.generate(
  8,
  (i) => IndexEntry(
    title: 'Hizb ${i + 1}',
    subtitle: 'Starts at Juzʾ ${(i ~/ 2) + 1}',
    page: (i * 16) + 1,
    stats: IndexStats(
      mistakes: i * 2,
      oldMistakes: i,
      doubts: i,
      tajwidMistakes: i + 1,
      revisions: i,
    ),
  ),
);

final rubu = List.generate(
  10,
  (i) => IndexEntry(
    title: 'Rubʿ ${i + 1}',
    subtitle: 'Quarter ${(i % 4) + 1} of Hizb ${(i ~/ 4) + 1}',
    page: (i * 8) + 1,
    stats: IndexStats(
      mistakes: i,
      oldMistakes: i ~/ 2,
      doubts: i ~/ 2,
      tajwidMistakes: i,
      revisions: i,
    ),
  ),
);

final sajdah = List.generate(
  10,
  (i) => IndexEntry(
    title: 'Sajdah ${i + 1}',
    subtitle: [
      'Al-Aʿrāf 7:206',
      'Ar-Raʿd 13:15',
      'An-Naḥl 16:50',
      'Al-Isrāʾ 17:109',
      'Maryam 19:58',
      'Al-Ḥajj 22:18',
      'Al-Furqān 25:60',
      'An-Naml 27:26',
      'As-Sajdah 32:15',
      'Fuṣṣilat 41:38',
    ][i],
    page: [174, 249, 272, 293, 308, 333, 362, 379, 415, 480][i],
    stats: IndexStats(
      mistakes: i ~/ 2,
      oldMistakes: i ~/ 3,
      doubts: 0,
      tajwidMistakes: i,
      revisions: i,
    ),
  ),
);

//---------------------------------------

class IndexSheet extends StatefulWidget {
  const IndexSheet({super.key});

  @override
  State<IndexSheet> createState() => _IndexSheetState();
}

class _IndexSheetState extends State<IndexSheet>
    with SingleTickerProviderStateMixin {
  late final TabController tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: IndexTab.values.length, vsync: this);
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    super.dispose();
  }

  List<IndexEntry> entriesForTab(IndexTab tab) => switch (tab) {
    .pages => pages,
    .surahs => surahs,
    .juz => juzList,
    .hizb => hizb,
    .rubu => rubu,
    .sajdah => sajdah,
  };

  @override
  Widget build(BuildContext context) {
    return BottomSideSheetOverlay(
      isFullScreen: true,
      child: Column(
        children: [
          TabBar(
            controller: tabCtrl,
            isScrollable: true,
            tabAlignment: .start,
            padding: const .symmetric(horizontal: 12),
            tabs: IndexTab.values
                .map(
                  (tab) => Tab(
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Icon(tab.icon, size: 16),
                        const SizedBox(width: 6),
                        Text(tab.label),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 4),
          const Divider(height: 1),
          Expanded(
            child: TabBarView(
              controller: tabCtrl,
              children: IndexTab.values
                  .map(
                    (tab) => IndexTabView(
                      entries: entriesForTab(tab),
                      onPageSelected: (int x) {},
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
