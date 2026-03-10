import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/bubble.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/mushaf_page.dart';
import 'package:mushaf_mistake_marker/widgets/annotation_bubble.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
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
    final pageRebuild = ref.watch(pageRebuildProvider(widget.index));

    return GestureDetector(
      onTapDown: (details) {
        final sprites = ref.read(spriteProvider)[widget.index].sprMnfst;

        final localP = details.localPosition;

        final scaleX = widget.w / widget.pageW;
        final scaleY = widget.h / widget.pageH;

        final scaledPoint = Offset(localP.dx / scaleX, localP.dy / scaleY);

        for (final sprite in sprites) {
          if (!sprite.id.contains('w')) continue;

          final (id, left, top, right, bottom) = AnnotatorHandler.getSpriteData(
            sprite,
          );

          final isClicked = AnnotatorHandler.elemBounds(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            scaledX: scaledPoint.dx,
            scaledY: scaledPoint.dy,
          );

          if (!isClicked) continue;

          final atlasCache = ref.read(cachedAtlasProvider(widget.index));

          final scrnSize = MediaQuery.of(context).size;
          final gp = details.globalPosition;

          final renderbox = context.findRenderObject() as RenderBox;
          final elemGlobalLT = renderbox.localToGlobal(
            Offset(left * scaleX, top * scaleY),
          );

          late final double bubbleLeft;
          late final TrianglePosition triPos;

          final bool isBubbleTop = gp.dy < 250 ? false : true;
          final double bubbleTop = isBubbleTop
              ? elemGlobalLT.dy - 96
              : elemGlobalLT.dy + sprite.eLTWH[3] * scaleY + 10;

          if (gp.dx < 300) {
            bubbleLeft = elemGlobalLT.dx + (sprite.eLTWH[2] * scaleX / 2);
            triPos = isBubbleTop ? .bottomLeft : .topLeft;
          } else if (gp.dx > scrnSize.width - 300) {
            bubbleLeft = elemGlobalLT.dx - 250 + sprite.eLTWH[2] * scaleX / 2;
            triPos = isBubbleTop ? .bottomRight : .topRight;
          } else {
            bubbleLeft =
                elemGlobalLT.dx - ((250 - sprite.eLTWH[2] * scaleX) / 2);
            triPos = isBubbleTop ? .bottomCenter : .topCenter;
          }

          final atlasIndex = atlasCache.idToIndex[id]!;

          OverlayEntry? overlay;

          overlay = context.insertAnimatedOverlay(
            modalBarrierOn: true,
            onTapOutside: () {
              overlay?.remove();
              overlay = null;
            },
            children: [
              Positioned(
                left: bubbleLeft,
                top: bubbleTop,
                child: AnnotationBubble(
                  atlasCache: atlasCache,
                  atlasIndex: atlasIndex,
                  index: widget.index,
                  trianglePos: triPos,
                  isBubbleTop: isBubbleTop,
                  onTaps: .generate(
                    highlightTypes.length,
                    (i) =>
                        () => AnnotatorHandler.handleElementHit(
                          ref: ref,
                          id: id,
                          index: widget.index,
                          atlasCache: atlasCache,
                          atlasIndex: atlasIndex,
                          highlight: highlightTypes[i],
                        ),
                  ),
                ),
              ),
            ],
          );

          return;
        }
      },
      child: RepaintBoundary(
        child: CustomPaint(
          painter: MushafPagePainter(
            image: widget.image,
            whiteRect: ref.read(whiteRectProvider)!,
            vBoxSize: Size(widget.pageW, widget.pageH),
            atlasCache: atlasCache,
            isDarkMode: isDarkMode,
            pageRebuild: pageRebuild,
          ),
        ),
      ),
    );
  }
}
