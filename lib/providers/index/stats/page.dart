import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/page_ids.dart';

final indexPageStatsProvider = AsyncNotifierProvider.family
    .autoDispose<IndexPageStatsNotifier, IndexStats, int>(
      IndexPageStatsNotifier.new,
    );

class IndexPageStatsNotifier extends AsyncNotifier<IndexStats> {
  IndexPageStatsNotifier(this.index);
  final int index;

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(pageIdsProvider(index).future);
    return fetchStats(ref, ids);
  }
}
