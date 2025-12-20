import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/list_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
import 'package:mushaf_mistake_marker/providers/marked_surahs.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/surah/page_surah_handler.dart';

class MushafPageAnnotator extends ConsumerStatefulWidget {
  const MushafPageAnnotator({
    super.key,
    required this.index,
    this.surahsNum,
    required this.h,
    required this.w,
    required this.pageH,
    required this.pageW,
  });

  final int index;
  final List<int>? surahsNum;
  final double w;
  final double h;
  final double pageW;
  final double pageH;

  @override
  ConsumerState<MushafPageAnnotator> createState() =>
      _MushafPageAnnotatorState();
}

class _MushafPageAnnotatorState extends ConsumerState<MushafPageAnnotator> {
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
    final surahsNum = widget.surahsNum;
    final pageNumber = widget.index + 1;
    final sprites = ref.read(spriteProvider)[widget.index].sprMnfst;
    final markedSurahsProv = ref.read(markedSurahsProvider.notifier);
    final image = ref.watch(
      spriteProvider.select((state) => state[widget.index].image),
    );

    List<Map<String, MarkType>> markedSurahs = List.generate(
      surahsNum!.length,
      (index) => ref.watch(
        markedSurahsProvider.select((state) => state[surahsNum[index] - 1]),
      ),
    );

    return GestureDetector(
      onTapDown: (details) {
        final localPos = details.localPosition;

        final (scaleX, scaleY) = (
          widget.w / widget.pageW,
          widget.h / widget.pageH,
        );

        final scaledPoint = Offset(localPos.dx / scaleX, localPos.dy / scaleY);

        for (final e in sprites) {
          final (id, left, top, right, bottom, scaledX, scaledY) = (
            e.id,
            e.eLTWH.first,
            e.eLTWH[1],
            e.eLTWH[2] + e.eLTWH.first,
            e.eLTWH.last + e.eLTWH[1],
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

          if (id.contains(RegExp(r'[bc]')) || !isClicked) {
            continue;
          }

          final indexOfSprite = sprites.indexWhere((e) => e.id == id);

          final surahIndex = PageSurahHandler(
            indexOfSprite: indexOfSprite,
            pageNumber: pageNumber,
            ref: ref,
          ).getSurahIndex();

          final markedSurah = surahsNum[surahIndex] - 1;

          final newMarkType = markedSurahsProv.getMarkType(markedSurah, id);

          if (newMarkType == null) {
            markedSurahsProv.removeMark(markedSurah, id);
          } else {
            markedSurahsProv.setMark(markedSurah, id, newMarkType);
          }
        }
      },
      child: CustomPaint(
        painter: MushafPagePainter(
          vBoxSize: Size(widget.pageW, widget.pageH),
          markedPaths: Map.from(markedSurahs.toCombinedMap()),
          sprites: sprites,
          image: image!,
          isDarkMode: Theme.of(context).brightness == .dark,
        ),
      ),
    );
  }
}
