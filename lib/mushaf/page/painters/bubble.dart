import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  BubblePainter({this.trianglePos = .bottomCenter, this.isBubbleTop = true});

  final TrianglePosition trianglePos;
  final bool isBubbleTop;

  @override
  void paint(Canvas canvas, Size size) {
    const triH = 20.0;
    const triW = 20.0;

    final rectHeight = size.height - triH;

    final path = Path();

    isBubbleTop
        ? path.addRRect(RRect.fromLTRBAndCorners(0, 0, size.width, rectHeight))
        : path.addRRect(
            RRect.fromLTRBAndCorners(0, triH, size.width, rectHeight),
          );

    switch (trianglePos) {
      case .bottomLeft:
        path
          ..moveTo(0, rectHeight)
          ..lineTo(0, size.height)
          ..lineTo(triW, rectHeight);
      case .bottomCenter:
        path
          ..moveTo((size.width - triW) / 2, rectHeight)
          ..lineTo(size.width / 2, size.height)
          ..lineTo((size.width + triW) / 2, rectHeight);
      case .bottomRight:
        path
          ..moveTo(size.width, rectHeight)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width - triW, rectHeight);
      case .topLeft:
        path
          ..moveTo(0, 0)
          ..lineTo(0, triH)
          ..lineTo(triW, triH);
      case .topCenter:
        path
          ..moveTo((size.width - triW) / 2, triH)
          ..lineTo(size.width / 2, 0)
          ..lineTo((size.width + triW) / 2, triH);
      case .topRight:
        path
          ..moveTo(size.width, 0)
          ..lineTo(size.width, triH)
          ..lineTo(size.width - triW, triH);
    }

    path.close();

    canvas.drawShadow(path, Colors.black, 8.0, false);
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum TrianglePosition {
  bottomLeft,
  bottomCenter,
  bottomRight,
  topLeft,
  topCenter,
  topRight,
}
