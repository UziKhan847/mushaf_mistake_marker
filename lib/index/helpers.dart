import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/index/constants.dart';
import 'package:mushaf_mistake_marker/models/stats.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';


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
      case .mistake:
        mistakes++;
      case .oldMistake:
        oldMistakes++;
      case .doubt:
        doubts++;
      case .tajwid:
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

String rubuQuarterIcon(int rubuNum) => rubuQuarterIcons[(rubuNum - 1) % 4];

IndexStats statsFromMap(Map<HighlightType, int> m) => IndexStats(
  mistakes: m[HighlightType.mistake] ?? 0,
  oldMistakes: m[HighlightType.oldMistake] ?? 0,
  doubts: m[HighlightType.doubt] ?? 0,
  tajwidMistakes: m[HighlightType.tajwid] ?? 0,
);
