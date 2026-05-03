import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

const List<(int, int)> sajdahLocations = [
  (7, 206),
  (13, 15),
  (16, 50),
  (17, 109),
  (19, 58),
  (22, 18),
  (22, 77),
  (25, 60),
  (27, 26),
  (32, 15),
  (38, 24),
  (41, 38),
  (53, 62),
  (84, 21),
  (96, 19),
];

String surahName(int n) =>
    surahsData.firstWhere((s) => s['num'] == n)['name'] as String;

String pageSubtitle(PageData page) => page.srNum.map(surahName).join(' – ');

(int, int) firstVerseOnPage(PageData page) {
  final srNums = page.srNum.toList()..sort();
  for (final sr in srNums) {
    final vrs = page.srVrsSets[sr];
    if (vrs != null && vrs.isNotEmpty) {
      return (sr, (vrs.toList()..sort()).first);
    }
  }
  return (srNums.first, 1);
}

Future<IndexStats> fetchStats(Ref ref, List<String> ids) async {
  if (ids.isEmpty) return const IndexStats();

  final box = ref.read(elementMarkDataBoxProvider);
  final mushafDataId = ref.read(userProvider).mushafData.targetId;

  final marks = box
      .query(
        ElementMarkData_.key.oneOf(ids) &
            ElementMarkData_.mushafData.equals(mushafDataId),
      )
      .build()
      .find();

  int mistakes = 0, oldMistakes = 0, doubts = 0, tajwid = 0;

  for (final m in marks) {
    switch (m.highlight) {
      case HighlightType.mistake:
        mistakes++;
      case HighlightType.oldMistake:
        oldMistakes++;
      case HighlightType.doubt:
        doubts++;
      case HighlightType.tajwid:
        tajwid++;
      default:
        break;
    }
  }

  return IndexStats(
    mistakes: mistakes,
    oldMistakes: oldMistakes,
    doubts: doubts,
    tajwidMistakes: tajwid,
  );
}

const rubuQuarterIcons = ['◔', '◑', '◕', '●'];

String rubuQuarterIcon(int rubuNum) => rubuQuarterIcons[(rubuNum - 1) % 4];
