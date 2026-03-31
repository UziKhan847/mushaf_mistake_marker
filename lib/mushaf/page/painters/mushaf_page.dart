import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.image,
    required this.whiteRect,
    required this.vBoxSize,
    required this.atlasCache,
    required this.isDarkMode,
    required this.pageRebuild,
  });

  final ui.Image image;
  final ui.Image whiteRect;
  final Size vBoxSize;
  final AtlasCache atlasCache;
  final bool pageRebuild;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / vBoxSize.width;
    final scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    final paint = Paint()..filterQuality = .none;

    canvas.drawRawAtlas(
      whiteRect,
      atlasCache.transformList,
      atlasCache.rectList,
      atlasCache.highlighColorList,
      .dst,
      null,
      paint,
    );

    paint.filterQuality = .medium;

    canvas.drawRawAtlas(
      image,
      atlasCache.transformList,
      atlasCache.rectList,
      atlasCache.elemColorList,
      .dstATop,
      null,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      oldDelegate.pageRebuild != pageRebuild ||
      oldDelegate.isDarkMode != isDarkMode;
}
