import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_marks_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_highlights_atlas.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.image,
    required this.whiteRect,
    required this.vBoxSize,
    required this.pageMarksAtlas,
    required this.pageHighlightsAtlas,
    required this.isDarkMode,
  });

  final ui.Image image;
  final ui.Image whiteRect;
  final Size vBoxSize;
  final PageMarksAtlas pageMarksAtlas;
  final PageHighlightsAtlas pageHighlightsAtlas;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    print('PAINTING BOTH MARKS AND HIGHLIGHTS!');

    final scaleX = size.width / vBoxSize.width;
    final scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    final paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawRawAtlas(
      whiteRect,
      pageHighlightsAtlas.transformList,
      pageHighlightsAtlas.rectList,
      pageHighlightsAtlas.colorList,
      .dst,
      null,
      paint,
    );

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
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) {
    return !listEquals(oldDelegate.pageMarksAtlas.colorList, pageMarksAtlas.colorList) ||
        !listEquals(oldDelegate.pageHighlightsAtlas.colorList, pageHighlightsAtlas.colorList) ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}
