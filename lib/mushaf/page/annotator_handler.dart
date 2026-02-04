import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as ref;
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_marks.dart';
import 'package:mushaf_mistake_marker/sprite_models/sprite_ele_data.dart';

class AnnotatorHandler {
  static bool elemBounds({
    required double top,
    required double bottom,
    required double left,
    required double right,
    required double scaledX,
    required double scaledY,
  }) {
    return scaledX >= left &&
        scaledY >= top &&
        scaledX <= right &&
        scaledY <= bottom;
  }

  static (
    String id,
    double left,
    double top,
    double right,
    double bottom,
    double scaledX,
    double scaledY,
  )
  getSpriteData(SpriteEleData e, Offset scaledPoint) => (
    e.id,
    e.eLTWH.first,
    e.eLTWH[1],
    e.eLTWH[2] + e.eLTWH.first,
    e.eLTWH.last + e.eLTWH[1],
    scaledPoint.dx,
    scaledPoint.dy,
  );

  // static void applyMarkup({
  //   required MarkupMode markupMode,
  //   required ElementMarkData? element,
  //   required String elementId,
  //  // required SprEleDataMapNotifier eleMapProv,
  //   required PageMarksNotifier pageMarkProv,
  // }) {
  //   if (markupMode == .eraser) {
  //     if (element != null) {
  //       // eleMapProv.removeElement(element);

  //       pageMarkProv.remove(elementId);
  //     }
  //     return;
  //   }

  //   if (element == null) {
  //     //eleMapProv.addElementWithMarkUp(elementId, markupMode);
  //     return;
  //   }

  //   if (markupMode == .highlight) {
  //     element.updateHighlight();
  //   } else {
  //     final mark = element.updateMark();
  //     pageMarkProv.update(elementId, mark);
  //   }

  //   // if (element.isEmpty) {
  //   //   eleMapProv.removeElement(element);
  //   // } else {
  //   //   eleMapProv.updateElement(element);
  //   // }
  // }

  void removeElement(Box<ElementMarkData> eleBox, ElementMarkData element) {
    eleBox.remove(element.id);
  }

  void addElementWithMarkUp({
    required WidgetRef ref,
    required PageMarksNotifier pageMarkProv,
    required String key,
    required MarkupMode markupMode,
  }) {
    final mushafData = ref.read(userMushafDataProvider)!;
    final eleMarkDataBox = ref.read(elementMarkDataBoxProvider);
    final mushafDataBox = ref.read(mushafDataBoxProvider);

    final MarkType mark = markupMode == .mark ? .doubt : .unknown;
    final MarkType highlight = markupMode == .highlight ? .doubt : .unknown;

    final newEMarkData = ElementMarkData(
      key: key,
      mark: mark,
      highlight: highlight,
    );
    newEMarkData.mushafData.target = mushafData;
    eleMarkDataBox.put(newEMarkData);
    mushafData.elementMarkData.add(newEMarkData);
    mushafDataBox.put(mushafData);

    pageMarkProv.update(key, mark);
  }

  void applyMark({
    required MarkupMode markupMode,
    required ElementMarkData? element,
    required String elementId,
    required PageMarksNotifier pageMarkProv,
    required Box<ElementMarkData> eleBox,
  }) {
    if (markupMode == .eraser) {
      if (element != null) {
        removeElement(eleBox, element);
        pageMarkProv.remove(elementId);
      }
      return;
    }

    if (element == null) {}
  }

  static void handleTap({
    required WidgetRef ref,
    required List sprites,
    required Offset tapPoint,
    required int pageIndex,
  }) {
    final (eleListProv, eleBox, pageMarksProv, markupMode) = (
      ref.read(sprEleDataListProvider(pageIndex)),
      ref.read(elementMarkDataBoxProvider),
      ref.read(pageMarksProvider(pageIndex).notifier),
      ref.read(markupModeProvider),
    );

    for (final sprite in sprites) {
      final (id, left, top, right, bottom, scaledX, scaledY) =
          AnnotatorHandler.getSpriteData(sprite, tapPoint);

      if (!id.contains('w')) continue;

      final isClicked = AnnotatorHandler.elemBounds(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        scaledX: scaledX,
        scaledY: scaledY,
      );

      if (!isClicked) continue;

      final eleMarkData = eleBox
          .query(ElementMarkData_.key.equals(id))
          .build()
          .findFirst();

      applyMarkup(
        markupMode: markupMode,
        element: eleMarkData,
        elementId: id,
        pageMarkProv: pageMarksProv,
      );

      return;
    }
  }
}

// import 'dart:ui';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/enums.dart';
// import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
// import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
// import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_map.dart';
// import 'package:mushaf_mistake_marker/sprite/sprite_ele_data.dart';

// class AnnotatorHandler {
//   static bool elemBounds({
//     required double top,
//     required double bottom,
//     required double left,
//     required double right,
//     required double scaledX,
//     required double scaledY,
//   }) {
//     return scaledX >= left &&
//         scaledY >= top &&
//         scaledX <= right &&
//         scaledY <= bottom;
//   }

//   static (
//     String id,
//     double left,
//     double top,
//     double right,
//     double bottom,
//     double scaledX,
//     double scaledY,
//   )
//   getSpriteData(SpriteEleData e, Offset scaledPoint) => (
//     e.id,
//     e.eLTWH.first,
//     e.eLTWH[1],
//     e.eLTWH[2] + e.eLTWH.first,
//     e.eLTWH.last + e.eLTWH[1],
//     scaledPoint.dx,
//     scaledPoint.dy,
//   );

//   static void applyMarkup({
//     required MarkupMode markupMode,
//     required ElementMarkData? element,
//     required String elementId,
//     required SprEleDataMapNotifier notifier,
//   }) {
//     if (markupMode == MarkupMode.eraser) {
//       if (element != null) {
//         notifier.removeElement(element);
//       }
//       return;
//     }

//     if (element == null) {
//       notifier.addElementWithMarkUp(elementId, markupMode);
//       return;
//     }

//     if (markupMode == MarkupMode.highlight) {
//       element.updateHighlight();
//     } else {
//       element.updateMark();
//     }

//     if (element.isEmpty) {
//       notifier.removeElement(element);
//     } else {
//       notifier.updateElement(element);
//     }
//   }

//   static void handleTap({
//     required WidgetRef ref,
//     required List sprites,
//     required Offset tapPoint,
//     required int pageIndex,
//   }) {
//     final (eleMarkDataMapProv, eleMarkDataMap, markupMode) = (
//       ref.read(sprEleDataMapProvider(pageIndex).notifier),
//       ref.read(sprEleDataMapProvider(pageIndex)),
//       ref.read(markupModeProvider),
//     );

//     for (final sprite in sprites) {
//       final (id, left, top, right, bottom, scaledX, scaledY) =
//           AnnotatorHandler.getSpriteData(sprite, tapPoint);

//       if (!id.contains('w')) continue;

//       final isClicked = AnnotatorHandler.elemBounds(
//         top: top,
//         bottom: bottom,
//         left: left,
//         right: right,
//         scaledX: scaledX,
//         scaledY: scaledY,
//       );

//       if (!isClicked) continue;

//       final eleMarkData = eleMarkDataMap[id];

//       applyMarkup(
//         markupMode: markupMode,
//         element: eleMarkData,
//         elementId: id,
//         notifier: eleMarkDataMapProv,
//       );

//       return;
//     }
//   }
// }
