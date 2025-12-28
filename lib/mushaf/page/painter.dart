import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/sprite/rst_offset.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_ele_data.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.sprites,
    required this.image,
    required this.vBoxSize,
    required this.eleMarkDataList,
    required this.isDarkMode,
  });

  final List<SpriteEleData> sprites;
  final List<ElementMarkData> eleMarkDataList;
  final ui.Image image;
  final Size vBoxSize;
  final bool isDarkMode;

  ColorFilter changeColor(Color color) => .mode(color, .srcIn);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    final floatListLength = sprites.length * 4;
    final rectList = Float32List(floatListLength);
    final transformList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);

    for (int i = 0; i < sprites.length; i++) {
      final sprite = sprites[i];
      final id = sprite.id;
      final byteIndex = i * 4;
      final rectLTWH = (
        sprite.sprXY.first,
        sprite.sprXY.last,
        sprite.eLTWH[2].ceil(),
        sprite.eLTWH.last.ceil(),
      );
      final rstOffset = RstOffset(x: sprite.eLTWH.first, y: sprite.eLTWH[1]);

      final rectLTRB = [
        rectLTWH.$1,
        rectLTWH.$2,
        (rectLTWH.$1 + rectLTWH.$3),
        (rectLTWH.$2 + rectLTWH.$4),
      ];

      final rstValues = [1.0, 0.0, rstOffset.x, rstOffset.y];

      for (int x = 0; x < 4; x++) {
        rectList[byteIndex + x] = rectLTRB[x];
        transformList[byteIndex + x] = rstValues[x];
      }

      final eleMarkDataIndex = eleMarkDataList.indexWhere((e) => e.key == id);

      if (eleMarkDataIndex == -1) {
        colorList[i] = isDarkMode ? whiteInt : blackInt;
        continue;
      }

      final eleMarkData = eleMarkDataList[eleMarkDataIndex];

      colorList[i] = switch (eleMarkData.mark) {
        .doubt => purpleInt,
        .mistake => redInt,
        .oldMistake => blueInt,
        .tajwid => greenInt,
        _ => isDarkMode ? whiteInt : blackInt,
      };

      //       colorList[i] = switch (markedPaths[id]) {
      //   .doubt => purpleInt,
      //   .mistake => redInt,
      //   .oldMistake => blueInt,
      //   .tajwid => greenInt,
      //   _ => isDarkMode ? whiteInt : blackInt,
      // };
    }

    final paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawRawAtlas(
      image,
      transformList,
      rectList,
      colorList,
      .dstATop,
      null,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      !listEquals(oldDelegate.eleMarkDataList, eleMarkDataList);
}
