import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';

final elementProvider = NotifierProvider.autoDispose
    .family<ElementNotifier, ElementMarkData?, String>(ElementNotifier.new);

class ElementNotifier extends Notifier<ElementMarkData?> {
  ElementNotifier(this.key);
  final String key;

  @override
  ElementMarkData? build() {
    final elemBox = ref.read(elementMarkDataBoxProvider);
    final query = elemBox.query(ElementMarkData_.key.equals(key)).build();
    final element = query.findFirst();
    query.close();
    return element;
  }

  void addElement({
    required String key,
    HighlightType? highlight,
    String? annotation,
  }) {
    final elemBox = ref.read(elementMarkDataBoxProvider);
    final mshfData = ref.read(userMushafDataProvider)!;
    final mshfDataBox = ref.read(mushafDataBoxProvider);

    final element = ElementMarkData(
      key: key,
      highlight: highlight ?? .unknown,
      annotation: annotation == '' ? null : annotation,
    );

    element.mushafData.target = mshfData;

    elemBox.put(element);
    mshfData.elementMarkData.add(element);
    mshfDataBox.put(mshfData);

    state = element;
  }

  void removeElement(ElementMarkData? element) {
    if (element == null) return;
    final elemBox = ref.read(elementMarkDataBoxProvider);
    elemBox.remove(element.id);
    state = null;
  }

  void updateElement(ElementMarkData element) {
    final elemBox = ref.read(elementMarkDataBoxProvider);
    final copy = element.copyWith();
    elemBox.put(copy);
    state = copy;
  }
}
