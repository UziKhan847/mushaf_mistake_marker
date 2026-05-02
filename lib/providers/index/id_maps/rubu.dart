import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexRubuIdsProvider =
    AsyncNotifierProvider.family<IndexRubuIdsNotifier, List<String>, int>(
      IndexRubuIdsNotifier.new,
    );

class IndexRubuIdsNotifier extends AsyncNotifier<List<String>> {
  final int rubuNum;
  IndexRubuIdsNotifier(this.rubuNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).byRubu[rubuNum] ?? [];
}
