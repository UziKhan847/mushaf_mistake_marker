import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/surah.dart';

final indexSurahTileProvider =
    AsyncNotifierProvider.family<IndexSurahStatsNotifier, IndexStats, int>(
      IndexSurahStatsNotifier.new,
    );

class IndexSurahStatsNotifier extends AsyncNotifier<IndexStats> {
  final int surahNum;
  IndexSurahStatsNotifier(this.surahNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexSurahIdsProvider(surahNum).future);
    return fetchStats(ref, ids);
  }
}
