import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/annotator.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
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
    final (sprites, pageMarks, atlasCache, isDarkMode) = (
      ref.read(spriteProvider)[index].sprMnfst,
      ref.watch(pageMarksProvider(index)),
      ref.read(cachedAtlasProvider(index)),
      Theme.of(context).brightness == .dark,
    );

    return GestureDetector(
      onTapDown: (details) {
        ref
            .read(mushafAnnotatorProvider(index).notifier)
            .handleTap(
              localPosition: details.localPosition,
              viewSize: Size(w, h),
              pageSize: Size(pageW, pageH),
            );
      },
      child: RepaintBoundary(
        child: CustomPaint(
          painter: MushafPageMarksPainter(
            pageMarksAtlas: atlasCache.pageMarkAtlas,
            pageMarks: pageMarks,
            vBoxSize: Size(pageW, pageH),
            image: image,
            isDarkMode: isDarkMode,
          ),
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