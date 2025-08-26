import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
import 'package:mushaf_mistake_marker/providers/theme_provider.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class SinglePage extends ConsumerStatefulWidget {
  const SinglePage({
    super.key,
    required this.w,
    required this.h,
    required this.pageW,
    required this.pageH,
    required this.markedPaths,
    required this.spriteSheet,
  });

  final double w;
  final double h;
  final double pageW;
  final double pageH;
  final SpriteSheet spriteSheet;
  final Map<String, MarkType> markedPaths;

  @override
  ConsumerState<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends ConsumerState<SinglePage> {
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
    final sprites = widget.spriteSheet.sprites;
    final markedPaths = widget.markedPaths;

    final isDarkMode = ref.watch(themeProvider);

    return SizedBox(
      width: widget.w,
      height: widget.h,
      child: GestureDetector(
        onTapDown: (details) {
          final localPos = details.localPosition;

          final scaleX = widget.w / widget.pageW;
          final scaleY = widget.h / widget.pageH;

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

              //print('-----------------------------------');
              //print('Clicked Element: $id');

              setState(() {});
            }
          }
        },
        child: CustomPaint(
          painter: MushafPagePainter(
            vBoxSize: Size(widget.pageW, widget.pageH),
            markedPaths: Map.from(markedPaths),
            spriteSheet: widget.spriteSheet,
            isDarkMode: isDarkMode,
          ),
        ),
      ),
    );
  }
}
