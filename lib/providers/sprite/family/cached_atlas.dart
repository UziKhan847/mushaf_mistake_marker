import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
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
    final elemDataMap = ref.read(sprEleDataMapProvider(index));
    final isDarkMode = ref.watch(themeProvider);

    final floatListLength = sprites.length * 4;

    final rectList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);

    final highlightColorList = Int32List(sprites.length);

    final transformList = Float32List(floatListLength);

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
      final w = sprite.eLTWH[2];
      final h = sprite.eLTWH[3];

      rectList[byteIndex] = sx;
      rectList[byteIndex + 1] = sy;
      rectList[byteIndex + 2] = sx + w;
      rectList[byteIndex + 3] = sy + h;

      transformList[byteIndex] = 1.0;
      transformList[byteIndex + 1] = 0.0;
      transformList[byteIndex + 2] = sprite.eLTWH[0];
      transformList[byteIndex + 3] = sprite.eLTWH[1];

      final elem = elemDataMap[id];

      colorList[i] = elem?.annotation == null ? defaultMarkColor : blueInt;

      highlightColorList[i] = switch (elem?.highlight) {
        .doubt => activeHighlightColors[0],
        .mistake => activeHighlightColors[1],
        .oldMistake => activeHighlightColors[2],
        .tajwid => activeHighlightColors[3],
        _ => transparentColor,
      };
    }

    return AtlasCache(
      idToIndex: idToIndex,
      transformList: transformList,
      rectList: rectList,
      elemColorList: colorList,
      highlighColorList: highlightColorList,
    );
  }
}
