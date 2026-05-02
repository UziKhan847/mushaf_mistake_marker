import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/models/index/entry.dart';
import 'package:mushaf_mistake_marker/providers/index/lists.dart';

final indexManzilListProvider =
    AsyncNotifierProvider<IndexManzilListNotifier, List<IndexEntry>>(
  IndexManzilListNotifier.new,
);

class IndexManzilListNotifier extends AsyncNotifier<List<IndexEntry>> {
  @override
  Future<List<IndexEntry>> build() async =>
      (await ref.watch(indexListsProvider.future)).manzil;
}