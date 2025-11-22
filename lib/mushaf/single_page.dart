import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/list_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
import 'package:mushaf_mistake_marker/providers/marked_surahs_provider.dart';
import 'package:mushaf_mistake_marker/providers/sprite_provider.dart';
import 'package:mushaf_mistake_marker/surah/page_surah_handler.dart';

class SinglePage extends ConsumerStatefulWidget {
  const SinglePage({
    super.key,
    required this.w,
    required this.h,
    required this.pageW,
    required this.pageH,
    required this.index,
    this.surahsNum,
  });

  final double w;
  final double h;
  final double pageW;
  final double pageH;
  final int index;
  final List<int>? surahsNum;

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
    final surahsNum = widget.surahsNum!;
    final pageNumber = widget.index + 1;
    final sprites = ref.read(spriteProvider)[widget.index].sprites;
    final markedSurahsProv = ref.read(markedSurahsProvider.notifier);
    final image = ref.watch(
      spriteProvider.select((state) => state[widget.index].image),
    );

    List<Map<String, MarkType>> markedSurahs = List.generate(
      surahsNum.length,
      (index) => ref.watch(
        markedSurahsProvider.select((state) => state[surahsNum[index] - 1]),
      ),
    );

    // print('----------------------------------------');
    // print('Rebuilt page: ${widget.index + 1}');
    // print('----------------------------------------');

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
                  final newMarkType = markedSurahsProv.getMarkType(
                    markedSurah,
                    id,
                  );

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
                  image: image,
                  isDarkMode: Theme.of(context).brightness == .dark,
                ),
              ),
            ),
    );
  }
}
