import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/drawable_path/drawable_path.dart';

class MushafPagePainter extends CustomPainter {
  MushafPagePainter({required this.paths, required this.vBoxSize});

  final List<DrawablePath> paths;
  final Size vBoxSize;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    paint.color = Colors.black;

    for (int i = 0; i < paths.length; i++) {
      final path = paths[i].path;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
