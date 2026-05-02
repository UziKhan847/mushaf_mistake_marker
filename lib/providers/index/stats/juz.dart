import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/juz.dart';

final indexJuzTileProvider =
    AsyncNotifierProvider.family<IndexJuzStatsNotifier, IndexStats, int>(
      IndexJuzStatsNotifier.new,
    );

class IndexJuzStatsNotifier extends AsyncNotifier<IndexStats> {
  final int juzNum;
  IndexJuzStatsNotifier(this.juzNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexJuzIdsProvider(juzNum).future);
    return fetchStats(ref, ids);
  }
}
