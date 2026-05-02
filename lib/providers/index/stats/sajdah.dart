import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/sajdah.dart';

final indexSajdahTileProvider =
    AsyncNotifierProvider.family<IndexSajdahStatsNotifier, IndexStats, int>(
      IndexSajdahStatsNotifier.new,
    );

class IndexSajdahStatsNotifier extends AsyncNotifier<IndexStats> {
  final int sajdahNum;
  IndexSajdahStatsNotifier(this.sajdahNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexSajdahIdsProvider(sajdahNum).future);
    return fetchStats(ref, ids);
  }
}
