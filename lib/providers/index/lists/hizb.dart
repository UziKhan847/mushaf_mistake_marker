import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/providers/index/lists.dart';

final indexHizbListProvider =
    AsyncNotifierProvider<IndexHizbListNotifier, List<IndexEntry>>(
      IndexHizbListNotifier.new,
    );

class IndexHizbListNotifier extends AsyncNotifier<List<IndexEntry>> {
  @override
  Future<List<IndexEntry>> build() async =>
      (await ref.watch(indexListsProvider.future)).hizb;
}
