import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/manzil.dart';

final indexManzilStatsProvider =
    AsyncNotifierProvider.family<IndexManzilStatsNotifier, IndexStats, int>(
      IndexManzilStatsNotifier.new,
    );

class IndexManzilStatsNotifier extends AsyncNotifier<IndexStats> {
  final int manzilNum;
  IndexManzilStatsNotifier(this.manzilNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexManzilIdsProvider(manzilNum).future);
    return fetchStats(ref, ids);
  }
}
