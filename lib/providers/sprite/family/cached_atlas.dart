import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/models/atlas/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:mushaf_mistake_marker/providers/buttons/dark_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_map.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/rebuild.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final cachedAtlasProvider = NotifierProvider.family
    .autoDispose<CachedAtlasNotifier, AtlasCache, int>(CachedAtlasNotifier.new);

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

      final element = elemDataMap[id];
      final hasAnnotation = element?.annotation != null;

      colorList[i] = getElemColor(element, hasAnnotation, isDarkMode);

      highlightColorList[i] = getHighlightColor(
        element,
        hasAnnotation,
        isDarkMode,
      );
    }

    return AtlasCache(
      idToIndex: idToIndex,
      transformList: transformList,
      rectList: rectList,
      colorList: colorList,
      highlightColorList: highlightColorList,
    );
  }

  void updateElementColor(
    int pgIndex,
    int atlasIndex,
    bool isDarkMode,
    ElementMarkData? element,
  ) {
    final hasAnnotation = element?.annotation != null;

    state.colorList[atlasIndex] = getElemColor(
      element,
      hasAnnotation,
      isDarkMode,
    );

    state.highlightColorList[atlasIndex] = getHighlightColor(
      element,
      hasAnnotation,
      isDarkMode,
    );

    ref.read(pageRebuildProvider(pgIndex).notifier).update();
  }

  int getElemColor(
    ElementMarkData? element,
    bool hasAnnotation,
    bool isDarkMode,
  ) => hasAnnotation
      ? (isDarkMode
            ? element!.highlight.annotDarkColor ?? whiteInt
            : element!.highlight.annotColor ?? blackInt)
      : (isDarkMode ? whiteInt : blackInt);

  int getHighlightColor(
    ElementMarkData? element,
    bool hasAnnotation,
    bool isDarkMode,
  ) => (hasAnnotation && element?.highlight == .unknown)
      ? (isDarkMode ? annotateDefaultDark : annotateDefault)
      : (isDarkMode
            ? element?.highlight.darkColor ?? transparentColor
            : element?.highlight.color ?? transparentColor);
}
