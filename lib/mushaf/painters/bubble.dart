import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class BubblePainter extends CustomPainter {
  BubblePainter({this.trianglePos = .bottomCenter, required this.isDarkMode});

  final TrianglePosition trianglePos;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    const triH = 15.0;
    const triW = 20.0;

    final radius = Radius.circular(8.0);

    final rectHeight = size.height - triH;

    final path = Path();

    switch (trianglePos) {
      case .bottomLeft:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width,
              rectHeight,
              topLeft: radius,
              topRight: radius,
              bottomRight: radius,
            ),
          )
          ..moveTo(0, rectHeight)
          ..lineTo(0, size.height)
          ..lineTo(triW, rectHeight);
      case .bottomCenter:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width,
              rectHeight,
              topLeft: radius,
              topRight: radius,
              bottomLeft: radius,
              bottomRight: radius,
            ),
          )
          ..moveTo((size.width - triW) / 2, rectHeight)
          ..lineTo(size.width / 2, size.height)
          ..lineTo((size.width + triW) / 2, rectHeight);
      case .bottomRight:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width,
              rectHeight,
              topLeft: radius,
              topRight: radius,
              bottomLeft: radius,
            ),
          )
          ..moveTo(size.width, rectHeight)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width - triW, rectHeight);
      case .topLeft:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              triH,
              size.width,
              rectHeight,
              topRight: radius,
              bottomLeft: radius,
              bottomRight: radius,
            ),
          )
          ..moveTo(0, 0)
          ..lineTo(0, triH)
          ..lineTo(triW, triH);
      case .topCenter:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              triH,
              size.width,
              rectHeight,
              topLeft: radius,
              topRight: radius,
              bottomLeft: radius,
              bottomRight: radius,
            ),
          )
          ..moveTo((size.width - triW) / 2, triH)
          ..lineTo(size.width / 2, 0)
          ..lineTo((size.width + triW) / 2, triH);
      case .topRight:
        path
          ..addRRect(
            RRect.fromLTRBAndCorners(
              0,
              triH,
              size.width,
              rectHeight,
              topLeft: radius,
              bottomLeft: radius,
              bottomRight: radius,
            ),
          )
          ..moveTo(size.width, 0)
          ..lineTo(size.width, triH)
          ..lineTo(size.width - triW, triH);
    }

    path.close();

    canvas.drawShadow(path, Colors.black, 8.0, false);
    canvas.drawPath(
      path,
      Paint()
        ..color = isDarkMode
            ? const Color(0xFF3A3A3A)
            : const Color(0xFFFFFFFF),
    );
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => false;
}
