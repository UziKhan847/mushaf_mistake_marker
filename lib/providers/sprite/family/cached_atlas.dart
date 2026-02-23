import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_annotations_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_highlights_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_marks_atlas.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_map.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final cachedAtlasProvider =
    AutoDisposeNotifierProviderFamily<CachedAtlasNotifier, AtlasCache, int>(
      CachedAtlasNotifier.new,
    );

class CachedAtlasNotifier extends AutoDisposeFamilyNotifier<AtlasCache, int> {
  @override
  AtlasCache build(int index) {
    final sprites = ref.read(spriteProvider)[index].sprMnfst;
    final eleDataMap = ref.read(sprEleDataMapProvider(index));
    final isDarkMode = ref.watch(themeProvider);

    final floatListLength = sprites.length * 4;

    final rectList = Float32List(floatListLength);
    final transformList = Float32List(floatListLength);
    final annotationTransformList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);

    final highlightRectList = Float32List(floatListLength);
    final highlightColorList = Int32List(sprites.length);

    final idToIndex = <String, int>{};

    int byteIndex = 0;

    final defaultMarkColor = isDarkMode ? whiteInt : blackInt;
    final activeHighlightColors = isDarkMode
        ? highlightDarkColors
        : highlightColors;

    for (int i = 0; i < sprites.length; i++, byteIndex += 4) {
      final sprite = sprites[i];
      final id = sprite.id;
      idToIndex[id] = i;

      final sx = sprite.sprXY[0];
      final sy = sprite.sprXY[1];
      final w = sprite.eLTWH[2].ceilToDouble();
      final h = sprite.eLTWH[3].ceilToDouble();

      rectList[byteIndex + 0] = sx;
      rectList[byteIndex + 1] = sy;
      rectList[byteIndex + 2] = sx + w;
      rectList[byteIndex + 3] = sy + h;

      highlightRectList[byteIndex + 0] = 0;
      highlightRectList[byteIndex + 1] = 0;
      highlightRectList[byteIndex + 2] = w;
      highlightRectList[byteIndex + 3] = h;

      transformList[byteIndex + 0] = 1.0;
      transformList[byteIndex + 1] = 0.0;
      transformList[byteIndex + 2] = sprite.eLTWH[0];
      transformList[byteIndex + 3] = sprite.eLTWH[1];

      annotationTransformList[byteIndex + 0] = -1.0;
      annotationTransformList[byteIndex + 1] = 0.0;
      annotationTransformList[byteIndex + 2] = sprite.eLTWH[0];
      annotationTransformList[byteIndex + 3] = sprite.eLTWH[1];

      final ele = eleDataMap[id];

      colorList[i] = switch (ele?.mark) {
        .doubt => purpleInt,
        .mistake => redInt,
        .oldMistake => blueInt,
        .tajwid => greenInt,
        _ => defaultMarkColor,
      };

      highlightColorList[i] = switch (ele?.highlight) {
        .doubt => activeHighlightColors[0],
        .mistake => activeHighlightColors[1],
        .oldMistake => activeHighlightColors[2],
        .tajwid => activeHighlightColors[3],
        _ => 0x00000000,
      };
    }

    final pageMarkAtlas = PageMarksAtlas(
      colorList: colorList,
      rectList: rectList,
      transformList: transformList,
    );

    final pageHighlightsAtlas = PageHighlightsAtlas(
      colorList: highlightColorList,
      rectList: highlightRectList,
      transformList: transformList,
    );

    return AtlasCache(
      idToIndex: idToIndex,
      pageMarkAtlas: pageMarkAtlas,
      pageHighlightsAtlas: pageHighlightsAtlas,
      pageAnnotatiosnAtlas: PageAnnotationsAtlas(
        colorList: colorList,
        rectList: rectList,
        transformList: transformList,
      ),
    );
  }
}
