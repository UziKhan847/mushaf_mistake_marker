import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/index/constants.dart';
import 'package:mushaf_mistake_marker/providers/index/page_numbers.dart';
import 'package:mushaf_mistake_marker/providers/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

/// Watched by the Index overlay. While it has a listener it keeps every
/// per-tab stats notifier alive; when the overlay closes it loses its only
/// listener, autoDisposes, and the stats family autoDisposes with it.
final indexStatsListsProvider =
    AsyncNotifierProvider.autoDispose<IndexStatsListsNotifier, void>(
      IndexStatsListsNotifier.new,
    );

class IndexStatsListsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    final pagesData = (await ref.watch(pagesProvider.future)).pagesData;
    await ref.watch(pagesNumberProvider.future);

    final elements = ref.read(userMushafDataProvider)!.elementMarkData;
    final pageStats = ref.watch(statsProvider(.pages).notifier);
    final surahsStats = ref.watch(statsProvider(.surahs).notifier);
    final juzStats = ref.watch(statsProvider(.juz).notifier);
    final hizbStats = ref.watch(statsProvider(.hizb).notifier);
    final rubHizbStats = ref.watch(statsProvider(.rubu).notifier);
    final manzilStats = ref.watch(statsProvider(.manzil).notifier);

    final elementRegEx = RegExp(r'(s\d+)(v\d+)(w\d+)_(rH\d+)(j\d+)');
    final specificRegEx = RegExp(r'([A-Za-z]+)(\d+)');

    for (final e in elements) {
      if (!e.key.contains('w')) continue;
      final match = elementRegEx.firstMatch(e.key);
      if (match == null) continue;

      final highlight = e.highlight;
      late final int srNum, vrsNum;

      for (int i = 1; i <= match.groupCount; i++) {
        final str = specificRegEx.firstMatch(match[i]!);
        if (str == null) continue;
        final letter = str[1];
        final number = int.parse(str[2]!);
        final index = number - 1;

        switch (letter) {
          case 's':
            srNum = number;
            surahsStats.incrementStat(index, highlight);
            for (int i = manzilIndexList.length - 1; i >= 0; i--) {
              final mSr = (manzilIndexList[i]['location']! as (int, int)).$1;
              if (number >= mSr) {
                manzilStats.incrementStat(i, highlight);
                break;
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

      final pgIndex = pagesData.firstWhere((p) {
        final first = p.srNum.first, last = p.srNum.last;
        return (srNum >= first && srNum <= last) ||
            (vrsNum >= p.srVrsSets[first]!.first &&
                vrsNum <= p.srVrsSets[last]!.last);
      }).pNum;

      pageStats.incrementStat(pgIndex, highlight);
    }
  }
}
