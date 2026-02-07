import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/annotations.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/highlights.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/marks.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

class MushafPageAnnotator extends ConsumerWidget {
  const MushafPageAnnotator({
    super.key,
    required this.index,
    required this.h,
    required this.w,
    required this.pageH,
    required this.pageW,
    required this.image,
  });

  final int index;
  final double w;
  final double h;
  final double pageW;
  final double pageH;
  final ui.Image image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (sprites, pageMarks, atlasCache) = (
      ref.read(spriteProvider)[index].sprMnfst,
      ref.watch(pageMarksProvider(index)),
      ref.watch(cachedAtlasProvider(index)),
    );

    return GestureDetector(
      onTapDown: (details) {
        final (
          eleListProv,
          eleBox,
          pageMarksProv,
          pagehighlightProv,
          pageAnnoteProv,
          markupMode,
          mushafData,
          mushafDataBox,
          isDarkMode,
        ) = (
          ref.read(sprEleDataListProvider(index)),
          ref.read(elementMarkDataBoxProvider),
          ref.read(pageMarksProvider(index).notifier),
          ref.read(pageHighlightsProvider(index).notifier),
          ref.read(pageAnnotationsProvider(index).notifier),
          ref.read(markupModeProvider),
          ref.read(userMushafDataProvider)!,
          ref.read(mushafDataBoxProvider),
          ref.read(themeProvider),
        );

        final localPos = details.localPosition;

        final scaleX = w / pageW;
        final scaleY = h / pageH;

        final scaledPoint = Offset(localPos.dx / scaleX, localPos.dy / scaleY);

        for (final sprite in sprites) {
          if (!sprite.id.contains('w')) continue;

          final (id, left, top, right, bottom, scaledX, scaledY) =
              AnnotatorHandler.getSpriteData(sprite, scaledPoint);

          final isClicked = AnnotatorHandler.elemBounds(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            scaledX: scaledX,
            scaledY: scaledY,
          );

          if (!isClicked) continue;

          final index = atlasCache.idToIndex[id]!;

          final defaultColor = isDarkMode ? whiteInt : blackInt;

          final element = eleBox
              .query(ElementMarkData_.key.equals(id))
              .build()
              .findFirst();

          if (markupMode == .eraser) {
            if (element != null) {
              eleBox.remove(element.id);
              atlasCache.pageMarkAtlas.colorList[index] = defaultColor;
              pageMarksProv.remove(id);
              pagehighlightProv.remove(id);
              // pageAnnoteProv.remove(id);
            }
            return;
          }

          final isMarkMode = markupMode == .mark;

          if (element == null) {
            final MarkType mark = isMarkMode ? .doubt : .unknown;
            final MarkType highlight = isMarkMode ? .unknown : .doubt;

            final newEMarkData = ElementMarkData(
              key: id,
              mark: mark,
              highlight: highlight,
            );

            newEMarkData.mushafData.target = mushafData;
            eleBox.put(newEMarkData);
            mushafData.elementMarkData.add(newEMarkData);
            mushafDataBox.put(mushafData);

            if (isMarkMode) {
              atlasCache.pageMarkAtlas.colorList[index] =
                  newEMarkData.markColor!;
              pageMarksProv.update(id, mark);
            } else {
              pagehighlightProv.update(id, mark);
            }

            return;
          }

          if (isMarkMode) {
            element.updateMark();
            atlasCache.pageMarkAtlas.colorList[index] =
                element.markColor ?? defaultColor;
            pageMarksProv.update(id, element.mark);
          } else {
            element.updateHighlight();
            pagehighlightProv.update(id, element.mark);
          }

          return;
        }
      },
      child: CustomPaint(
        painter: MushafPageMarksPainter(
          pageMarksAtlas: atlasCache.pageMarkAtlas,
          idToIndex: atlasCache.idToIndex,
          pageMarks: pageMarks,
          vBoxSize: Size(pageW, pageH),
          image: image,
        ),
      ),
    );
  }
}




// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
// import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
// import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
// import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_map.dart';
// import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

// class MushafPageAnnotator extends ConsumerWidget {
//   const MushafPageAnnotator({
//     super.key,
//     required this.index,
//     required this.h,
//     required this.w,
//     required this.pageH,
//     required this.pageW,
//     required this.image,
//   });

//   final int index;
//   final double w;
//   final double h;
//   final double pageW;
//   final double pageH;
//   final ui.Image image;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final (sprites, eleMarkDataMap) = (
//       ref.read(spriteProvider)[index].sprMnfst,
//       ref.watch(sprEleDataMapProvider(index)),
//     );

//     return GestureDetector(
//       onTapDown: (details) {
//         final localPos = details.localPosition;

//         final scaleX = w / pageW;
//         final scaleY = h / pageH;

//         final scaledPoint = Offset(localPos.dx / scaleX, localPos.dy / scaleY);

//         AnnotatorHandler.handleTap(
//           ref: ref,
//           sprites: sprites,
//           tapPoint: scaledPoint,
//           pageIndex: index,
//         );
//       },
//       child: CustomPaint(
//         painter: MushafPagePainter(
//           vBoxSize: Size(pageW, pageH),
//           eleMarkDataMap: eleMarkDataMap,
//           sprites: sprites,
//           image: image,
//           isDarkMode: Theme.of(context).brightness == .dark,
//         ),
//       ),
//     );
//   }
// }