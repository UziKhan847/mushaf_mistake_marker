import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexJuzIdsProvider =
    AsyncNotifierProvider.family<IndexJuzIdsNotifier, List<String>, int>(
      IndexJuzIdsNotifier.new,
    );

class IndexJuzIdsNotifier extends AsyncNotifier<List<String>> {
  final int juzNum;
  IndexJuzIdsNotifier(this.juzNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).byJuz[juzNum] ?? [];
}
