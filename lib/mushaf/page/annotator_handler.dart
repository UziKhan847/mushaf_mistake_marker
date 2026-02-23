import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
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

  static void handleOnTap({
    required int index,
    required Offset localPosition,
    required Size viewSize,
    required Size pageSize,
    required WidgetRef ref,
    required VoidCallback setState,
  }) {
    final sprites = ref.read(spriteProvider)[index].sprMnfst;

    final scaleX = viewSize.width / pageSize.width;
    final scaleY = viewSize.height / pageSize.height;

    final scaledPoint = Offset(
      localPosition.dx / scaleX,
      localPosition.dy / scaleY,
    );

    for (final sprite in sprites) {
      if (!sprite.id.contains('w')) continue;

      final (id, left, top, right, bottom, scaledX, scaledY) = getSpriteData(
        sprite,
        scaledPoint,
      );

      final isClicked = elemBounds(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        scaledX: scaledX,
        scaledY: scaledY,
      );

      if (!isClicked) continue;

      final atlasCache = ref.read(cachedAtlasProvider(index));

      handleElementHit(id: id, ref: ref, atlasCache: atlasCache);

      return;
    }
  }

  static void handleElementHit({
    required String id,
    required WidgetRef ref,
    required AtlasCache atlasCache,
  }) {
    final eleBox = ref.read(elementMarkDataBoxProvider);
    final markupMode = ref.read(markupModeProvider);
    final mushafData = ref.read(userMushafDataProvider)!;
    final mushafDataBox = ref.read(mushafDataBoxProvider);
    final isDarkMode = ref.read(themeProvider);

    final defaultColor = isDarkMode ? whiteInt : blackInt;

    final query = eleBox.query(ElementMarkData_.key.equals(id)).build();

    final element = query.findFirst();

    final atlasIndex = atlasCache.idToIndex[id]!;

    query.close();

    if (markupMode == .eraser) {
      if (element != null) {
        eleBox.remove(element.id);
        atlasCache.pageMarkAtlas.colorList[atlasIndex] = defaultColor;
        atlasCache.pageHighlightsAtlas.colorList[atlasIndex] = 0x00000000;
      }
      return;
    }

    final isMarkMode = markupMode == .mark;

    if (element == null) {
      final MarkType mark = isMarkMode ? .doubt : .unknown;
      final MarkType highlight = isMarkMode ? .unknown : .doubt;

      final newElement = ElementMarkData(
        key: id,
        mark: mark,
        highlight: highlight,
      )..mushafData.target = mushafData;

      eleBox.put(newElement);
      mushafData.elementMarkData.add(newElement);
      mushafDataBox.put(mushafData);

      if (isMarkMode) {
        atlasCache.pageMarkAtlas.colorList[atlasIndex] = purpleInt;
      } else {
        atlasCache.pageHighlightsAtlas.colorList[atlasIndex] =
            highlightColors[0];
      }
      return;
    }

    if (isMarkMode) {
      element.updateMark();
      eleBox.put(element);

      atlasCache.pageMarkAtlas.colorList[atlasIndex] =
          element.markColor ?? defaultColor;
    } else {
      element.updateHighlight();
      eleBox.put(element);

      final highlightColorIndex = element.highlightColorIndex;

      final highlightColor = isDarkMode
          ? highlightDarkColors[highlightColorIndex]
          : highlightColors[highlightColorIndex];

      atlasCache.pageHighlightsAtlas.colorList[atlasIndex] = highlightColor;
    }

    if (element.mark == .unknown &&
        element.highlight == .unknown &&
        element.annotation == null) {
      eleBox.remove(element.id);
    }
  }
}
