import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.spriteSheet,
    //required this.paths,
    required this.vBoxSize,
    required this.markedPaths,
  });

  //final List<DrawablePath> paths;
  final SpriteSheet spriteSheet;
  final Size vBoxSize;
  final Map<String, MarkType> markedPaths;

  ColorFilter changeColor(Color color) =>
      ColorFilter.mode(color, BlendMode.srcIn);

  @override
  void paint(Canvas canvas, Size size) {
    final image = spriteSheet.image;

    if (image != null) {
      final double scaleX = size.width / vBoxSize.width;
      final double scaleY = size.height / vBoxSize.height;

      canvas.scale(scaleX, scaleY);

      final sprites = spriteSheet.sprites;
      final floatListLength = sprites.length * 4;
      final rectList = Float32List(floatListLength);
      final transformList = Float32List(floatListLength);
      final colorList = Int32List(sprites.length);

      for (int i = 0; i < sprites.length; i++) {
        final sprite = sprites[i];
        final id = sprite.id;
        final byteIndex = i * 4;
        final rectOffset = sprite.rectOffset;
        final rstOffset = sprite.rstOffset;
        final origSize = sprite.origSize;
        final rectW = origSize.w.ceil();
        final rectH = origSize.h.ceil();

        final rectLTRB = [
          rectOffset.x.toDouble(),
          rectOffset.y.toDouble(),
          (rectOffset.x + rectW).toDouble(),
          (rectOffset.y + rectH).toDouble(),
        ];

        final rstValues = [1.0, 0.0, rstOffset.x, rstOffset.y];

        for (int x = 0; x < 4; x++) {
          rectList[byteIndex + x] = rectLTRB[x];
          transformList[byteIndex + x] = rstValues[x];
        }

        colorList[i] = switch (markedPaths[id]) {
          MarkType.doubt => purpleInt,
          MarkType.mistake => redInt,
          MarkType.oldMistake => blueInt,
          MarkType.tajwid => greenInt,
          _ => blackInt,
        };
      }

      final paint = Paint()..filterQuality = FilterQuality.high;
      canvas.drawRawAtlas(
        image,
        transformList,
        rectList,
        colorList,
        BlendMode.dstATop,
        null,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      !mapEquals(oldDelegate.markedPaths, markedPaths);
}
