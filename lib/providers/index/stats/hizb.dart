import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/hizb.dart';

final indexHizbStatsProvider =
    AsyncNotifierProvider.family<IndexHizbStatsNotifier, IndexStats, int>(
      IndexHizbStatsNotifier.new,
    );

class IndexHizbStatsNotifier extends AsyncNotifier<IndexStats> {
  final int hizbNum;
  IndexHizbStatsNotifier(this.hizbNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexHizbIdsProvider(hizbNum).future);
    return fetchStats(ref, ids);
  }
}
