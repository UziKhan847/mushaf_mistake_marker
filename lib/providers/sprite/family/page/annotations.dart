import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';

final pageAnnotationsProvider = NotifierProvider.autoDispose
    .family<PageAnnotationsNotifier, Map<String, String?>, int>(
      PageAnnotationsNotifier.new,
    );

class PageAnnotationsNotifier extends Notifier<Map<String, String?>> {
  PageAnnotationsNotifier(this.index);
  final int index;

  @override
  Map<String, String?> build() {
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
