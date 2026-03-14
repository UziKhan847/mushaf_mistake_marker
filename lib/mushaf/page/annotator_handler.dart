import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/sprite_models/sprite_ele_data.dart';

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

  static BorderRadius getBubbleBorderRadius(TrianglePosition trianglePos) {
    const radius = Radius.circular(8.0);
    return switch (trianglePos) {
      .bottomLeft => BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomRight: radius,
      ),
      .bottomCenter => BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      .bottomRight => BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
      ),
      .topLeft => BorderRadius.only(
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      .topCenter => BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      .topRight => BorderRadius.only(
        topLeft: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
    };
  }

  static (String id, double left, double top, double right, double bottom)
  getSpriteData(SpriteEleData e) => (
    e.id,
    e.eLTWH[0],
    e.eLTWH[1],
    e.eLTWH[2] + e.eLTWH[0],
    e.eLTWH[3] + e.eLTWH[1],
  );

  static HighlightType highlightFromColor(int color) => switch (color) {
    lightDoubtInt32Purple || darkDoubtInt32Purple => .doubt,
    lightMistakeInt32Red || darkMistakeInt32Red => .mistake,
    lightOldMistakeInt32Blue || darkOldMistakeInt32Blue => .oldMistake,
    lightTajwidInt32Green || darkTajwidInt32Green => .tajwid,
    _ => .unknown,
  };

  static (double, double, TrianglePosition) calcBubblePosition({
    required Offset globalPos,
    required Offset elemGlobalLT,
    required double elemW,
    required double elemH,
    required double scaleY,
    required double screenWidth,
  }) {
    final isBubbleTop = globalPos.dy >= 250;

    final double top = isBubbleTop
        ? elemGlobalLT.dy - 96
        : elemGlobalLT.dy + elemH * scaleY + 10;

    final double left;
    final TrianglePosition triPos;

    if (globalPos.dx < 300) {
      left = elemGlobalLT.dx + (elemW * scaleY / 2);
      triPos = isBubbleTop ? .bottomLeft : .topLeft;
    } else if (globalPos.dx > screenWidth - 300) {
      left = elemGlobalLT.dx - 250 + elemW * scaleY / 2;
      triPos = isBubbleTop ? .bottomRight : .topRight;
    } else {
      left = elemGlobalLT.dx - ((250 - elemW * scaleY) / 2);
      triPos = isBubbleTop ? .bottomCenter : .topCenter;
    }

    return (left, top, triPos);
  }

  static (double, TrianglePosition) getBubbleLeftAndTriPos(
    double scrnGLeft,
    double scrnW,
    double sprW,
    double scaleX,
    double elemGLeft,
    bool isBubbleTop,
  ) {
    late final double bubbleLeft;
    late final TrianglePosition triPos;

    if (scrnGLeft < 300) {
      bubbleLeft = elemGLeft + (sprW * scaleX / 2);
      triPos = isBubbleTop ? .bottomLeft : .topLeft;
    } else if (scrnGLeft > scrnW - 300) {
      bubbleLeft = elemGLeft - 250 + sprW * scaleX / 2;
      triPos = isBubbleTop ? .bottomRight : .topRight;
    } else {
      bubbleLeft = elemGLeft - ((250 - sprW * scaleX) / 2);
      triPos = isBubbleTop ? .bottomCenter : .topCenter;
    }

    return (bubbleLeft, triPos);
  }
}
