import 'dart:ui';

import 'package:mushaf_mistake_marker/sprite/sprite_ele_data.dart';

class AnnotatorHandler {
  static bool elemBounds({
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

  static (
    String id,
    double left,
    double top,
    double right,
    double bottom,
    double scaledX,
    double scaledY,
  )
  getSpriteData(SpriteEleData e, Offset scaledPoint) => (
    e.id,
    e.eLTWH.first,
    e.eLTWH[1],
    e.eLTWH[2] + e.eLTWH.first,
    e.eLTWH.last + e.eLTWH[1],
    scaledPoint.dx,
    scaledPoint.dy,
  );
}
