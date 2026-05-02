import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/models/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/index/id_maps/rubu.dart';

final indexRubuTileProvider =
    AsyncNotifierProvider.family<IndexRubuStatsNotifier, IndexStats, int>(
      IndexRubuStatsNotifier.new,
    );

class IndexRubuStatsNotifier extends AsyncNotifier<IndexStats> {
  final int rubuNum;
  IndexRubuStatsNotifier(this.rubuNum);

  @override
  Future<IndexStats> build() async {
    final ids = await ref.watch(indexRubuIdsProvider(rubuNum).future);
    return fetchStats(ref, ids);
  }
}
