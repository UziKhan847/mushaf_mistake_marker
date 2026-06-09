import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/index/constants.dart';
import 'package:mushaf_mistake_marker/providers/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

final indexStatsListsProvider = Provider<void>((ref) {
  final elements = ref.read(userMushafDataProvider)!.elementMarkData,
      pagesData = ref.read(pagesProvider).value!.pagesData,
      pageStats = ref.read(statsProvider(.pages).notifier),
      surahsStats = ref.read(statsProvider(.surahs).notifier),
      juzStats = ref.read(statsProvider(.juz).notifier),
      hizbStats = ref.read(statsProvider(.hizb).notifier),
      rubHizbStats = ref.read(statsProvider(.rubu).notifier),
      manzilStats = ref.read(statsProvider(.manzil).notifier),
      elementRegEx = RegExp(r'(s\d+)(v\d+)(w\d+)_(rH\d+)(j\d+)'),
      specificRegEx = RegExp(r'([A-Za-z]+)(\d+)');

  for (final e in elements) {
    if (!e.key.contains('w')) continue;

    final match = elementRegEx.firstMatch(e.key);

    if (match == null) continue;

    final highlight = e.highlight;

    late final int srNum, vrsNum;

    for (int i = 1; i <= match.groupCount; i++) {
      final str = specificRegEx.firstMatch(match[i]!);

      if (str == null) continue;

      final letter = str[1],
          number = int.parse(str[2] as String),
          index = number - 1;

      switch (letter) {
        case 's':
          srNum = number;
          surahsStats.incrementStat(index, highlight);

          for (int i = manzilIndexList.length - 1; i >= 0; i--) {
            final srNum = (manzilIndexList[i]['location']! as (int, int)).$1;
            if (number > srNum) {
              manzilStats.incrementStat(i, highlight);
              continue;
            }
          }
        case 'v':
          vrsNum = number;
        case 'rH':
          rubHizbStats.incrementStat(index, highlight);
          hizbStats.incrementStat(index ~/ 4, highlight);
        case 'j':
          juzStats.incrementStat(index, highlight);
        default:
          continue;
      }
    }

    final pgIndex = pagesData.firstWhere((e) {
      final (first, last) = (e.srNum.first, e.srNum.last);
      if (srNum >= first && srNum <= last ||
          vrsNum >= e.srVrsSets[first]!.first &&
              vrsNum <= e.srVrsSets[last]!.last) {
        return true;
      }
      return false;
    }).pNum;

    pageStats.incrementStat(pgIndex, highlight);
  }
});
