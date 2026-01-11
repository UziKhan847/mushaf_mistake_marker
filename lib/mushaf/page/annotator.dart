import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/mushaf/page/painter.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_ele_data.dart';

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
  late final List<SpriteEleData> sprites;
  late final SprEleDataProvider eleMarkDataProv;
  late final Box<ElementMarkData> eleMarkDataBox;

  @override
  void initState() {
    super.initState();

    if (!mounted) return;

    sprites = ref.read(spriteProvider)[widget.index].sprMnfst;
    eleMarkDataProv = ref.read(sprEleDataProvider(widget.index).notifier);
    eleMarkDataBox = ref.read(elementMarkDataBoxProvider);
  }

  @override
  Widget build(BuildContext context) {
    final eleMarkDataList = ref.watch(sprEleDataProvider(widget.index));

    return GestureDetector(
      onTapDown: (details) {
        final localPos = details.localPosition;

        final (scaleX, scaleY) = (
          widget.w / widget.pageW,
          widget.h / widget.pageH,
        );

        final scaledPoint = Offset(localPos.dx / scaleX, localPos.dy / scaleY);

        for (final e in sprites) {
          final (id, left, top, right, bottom, scaledX, scaledY) =
              AnnotatorHandler.getSpriteData(e, scaledPoint);

          final isClicked = AnnotatorHandler.elemBounds(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
            scaledX: scaledX,
            scaledY: scaledY,
          );

          final isWord = id.contains(RegExp(r'[w]'));

          print('Element Id: $id');
          print('------------------');

          // if (!isWord || !isClicked) continue;
          if (!isClicked) continue;

          final eMarkDataIndex = eleMarkDataList.indexWhere((e) => e.key == id);

          if (eMarkDataIndex == -1) {
            eleMarkDataProv.addElement(id);
            return;
          }

          final eleMarkData = eleMarkDataList[eMarkDataIndex];

          eleMarkData.updateMark();

          if (eleMarkData.isEmpty) {
            eleMarkDataProv.removeElement(eleMarkData, eMarkDataIndex);
            return;
          }

          eleMarkDataProv.updateElement(eleMarkData, eMarkDataIndex);
          return;
        }
      },
      child: CustomPaint(
        painter: MushafPagePainter(
          vBoxSize: Size(widget.pageW, widget.pageH),
          eleMarkDataList: eleMarkDataList,
          sprites: sprites,
          image: widget.image,
          isDarkMode: Theme.of(context).brightness == .dark,
        ),
      ),
    );
  }
}
