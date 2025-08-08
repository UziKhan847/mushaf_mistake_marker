import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/png/png_page.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.pngPage,
    //required this.paths,
    required this.vBoxSize,
    required this.markedPaths,
  });

  //final List<DrawablePath> paths;
  final PngPage pngPage;
  final Size vBoxSize;
  final Map<String, MarkType> markedPaths;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..filterQuality = FilterQuality.high;
    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;
    final pngDataList = pngPage.pngDataList;
    final pngImgs = pngPage.pageImages;

    // print('SCALE X: $scaleX');
    // print('SCALE Y: $scaleY');

    canvas.scale(scaleX, scaleY);

    for (final e in pngDataList) {
      final id = e.id;
      final offset = e.offset;
      final image = pngImgs[id];

      if (image != null) {
        canvas.drawImage(image, offset, paint);
      }
    }

    // for (final drawablePath in paths) {
    //   final path = drawablePath.path;
    //   final id = drawablePath.id;

    //   switch (markedPaths[id]) {
    //     case MarkType.doubt:
    //       paint.color = Colors.purple;
    //     case MarkType.mistake:
    //       paint.color = Colors.red;
    //     case MarkType.oldMistake:
    //       paint.color = Colors.lightBlue;
    //     case MarkType.tajwid:
    //       paint.color = Colors.green;
    //     default:
    //       paint.color = Colors.black;
    //   }

    //   canvas.drawPath(path, paint);
    // }
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      !mapEquals(oldDelegate.markedPaths, markedPaths);
}
