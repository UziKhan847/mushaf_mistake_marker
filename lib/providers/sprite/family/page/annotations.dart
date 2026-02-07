import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';

final pageAnnotationsProvider =
    AutoDisposeNotifierProviderFamily<
      PageAnnotationsNotifier,
      Map<String, String?>,
      int
    >(PageAnnotationsNotifier.new);

class PageAnnotationsNotifier
    extends AutoDisposeFamilyNotifier<Map<String, String?>, int> {
  @override
  Map<String, String?> build(int index) {
    final eleMarkData = ref.read(sprEleDataListProvider(index));

    if (eleMarkData.isEmpty) return {};

    return {for (final e in eleMarkData) e.key: e.annotation};
  }

  void update(String key, String? text) {
    final newMap = {...state}..[key] = text;
    state = newMap;
  }

  void remove(String key) {
    final newMap = {...state}..remove(key);
    state = newMap;
  }
}
