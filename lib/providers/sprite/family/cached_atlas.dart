import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_mark_atlas.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/providers/buttons/theme.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_marks.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/sprite_models/rst_offset.dart';

final cachedAtlasProvider =
    AutoDisposeNotifierProviderFamily<CachedAtlasNotifier, AtlasCache, int>(
      CachedAtlasNotifier.new,
    );

class CachedAtlasNotifier extends AutoDisposeFamilyNotifier<AtlasCache, int> {
  @override
  AtlasCache build(int index) {
    final sprites = ref.read(spriteProvider)[index].sprMnfst;
    final pageMarks = ref.read(pageMarksProvider(index));
    final isDarkMode = ref.watch(themeProvider);

    final floatListLength = sprites.length * 4;

    final rectList = Float32List(floatListLength);
    final transformList = Float32List(floatListLength);
    final colorList = Int32List(sprites.length);
    final idToIndex = <String, int>{};

    int byteIndex = 0;

    for (int i = 0; i < sprites.length; i++, byteIndex += 4) {
      final sprite = sprites[i];
      final id = sprite.id;
      final rectLTWH = (
        sprite.sprXY.first,
        sprite.sprXY.last,
        sprite.eLTWH[2].ceil(),
        sprite.eLTWH.last.ceil(),
      );

      idToIndex[id] = i;

      final rstOffset = RstOffset(x: sprite.eLTWH.first, y: sprite.eLTWH[1]);

      final rectLTRB = [
        rectLTWH.$1,
        rectLTWH.$2,
        rectLTWH.$1 + rectLTWH.$3,
        rectLTWH.$2 + rectLTWH.$4,
      ];

      final rstValues = [1.0, 0.0, rstOffset.x, rstOffset.y];

      for (int x = 0; x < 4; x++) {
        rectList[byteIndex + x] = rectLTRB[x];
        transformList[byteIndex + x] = rstValues[x];
      }

      final eleMark = pageMarks[id];

      colorList[i] = switch (eleMark) {
        .doubt => purpleInt,
        .mistake => redInt,
        .oldMistake => blueInt,
        .tajwid => greenInt,
        _ => isDarkMode ? whiteInt : blackInt,
      };
    }

    final pageMarkAtlas = PageMarksAtlas(
      colorList: colorList,
      rectList: rectList,
      transformList: transformList,
    );

    return AtlasCache(idToIndex: idToIndex, pageMarkAtlas: pageMarkAtlas);
  }
}
