import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_marks.dart';
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
        final (eleListProv, eleBox, pageMarksProv, markupMode) = (
          ref.read(sprEleDataListProvider(index)),
          ref.read(elementMarkDataBoxProvider),
          ref.read(pageMarksProvider(index).notifier),
          ref.read(markupModeProvider),
        );

        final localPos = details.localPosition;

        final scaleX = w / pageW;
        final scaleY = h / pageH;

        final scaledPoint = Offset(localPos.dx / scaleX, localPos.dy / scaleY);

        // AnnotatorHandler.handleTap(
        //   ref: ref,
        //   sprites: sprites,
        //   tapPoint: scaledPoint,
        //   pageIndex: index,
        // );

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