import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_highlights_atlas.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class MushafPageHighlightsPainter extends CustomPainter {
  MushafPageHighlightsPainter({
    required this.vBoxSize,
    required this.pageHighlights,
    required this.pageHighlightsAtlas,
    required this.isDarkMode,
    required this.whiteRect,
  });

  final Size vBoxSize;
  final Map<String, MarkType> pageHighlights;
  final PageHighlightsAtlas pageHighlightsAtlas;
  final bool isDarkMode;
  final ui.Image whiteRect;

  @override
  void paint(Canvas canvas, Size size) {
    print('PAINTING HIGHLIGHTS!');

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
  }

  @override
  bool shouldRepaint(covariant MushafPageHighlightsPainter oldDelegate) =>
      !mapEquals(oldDelegate.pageHighlights, pageHighlights) ||
      oldDelegate.isDarkMode != isDarkMode;
}
