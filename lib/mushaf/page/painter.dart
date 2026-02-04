import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_mark_atlas.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class MushafPageMarksPainter extends CustomPainter {
  MushafPageMarksPainter({
    required this.image,
    required this.vBoxSize,
    required this.pageMarks,
    required this.pageMarksAtlas,
    required this.idToIndex,
  });

  final ui.Image image;
  final Size vBoxSize;
  final Map<String, MarkType> pageMarks;
  final PageMarksAtlas pageMarksAtlas;
  final Map<String, int> idToIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / vBoxSize.width;
    final scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    final paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawRawAtlas(
      image,
      pageMarksAtlas.transformList,
      pageMarksAtlas.rectList,
      pageMarksAtlas.colorList,
      .dstATop,
      null,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant MushafPageMarksPainter oldDelegate) =>
      !mapEquals(oldDelegate.pageMarks, pageMarks);
}




  // void generateLists() {
  //   if (isBuffered) return;

  //   isBuffered = true;

  //   for (int i = 0; i < sprites.length; i++, byteIndex += 4) {
  //     final sprite = sprites[i];
  //     final id = sprite.id;
  //     final rectLTWH = (
  //       sprite.sprXY.first,
  //       sprite.sprXY.last,
  //       sprite.eLTWH[2].ceil(),
  //       sprite.eLTWH.last.ceil(),
  //     );

  //     idToIndex[id] = i;

  //     final rstOffset = RstOffset(x: sprite.eLTWH.first, y: sprite.eLTWH[1]);

  //     final rectLTRB = [
  //       rectLTWH.$1,
  //       rectLTWH.$2,
  //       rectLTWH.$1 + rectLTWH.$3,
  //       rectLTWH.$2 + rectLTWH.$4,
  //     ];

  //     final rstValues = [1.0, 0.0, rstOffset.x, rstOffset.y];

  //     for (int x = 0; x < 4; x++) {
  //       rectList[byteIndex + x] = rectLTRB[x];
  //       transformList[byteIndex + x] = rstValues[x];
  //     }

  //     final eleMark = pageMarks[id];

  //     colorList[i] = switch (eleMark) {
  //       .doubt => purpleInt,
  //       .mistake => redInt,
  //       .oldMistake => blueInt,
  //       .tajwid => greenInt,
  //       _ => isDarkMode ? whiteInt : blackInt,
  //     };
  //   }
  // }



    // final rectPaint = Paint()
    //   ..isAntiAlias = false
    //   ..style = PaintingStyle.fill;

    // for (int i = 0; i < sprites.length; i++, byteIndex += 4) {
    //   final sprite = sprites[i];
    //   final id = sprite.id;
    //   final rectLTWH = (
    //     sprite.sprXY.first,
    //     sprite.sprXY.last,
    //     sprite.eLTWH[2].ceil(),
    //     sprite.eLTWH.last.ceil(),
    //   );
    //   final rstOffset = RstOffset(x: sprite.eLTWH.first, y: sprite.eLTWH[1]);

    //   final rectLTRB = [
    //     rectLTWH.$1,
    //     rectLTWH.$2,
    //     rectLTWH.$1 + rectLTWH.$3,
    //     rectLTWH.$2 + rectLTWH.$4,
    //   ];

    //   final rstValues = [1.0, 0.0, rstOffset.x, rstOffset.y];

    //   for (int x = 0; x < 4; x++) {
    //     rectList[byteIndex + x] = rectLTRB[x];
    //     transformList[byteIndex + x] = rstValues[x];
    //   }

    //   final eleMarkData = eleMarkDataMap[id];
    //   idToIndex[id] = i;

    //   if (eleMarkData == null) {
    //     colorList[i] = isDarkMode ? whiteInt : blackInt;
    //     continue;
    //   }

    //   // if (eleMarkData.highlight != MarkType.unknown) {
    //   //   rectPaint.color = switch (eleMarkData.highlight) {
    //   //     .mistake => Color(isDarkMode ? redHighlightDarkInt : redHighlightInt),
    //   //     .oldMistake => Color(
    //   //       isDarkMode ? blueHighlightDarkInt : blueHighlightInt,
    //   //     ),
    //   //     .tajwid => Color(
    //   //       isDarkMode ? greenHighlightDarkInt : greenHighlightInt,
    //   //     ),
    //   //     _ => Color(isDarkMode ? purpleHighlightDarkInt : purpleHighlightInt),
    //   //   };

    //   //   canvas.drawRect(
    //   //     Rect.fromLTWH(
    //   //       sprite.eLTWH.first,
    //   //       sprite.eLTWH[1],
    //   //       sprite.eLTWH[2],
    //   //       sprite.eLTWH.last,
    //   //     ),
    //   //     rectPaint,
    //   //   );
    //   // }

    //   colorList[i] = switch (eleMarkData.mark) {
    //     .doubt => purpleInt,
    //     .mistake => redInt,
    //     .oldMistake => blueInt,
    //     .tajwid => greenInt,
    //     _ => isDarkMode ? whiteInt : blackInt,
    //   };
    // }