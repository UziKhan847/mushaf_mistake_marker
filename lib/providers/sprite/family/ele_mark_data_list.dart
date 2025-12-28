import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final sprEleDataProvider =
    AutoDisposeNotifierProviderFamily<
      SprEleDataProvider,
      List<ElementMarkData>,
      int
    >(SprEleDataProvider.new);

class SprEleDataProvider
    extends AutoDisposeFamilyNotifier<List<ElementMarkData>, int> {
  @override
  List<ElementMarkData> build(int index) {
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

    final elements = query.find();

    query.close();

    return elements;
  }

  void updateElement(ElementMarkData element, int index) {
    final eleMarkDataBox = ref.read(elementMarkDataBoxProvider);

    eleMarkDataBox.put(element);

    final newElement = element.copyWith(
      mark: element.mark,
      highlight: element.highlight,
      annotation: element.annotation,
    );

    final newList = [...state]..[index] = newElement;
    state = newList;
  }

  void addElement(String key) {
    final mushafData = ref.read(userMushafDataProvider)!;
    final eleMarkDataBox = ref.read(elementMarkDataBoxProvider);
    final mushafDataBox = ref.read(mushafDataBoxProvider);

    final newEMarkData = ElementMarkData(key: key, mark: .doubt);
    newEMarkData.mushafData.target = mushafData;
    eleMarkDataBox.put(newEMarkData);
    mushafData.elementMarkData.add(newEMarkData);
    mushafDataBox.put(mushafData);

    final newList = [...state, newEMarkData];
    state = newList;
  }

  void removeElement(ElementMarkData element, int index) {
    final eleBox = ref.read(elementMarkDataBoxProvider);
    final isRemoved = eleBox.remove(element.id);

    if (!isRemoved) return;

    final newList = [...state]..removeAt(index);
    state = newList;
  }
}
