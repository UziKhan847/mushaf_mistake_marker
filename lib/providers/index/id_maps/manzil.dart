import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexManzilIdsProvider =
    AsyncNotifierProvider.family<IndexManzilIdsNotifier, List<String>, int>(
      IndexManzilIdsNotifier.new,
    );

class IndexManzilIdsNotifier extends AsyncNotifier<List<String>> {
  final int manzilNum;
  IndexManzilIdsNotifier(this.manzilNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).byManzil[manzilNum] ?? [];
}
