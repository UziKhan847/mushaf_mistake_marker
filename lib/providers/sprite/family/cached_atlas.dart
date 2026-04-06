import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dark_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_map.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final cachedAtlasProvider = NotifierProvider.autoDispose
    .family<CachedAtlasNotifier, AtlasCache, int>(CachedAtlasNotifier.new);

class CachedAtlasNotifier extends Notifier<AtlasCache> {
  CachedAtlasNotifier(this.index);
  final int index;

  @override
  AtlasCache build() {
    final sprites = ref.read(spriteProvider)[index].sprMnfst;
    final elemDataMap = ref.read(sprElemDataMapProvider(index));
    final isDarkMode = ref.watch(darkModeProvider);

    final floatListLength = sprites.length * 4;

    final rectList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);

    final highlightColorList = Int32List(sprites.length);

    final transformList = Float32List(floatListLength);

    final idToIndex = <String, int>{};

    int byteIndex = 0;

    final defaultElemColor = isDarkMode ? whiteInt : blackInt;
    final defaultAnnotateColor = isDarkMode
        ? lightGoldenBrown
        : darkGoldenBrown;
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

      colorList[i] = elem?.annotation == null
          ? defaultElemColor
          : defaultAnnotateColor;

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

  void updateElementColor(
    int pgIndex,
    int atlasIndex,
    bool isDarkMode,
    ElementMarkData? element,
  ) {
    final defaultElemColor = isDarkMode ? whiteInt : blackInt;
    final defaultAnnotateColor = isDarkMode
        ? lightGoldenBrown
        : darkGoldenBrown;

    if (element == null) {
      state.highlighColorList[atlasIndex] = transparentColor;
      state.elemColorList[atlasIndex] = defaultElemColor;
    } else {
      state.highlighColorList[atlasIndex] = element.highlight == .unknown
          ? transparentColor
          : getHighlightColor(element.highlightColorIndex, isDarkMode);
      state.elemColorList[atlasIndex] =
          element.annotation == null || element.annotation == ''
          ? defaultElemColor
          : defaultAnnotateColor;
    }

    ref.read(pageRebuildProvider(pgIndex).notifier).update();
  }

  int getHighlightColor(int colorIndex, bool isDarkMode) => isDarkMode
      ? highlightDarkColors[colorIndex]
      : highlightColors[colorIndex];
}
