import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_highlights_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_marks_atlas.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/highlights.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/marks.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final cachedAtlasProvider =
    AutoDisposeNotifierProviderFamily<CachedAtlasNotifier, AtlasCache, int>(
      CachedAtlasNotifier.new,
    );

class CachedAtlasNotifier extends AutoDisposeFamilyNotifier<AtlasCache, int> {
  @override
  AtlasCache build(int index) {
    final sprites = ref.read(spriteProvider)[index].sprMnfst;
    final pageMarks = ref.read(pageMarksProvider(index));
    final pageHighlights = ref.read(pageHighlightsProvider(index));
    final isDarkMode = ref.watch(themeProvider);

    final floatListLength = sprites.length * 4;

    final rectList = Float32List(floatListLength);
    final transformList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);

    final highlightRectList = Float32List(floatListLength);
    final highlightColorList = Int32List(sprites.length);

    final idToIndex = <String, int>{};

    int byteIndex = 0;

    for (int i = 0; i < sprites.length; i++, byteIndex += 4) {
      final sprite = sprites[i];
      final id = sprite.id;
      idToIndex[id] = i;

      final sx = sprite.sprXY.first;
      final sy = sprite.sprXY.last;
      final w = sprite.eLTWH[2].ceil().toDouble();
      final h = sprite.eLTWH.last.ceil().toDouble();

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
      transformList[byteIndex + 2] = sprite.eLTWH.first;
      transformList[byteIndex + 3] = sprite.eLTWH[1];

      final eleMark = pageMarks[id];
      final eleHighlight = pageHighlights[id];

      colorList[i] = switch (eleMark) {
        .doubt => purpleInt,
        .mistake => redInt,
        .oldMistake => blueInt,
        .tajwid => greenInt,
        _ => isDarkMode ? whiteInt : blackInt,
      };

      highlightColorList[i] = switch (eleHighlight) {
        .doubt => isDarkMode ? highlightDarkColors[0] : highlightColors[0],
        .mistake => isDarkMode ? highlightDarkColors[1] : highlightColors[1],
        .oldMistake => isDarkMode ? highlightDarkColors[2] : highlightColors[2],
        .tajwid => isDarkMode ? highlightDarkColors[2] : highlightColors[2],
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
    );
  }
}
