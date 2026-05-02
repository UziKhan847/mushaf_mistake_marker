import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexSajdahIdsProvider =
    AsyncNotifierProvider.family<IndexSajdahIdsNotifier, List<String>, int>(
      IndexSajdahIdsNotifier.new,
    );

class IndexSajdahIdsNotifier extends AsyncNotifier<List<String>> {
  final int sajdahNum;
  IndexSajdahIdsNotifier(this.sajdahNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).bySajdah[sajdahNum] ?? [];
}
