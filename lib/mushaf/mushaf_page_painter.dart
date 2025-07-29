import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/drawable_path/drawable_path.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({
    required this.paths,
    required this.vBoxSize,
    required this.markedPaths,
    required this.pageNumber,
  });

  final List<DrawablePath> paths;
  final Size vBoxSize;
  final Map<String, MarkType> markedPaths;
  final int pageNumber;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    for (final drawablePath in paths) {
      final path = drawablePath.path;
      final id = drawablePath.id;

      switch (markedPaths[id]) {
        case MarkType.doubt:
          paint.color = Colors.purple;
        case MarkType.mistake:
          paint.color = Colors.red;
        case MarkType.oldMistake:
          paint.color = Colors.lightBlue;
        case MarkType.tajwid:
          paint.color = Colors.green;
        default:
          paint.color = Colors.black;
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MushafPagePainter oldDelegate) =>
      !mapEquals(oldDelegate.markedPaths, markedPaths);
}
