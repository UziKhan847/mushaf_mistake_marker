import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final sprEleDataListProvider =
    AutoDisposeProviderFamily<List<ElementMarkData>, int>((ref, index) {
      final sprites = ref.read(spriteProvider)[index].sprMnfst;

      final sprEleIds = sprites.map((e) => e.id).toList();

      if (sprEleIds.isEmpty) {
        return [];
      }

      final userMshfData = ref.watch(userMushafDataProvider);

      if (userMshfData == null) return [];

      final mshfDataId = userMshfData.id;

      final eleDataBox = ref.read(elementMarkDataBoxProvider);

      final query = eleDataBox
          .query(
            ElementMarkData_.key.oneOf(sprEleIds) &
                ElementMarkData_.mushafData.equals(mshfDataId),
          )
          .build();

      final elementList = query.find();

      query.close();

      return elementList;
    });

// final sprEleDataListProvider =
//     AutoDisposeNotifierProviderFamily<
//       SprEleDataListNotifier,
//       List<ElementMarkData>,
//       int
//     >(SprEleDataListNotifier.new);

// class SprEleDataListNotifier
//     extends AutoDisposeFamilyNotifier<List<ElementMarkData>, int> {
//   @override
//   List<ElementMarkData> build(int index) {
//     final sprites = ref.read(spriteProvider)[index].sprMnfst;

//     final sprEleIds = sprites.map((e) => e.id).toList();

//     if (sprEleIds.isEmpty) {
//       return [];
//     }

//     final userMshfData = ref.watch(userMushafDataProvider);

//     if (userMshfData == null) return [];

//     final mshfDataId = userMshfData.id;

//     final eleDataBox = ref.read(elementMarkDataBoxProvider);

//     final query = eleDataBox
//         .query(
//           ElementMarkData_.key.oneOf(sprEleIds) &
//               ElementMarkData_.mushafData.equals(mshfDataId),
//         )
//         .build();

//     final elementList = query.find();

//     query.close();

//     return elementList;
//   }

  // void updateElement(ElementMarkData element) {
  //   final eleMarkDataBox = ref.read(elementMarkDataBoxProvider);

  //   eleMarkDataBox.put(element);
  // }

  // void addElementWithMarkUp(String key, MarkupMode markupMode) {
  //   final mushafData = ref.read(userMushafDataProvider)!;
  //   final eleMarkDataBox = ref.read(elementMarkDataBoxProvider);
  //   final mushafDataBox = ref.read(mushafDataBoxProvider);

  //   final MarkType mark = markupMode == .mark ? .doubt : .unknown;
  //   final MarkType highlight = markupMode == .highlight ? .doubt : .unknown;

  //   final newEMarkData = ElementMarkData(
  //     key: key,
  //     mark: mark,
  //     highlight: highlight,
  //   );
  //   newEMarkData.mushafData.target = mushafData;
  //   eleMarkDataBox.put(newEMarkData);
  //   mushafData.elementMarkData.add(newEMarkData);
  //   mushafDataBox.put(mushafData);
  // }

  // void removeElement(ElementMarkData element) {
  //   final eleBox = ref.read(elementMarkDataBoxProvider);
  //   eleBox.remove(element.id);
  // }
//}