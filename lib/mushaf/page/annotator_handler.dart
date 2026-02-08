import 'dart:ui';
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

  //   static void removeElement(
  //   {
  //   required ElementMarkData? element,
  //   required Box<ElementMarkData> eleBox,
  //   required PageMarksNotifier pageMarksProv,
  //   }
  // ) {
  //   if (element != null) {
  //   eleBox.remove(element.id);
  //   pageMarksProv.remove(element.key);
  //   }
  // }

  // static void removeMarkUp(
  //   {
  //   required ElementMarkData? element,
  //   required Box<ElementMarkData> eleBox,
  //   required PageMarksNotifier pageMarksProv,
  //   }
  // ) {
  //   if (element != null) {
  //   eleBox.remove(element.id);
  //   pageMarksProv.remove(element.key);
  //   }
  // }

  // static void addElement({
  //   required WidgetRef ref,
  //   required String key,
  //   required MarkupMode markupMode,
  //   required Box<ElementMarkData> eleBox,
  //   required PageMarksNotifier pageMarksProv,
  // }) {
  //   final (mushafData, mushafDataBox) = (ref.read(userMushafDataProvider)!, ref.read(mushafDataBoxProvider));

  //   final isMarkMode = markupMode == .mark;

  //   final MarkType mark = isMarkMode ? .doubt : .unknown;
  //   final MarkType highlight = isMarkMode ? .unknown : .doubt;

  //   final newEMarkData = ElementMarkData(
  //     key: key,
  //     mark: mark,
  //     highlight: highlight,
  //   );
  //   newEMarkData.mushafData.target = mushafData;
  //   eleBox.put(newEMarkData);
  //   mushafData.elementMarkData.add(newEMarkData);
  //   mushafDataBox.put(mushafData);

  //   if (isMarkMode) {
  //     pageMarksProv.update(key, mark);
  //   }
  // }

  //   static void updateElement({
  //   required MarkupMode markupMode,
  //   required ElementMarkData element,
  //   required Box<ElementMarkData> eleBox,
  //   required PageMarksNotifier pageMarksProv,
  // }) {

  //   final isMarkMode = markupMode == .mark;

  //   if (isMarkMode) {
  //     final mark = element.updateMark();

  //     // if (mark == .unknown) {
  //     //   pageMarksProv.remove(element.key);
  //     // } else {
  //     //   pageMarksProv.update(element.key, mark);
  //     // }
     
  //   } else {
  //     // final highlight = element.updateHighlight();
  //     // eleBox.put(element);
  //   }

  //   if (element.mark == .unknown && element.highlight == .unknown && element.annotation == null) {
  //     eleBox.remove(element.id);
  //   } else {
  //     eleBox.put(element);
  //   }
  // }

  // static void applyMark({
  //   required WidgetRef ref,
  //   required MarkupMode markupMode,
  //   required ElementMarkData? element,
  //   required String elementKey,
  //   required PageMarksNotifier pageMarksProv,
  //   required Box<ElementMarkData> eleBox,
  // }) {
  //   if (markupMode == .eraser) {
  //     removeElement(element: element, eleBox: eleBox, pageMarksProv: pageMarksProv);
  //     return;
  //   }

  //   if (element == null) {
  //     addElement(ref: ref, key: elementKey, markupMode: markupMode, eleBox: eleBox, pageMarksProv: pageMarksProv);
  //     return;
  //   }

  //   updateElement(markupMode: markupMode, element: element, eleBox: eleBox, pageMarksProv: pageMarksProv);
  // }
}