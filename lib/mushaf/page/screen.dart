import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

class MushafPageScreen extends ConsumerStatefulWidget {
  const MushafPageScreen({
    super.key,
    required this.index,
    this.surahsNum,
    required this.w,
    required this.h,
    required this.pageW,
    required this.pageH,
  });

  final double w;
  final double h;
  final double pageW;
  final double pageH;
  final int index;
  final List<int>? surahsNum;

  @override
  ConsumerState<MushafPageScreen> createState() => _MushafPageScreenState();
}

class _MushafPageScreenState extends ConsumerState<MushafPageScreen> {
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
    //final surahsNum = widget.surahsNum!;
    final image = ref.watch(
      spriteProvider.select((state) => state[widget.index].image),
    );

    // List<Map<String, MarkType>> markedSurahs = List.generate(
    //   surahsNum.length,
    //   (index) => ref.watch(
    //     markedSurahsProvider.select((state) => state[surahsNum[index] - 1]),
    //   ),
    // );

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
          : MushafPageAnnotator(
              index: widget.index,
              surahsNum: widget.surahsNum,
              h: widget.h,
              w: widget.w,
              pageH: widget.pageH,
              pageW: widget.pageW,
            ),
    );
  }
}
