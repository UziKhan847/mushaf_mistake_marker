import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/page/annotator_handler.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/buttons/markup_mode.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/cached_atlas.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final mushafAnnotatorProvider =
    AutoDisposeNotifierProviderFamily<MushafAnnotatorNotifier, void, int>(
      MushafAnnotatorNotifier.new,
    );

class MushafAnnotatorNotifier extends AutoDisposeFamilyNotifier<void, int> {
  late final int pageIndex;

  @override
  void build(int pageIndex) {
    this.pageIndex = pageIndex;
    return;
  }

  void handleTap({
    required Offset localPosition,
    required Size viewSize,
    required Size pageSize,
  }) {
    final sprites = ref.read(spriteProvider)[pageIndex].sprMnfst;

    final scaleX = viewSize.width / pageSize.width;
    final scaleY = viewSize.height / pageSize.height;

    final scaledPoint = Offset(
      localPosition.dx / scaleX,
      localPosition.dy / scaleY,
    );

    for (final sprite in sprites) {
      if (!sprite.id.contains('w')) continue;

      final (id, left, top, right, bottom, scaledX, scaledY) =
          AnnotatorHandler.getSpriteData(sprite, scaledPoint);

      final isClicked = AnnotatorHandler.elemBounds(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        scaledX: scaledX,
        scaledY: scaledY,
      );

      if (!isClicked) continue;

      handleElementHit(id: id);

      return;
    }
  }

  void handleElementHit({required String id}) {
    final atlasCache = ref.read(cachedAtlasProvider(pageIndex));
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
