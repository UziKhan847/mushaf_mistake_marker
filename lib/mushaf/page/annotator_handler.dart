import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/atlas_models/cache.dart';
import 'package:mushaf_mistake_marker/constants.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
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

      atlasCache.highlighColorList[atlasIndex] = highlightColors[0];
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

    element.highlight = highlight;
    eleBox.put(element);

    final highlightColorIndex = element.highlightColorIndex;

    final highlightColor = isDarkMode
        ? highlightDarkColors[highlightColorIndex]
        : highlightColors[highlightColorIndex];

    atlasCache.highlighColorList[atlasIndex] = highlightColor;

    if (element.isEmpty) eleBox.remove(element.id);
    pageRebuildProv.update();
    return;
  }
}
