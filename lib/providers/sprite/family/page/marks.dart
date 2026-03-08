// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/enums.dart';
// import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';

// final pageMarksProvider =
//     AutoDisposeNotifierProviderFamily<
//       PageMarksNotifier,
//       Map<String, HighlightType>,
//       int
//     >(PageMarksNotifier.new);

// class PageMarksNotifier
//     extends AutoDisposeFamilyNotifier<Map<String, HighlightType>, int> {
//   @override
//   Map<String, HighlightType> build(int index) {
//     final eleMarkData = ref.read(sprEleDataListProvider(index));

//     if (eleMarkData.isEmpty) return {};

//     return {for (final e in eleMarkData) e.key: e.mark};
//   }

//   void update(String key, HighlightType mark) {
//     final newMap = {...state}..[key] = mark;
//     state = newMap;
//   }

//   void remove(String key) {
//     final newMap = {...state}..remove(key);
//     state = newMap;
//   }
// }
