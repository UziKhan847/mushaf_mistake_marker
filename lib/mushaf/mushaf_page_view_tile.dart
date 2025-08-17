import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/image/image_page.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPageViewTile extends StatefulWidget {
  const MushafPageViewTile({
    super.key,
    required this.windowSize,
    required this.markedPaths,
    required this.spriteSheet,
    required this.pageData,
  });

  //final int pageNumber;
  final Size windowSize;
  final SpriteSheet spriteSheet;
  final PageData pageData;
  final Map<String, MarkType> markedPaths;

  @override
  State<MushafPageViewTile> createState() => _MushafPageViewTileState();
}

class _MushafPageViewTileState extends State<MushafPageViewTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    final markedPaths = widget.markedPaths;

    final sprites = widget.spriteSheet.sprites;
    final image = widget.spriteSheet.image;

    final pageW = widget.pageData.width;
    final pageH = widget.pageData.height;

    final w = widget.windowSize.width * 0.85;

    final h = w * (pageH / pageW);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: widget.windowSize.height),
        child: Center(
          child: SizedBox(
            width: w,
            height: h,
            child: GestureDetector(
              onTapDown: (details) {
                final localPos = details.localPosition;

                final scaleX = w / pageW;
                final scaleY = h / pageH;

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

                    print('-----------------------------------');
                    print('Clicked Element: $id');

                    setState(() {});
                  }
                }
              },
              child: CustomPaint(
                painter: MushafPagePainter(
                  vBoxSize: Size(pageW, pageH),
                  markedPaths: Map.from(markedPaths),
                  spriteSheet: widget.spriteSheet,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
