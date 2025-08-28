import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
import 'package:mushaf_mistake_marker/providers/sprite_provider.dart';
import 'package:mushaf_mistake_marker/providers/theme_provider.dart';

class SinglePage extends ConsumerStatefulWidget {
  const SinglePage({
    super.key,
    required this.w,
    required this.h,
    required this.pageW,
    required this.pageH,
    required this.markedPaths,
    required this.index,
    //required this.spriteSheet,
  });

  final double w;
  final double h;
  final double pageW;
  final double pageH;
  final int index;
  //final SpriteSheet spriteSheet;
  final Map<String, MarkType> markedPaths;

  @override
  ConsumerState<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends ConsumerState<SinglePage> {
  //late final sprites = widget.spriteSheet.sprites;
  late final markedPaths = widget.markedPaths;
  ui.Image? cachedImage;

  bool elemBounds({
    required double top,
    required double bottom,
    required double left,
    required double right,
    required double scaledX,
    required double scaledY,
  }) {
    return scaledX >= left &&
        scaledY >= top &&
        scaledX <= right &&
        scaledY <= bottom;
  }

  @override
  Widget build(BuildContext context) {
    // final sprites = widget.spriteSheet.sprites;
    // final markedPaths = widget.markedPaths;

    final sprites = ref.read(spriteProvider)[widget.index].sprites;

    final image = ref.watch(
      spriteProvider.select((state) => state[widget.index].image),
    );

    final isDarkMode = ref.watch(themeProvider);

    print('----------------------------------------');
    print('Rebuilt page: ${widget.index + 1}');
    print('----------------------------------------');

    return SizedBox(
      width: widget.w,
      height: widget.h,
      child: image == null
          ? const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : GestureDetector(
              onTapDown: (details) {
                final localPos = details.localPosition;

                final (scaleX, scaleY) = (
                  widget.w / widget.pageW,
                  widget.h / widget.pageH,
                );

                final scaledPoint = Offset(
                  localPos.dx / scaleX,
                  localPos.dy / scaleY,
                );

                for (final e in sprites) {
                  final (id, left, top, right, bottom, scaledX, scaledY) = (
                    e.id,
                    e.rstOffset.x,
                    e.rstOffset.y,
                    e.origSize.w + e.rstOffset.x,
                    e.origSize.h + e.rstOffset.y,
                    scaledPoint.dx,
                    scaledPoint.dy,
                  );

                  final isClicked = elemBounds(
                    top: top,
                    bottom: bottom,
                    left: left,
                    right: right,
                    scaledX: scaledX,
                    scaledY: scaledY,
                  );

                  if (!id.contains(RegExp(r'[bc]')) && isClicked) {
                    switch (markedPaths[id]) {
                      case MarkType.doubt:
                        markedPaths[id] = MarkType.mistake;
                      case MarkType.mistake:
                        markedPaths[id] = MarkType.oldMistake;
                      case MarkType.oldMistake:
                        markedPaths[id] = MarkType.tajwid;
                      case MarkType.tajwid:
                        markedPaths.remove(id);
                      default:
                        markedPaths[id] = MarkType.doubt;
                    }

                    setState(() {});
                  }
                }
              },
              child: CustomPaint(
                painter: MushafPagePainter(
                  vBoxSize: Size(widget.pageW, widget.pageH),
                  markedPaths: Map.from(markedPaths),
                  sprites: sprites,
                  image: image,
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
    );
  }
}
