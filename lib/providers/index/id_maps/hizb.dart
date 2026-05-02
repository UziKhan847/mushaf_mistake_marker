import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/index/ids_maps.dart';

final indexHizbIdsProvider =
    AsyncNotifierProvider.family<IndexHizbIdsNotifier, List<String>, int>(
      IndexHizbIdsNotifier.new,
    );

class IndexHizbIdsNotifier extends AsyncNotifier<List<String>> {
  final int hizbNum;
  IndexHizbIdsNotifier(this.hizbNum);

  @override
  Future<List<String>> build() async =>
      (await ref.watch(indexIdsMapsProvider.future)).byHizb[hizbNum] ?? [];
}
