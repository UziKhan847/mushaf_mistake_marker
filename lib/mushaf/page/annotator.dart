import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter/painter.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/annotator.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/white_rect.dart';

class MushafPageAnnotator extends ConsumerStatefulWidget {
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
  ConsumerState<MushafPageAnnotator> createState() =>
      _MushafPageAnnotatorState();
}

class _MushafPageAnnotatorState extends ConsumerState<MushafPageAnnotator> {
  @override
  Widget build(BuildContext context) {
    final atlasCache = ref.read(cachedAtlasProvider(widget.index));
    final isDarkMode = Theme.of(context).brightness == .dark;

    return GestureDetector(
      onTapDown: (details) {
        ref
            .read(mushafAnnotatorProvider(widget.index).notifier)
            .handleTap(
              localPosition: details.localPosition,
              viewSize: Size(widget.w, widget.h),
              pageSize: Size(widget.pageW, widget.pageH),
            );
        setState(() {});
      },
      child: RepaintBoundary(
        child: CustomPaint(
          painter: MushafPagePainter(
            image: widget.image,
            whiteRect: ref.read(whiteRectProvider)!,
            vBoxSize: Size(widget.pageW, widget.pageH),
            pageMarksAtlas: atlasCache.pageMarkAtlas,
            pageHighlightsAtlas: atlasCache.pageHighlightsAtlas,
            isDarkMode: isDarkMode,
          ),
        ),
      ),
    );
  }
}
