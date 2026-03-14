import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/annotate_mode.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
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

  static ElementMarkData? getElement(String id, Box<ElementMarkData> elemBox) {
    final query = elemBox.query(ElementMarkData_.key.equals(id)).build();
    final element = query.findFirst();
    query.close();
    return element;
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

  static void addElement(
    WidgetRef ref,
    String id,
    AtlasCache atlasCache,
    int atlasIndex,
    int pgIndex,
    bool isDarkMode,
    Box<ElementMarkData> elemBox,
    UserMushafData mshfData,
    Box<UserMushafData> mshfDataBox, 
    PageRebuildNotifier pageRebuildProv,
    {
    HighlightType? highlight,
    String? annotation,
  }) {
    final element = ElementMarkData(
      key: id,
      annotation: annotation,
      highlight: highlight ?? .unknown,
    )..mushafData.target = mshfData;

    elemBox.put(element);
    mshfData.elementMarkData.add(element);
    mshfDataBox.put(mshfData);

    if (highlight != null) {
      atlasCache.highlighColorList[atlasIndex] = getHightlightColor(
        element.highlightColorIndex,
        isDarkMode,
      );
    }

    pageRebuildProv.update();
  }

  static int getHightlightColor(int colorIndex, bool isDarkMode) => isDarkMode
      ? highlightDarkColors[colorIndex]
      : highlightColors[colorIndex];

  static void handleElementHit({
    required WidgetRef ref,
    required String id,
    required int index,
    required AtlasCache atlasCache,
    required int atlasIndex,
    required HighlightType highlight,
  }) {
    final eleBox = ref.read(elementMarkDataBoxProvider);
    final annotateMode = ref.read(annotateModeProvider);
    final mushafData = ref.read(userMushafDataProvider)!;
    final mushafDataBox = ref.read(mushafDataBoxProvider);
    final pageRebuildProv = ref.read(pageRebuildProvider(index).notifier);
    final isDarkMode = ref.read(themeProvider);

    final defaultColor = isDarkMode ? whiteInt : blackInt;

    final query = eleBox.query(ElementMarkData_.key.equals(id)).build();
    final element = query.findFirst();
    query.close();

    if (element == null) {
      final newElement = ElementMarkData(key: id, highlight: highlight)
        ..mushafData.target = mushafData;

      eleBox.put(newElement);
      mushafData.elementMarkData.add(newElement);
      mushafDataBox.put(mushafData);

      final highlightColorIndex = newElement.highlightColorIndex;

      final highlightColor = isDarkMode
          ? highlightDarkColors[highlightColorIndex]
          : highlightColors[highlightColorIndex];

      atlasCache.highlighColorList[atlasIndex] = highlightColor;
      pageRebuildProv.update();
      return;
    }

    if (!annotateMode) {
      eleBox.remove(element.id);

      atlasCache.elemColorList[atlasIndex] = defaultColor;
      atlasCache.highlighColorList[atlasIndex] = transparentColor;

      pageRebuildProv.update();
      return;
    }

    if (element.highlight != highlight) {
      element.highlight = highlight;
      eleBox.put(element);

      final highlightColorIndex = element.highlightColorIndex;

      final highlightColor = isDarkMode
          ? highlightDarkColors[highlightColorIndex]
          : highlightColors[highlightColorIndex];

      atlasCache.highlighColorList[atlasIndex] = highlightColor;

      if (element.isEmpty) eleBox.remove(element.id);
      pageRebuildProv.update();
    }
  }
}
