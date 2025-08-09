import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/image/image_page.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.imagePage,
    //required this.paths,
    required this.vBoxSize,
    required this.markedPaths,
  });

  //final List<DrawablePath> paths;
  final ImagePage imagePage;
  final Size vBoxSize;
  final Map<String, MarkType> markedPaths;

  ColorFilter changeColor(Color color) =>
      ColorFilter.mode(color, BlendMode.srcIn);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..filterQuality = FilterQuality.high;
    //final ePaint = Paint()..filterQuality = FilterQuality.high;

    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;
    final imageDataList = imagePage.imageDataList;
    final images = imagePage.pageImages;
    //final image = imagePage.image!;

    canvas.scale(scaleX, scaleY);

    for (final e in imageDataList) {
      final id = e.id;
      final offset = e.offset;
      final eSize = e.origSize;
      final image = images[id];

      switch (markedPaths[id]) {
        case MarkType.doubt:
          paint.colorFilter = changeColor(Colors.purple);
        case MarkType.mistake:
          paint.colorFilter = changeColor(Colors.red);
        case MarkType.oldMistake:
          paint.colorFilter = changeColor(Colors.blue);
        case MarkType.tajwid:
          paint.colorFilter = changeColor(Colors.green);
        default:
          paint.colorFilter = changeColor(Colors.black);
      }

      // canvas.drawRect(
      //   Rect.fromLTWH(offset.dx, offset.dy, eSize.width, eSize.height),
      //   ePaint,
      // );

      if (image != null) {
        canvas.drawImage(image, offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      !mapEquals(oldDelegate.markedPaths, markedPaths);
}
