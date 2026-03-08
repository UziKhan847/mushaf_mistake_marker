import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  BubblePainter({this.trianglePos = .bottomCenter});

  final TrianglePosition trianglePos;

  @override
  void paint(Canvas canvas, Size size) {
    const tipHeight = 20.0;
    const tipWidth = 20.0;

    final rectHeight = size.height - tipHeight;

    final path = Path()
      ..addRRect(RRect.fromLTRBAndCorners(0, 0, size.width, rectHeight));

    switch (trianglePos) {
      case .bottomLeft:
        path
          ..moveTo(0, rectHeight)
          ..lineTo(0, size.height)
          ..lineTo(size.width, rectHeight);
      case .bottomCenter:
        path
          ..moveTo((size.width - tipWidth) / 2, rectHeight)
          ..lineTo(size.width / 2, size.height)
          ..lineTo((size.width + tipWidth) / 2, rectHeight);
      case .bottomRight:
        path
          ..moveTo(size.width, rectHeight)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width - tipWidth, rectHeight);
      case .topLeft:
        path
          ..moveTo(0, rectHeight)
          ..lineTo(0, 0)
          ..lineTo(tipWidth, rectHeight);
      case .topCenter:
        path
          ..moveTo((size.width - tipWidth) / 2, rectHeight)
          ..lineTo(size.width / 2, 0)
          ..lineTo((size.width + tipWidth) / 2, rectHeight);
      case .topRight:
        path
          ..moveTo(size.width, rectHeight)
          ..lineTo(size.width, 0)
          ..lineTo(size.width - tipWidth, rectHeight);
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
