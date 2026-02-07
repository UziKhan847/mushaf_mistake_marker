import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';

final pageHighlightsProvider =
    AutoDisposeNotifierProviderFamily<
      PageHighlightsNotifier,
      Map<String, MarkType>,
      int
    >(PageHighlightsNotifier.new);

class PageHighlightsNotifier
    extends AutoDisposeFamilyNotifier<Map<String, MarkType>, int> {
  @override
  Map<String, MarkType> build(int index) {
    final eleMarkData = ref.read(sprEleDataListProvider(index));

    if (eleMarkData.isEmpty) return {};

    return {for (final e in eleMarkData) e.key: e.highlight};
  }

  void update(String key, MarkType mark) {
    final newMap = {...state}..[key] = mark;
    state = newMap;
  }

  void remove(String key) {
    final newMap = {...state}..remove(key);
    state = newMap;
  }
}
