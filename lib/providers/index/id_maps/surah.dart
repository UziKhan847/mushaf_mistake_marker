import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexSurahIdsProvider =
    AsyncNotifierProvider.family<IndexSurahIdsNotifier, List<String>, int>(
      IndexSurahIdsNotifier.new,
    );

class IndexSurahIdsNotifier extends AsyncNotifier<List<String>> {
  final int surahNum;
  IndexSurahIdsNotifier(this.surahNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).bySurah[surahNum] ?? [];
}
