import 'dart:ui' as ui;
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/extensions/context_extensions.dart';
import 'package:mushaf_mistake_marker/extensions/string_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painters/mushaf_page.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/element.dart';
import 'package:mushaf_mistake_marker/overlay/widgets/annotation_bubble.dart';
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
  late final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final atlasCache = ref.read(cachedAtlasProvider(widget.index));
    final isDarkMode = Theme.brightnessOf(context) == .dark;
    final pageRebuild = ref.watch(pageRebuildProvider(widget.index));

    return GestureDetector(
      onTapDown: (details) async {
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

          final atlasIndex = atlasCache.idToIndex[id]!;

          final annotationMode = ref.read(annotateModeProvider);

          switch (annotationMode) {
            case .earser:
              final element = ref.read(elementProvider(id));
              ref.read(elementProvider(id).notifier).removeElement(element);
              ref
                  .read(cachedAtlasProvider(widget.index).notifier)
                  .updateElementColor(
                    widget.index,
                    atlasIndex,
                    isDarkMode,
                    null,
                  );
            case .audio:
              try {
                final duration = await player.setUrl(id.toQuranAudioUrl);
                if (duration != null) {
                  await player.play();
                }
              } catch (e, st) {
                throw Exception('Error: $e.\nStack Trace: $st');
              }

            case .highlight:
              final scrnSize = MediaQuery.sizeOf(context);
              final gp = details.globalPosition;

              final renderbox = context.findRenderObject() as RenderBox;
              final elemGlobalLT = renderbox.localToGlobal(
                Offset(left * scaleX, top * scaleY),
              );

              final isBubbleTop = gp.dy > annotateBubbleWidth;
              final double bubbleTop = isBubbleTop
                  ? elemGlobalLT.dy - 86
                  : elemGlobalLT.dy + sprite.eLTWH[3] * scaleY;

              final (
                bubbleLeft,
                triPos,
              ) = AnnotatorHandler.getBubbleLeftAndTriPos(
                scrnSize.width,
                elemGlobalLT.dx + ((sprite.eLTWH[2] * scaleX) / 2),
                isBubbleTop,
              );

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
                      atlasIndex: atlasIndex,
                      elemId: id,
                      pgIndex: widget.index,
                      trianglePos: triPos,
                      isBubbleTop: isBubbleTop,
                    ),
                  ),
                ],
              );
          }

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
