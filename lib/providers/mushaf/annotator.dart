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
import 'package:mushaf_mistake_marker/providers/sprite/family/ele_mark_data_list.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/annotations.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/highlights.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/marks.dart';
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
    final (
      sprites,
      atlasCache,
      eleListProv,
      eleBox,
      pageMarksProv,
      pageHighlightProv,
      pageAnnoteProv,
      markupMode,
      mushafData,
      mushafDataBox,
      isDarkMode,
    ) = (
      ref.read(spriteProvider)[pageIndex].sprMnfst,
      ref.read(cachedAtlasProvider(pageIndex)),
      ref.read(sprEleDataListProvider(pageIndex)),
      ref.read(elementMarkDataBoxProvider),
      ref.read(pageMarksProvider(pageIndex).notifier),
      ref.read(pageHighlightsProvider(pageIndex).notifier),
      ref.read(pageAnnotationsProvider(pageIndex).notifier),
      ref.read(markupModeProvider),
      ref.read(userMushafDataProvider)!,
      ref.read(mushafDataBoxProvider),
      ref.read(themeProvider),
    );

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

      handleElementHit(
        id: id,
        atlasIndex: atlasCache.idToIndex[id]!,
        atlasCache: atlasCache,
        eleBox: eleBox,
        pageMarksProv: pageMarksProv,
        pageHighlightProv: pageHighlightProv,
        markupMode: markupMode,
        mushafData: mushafData,
        mushafDataBox: mushafDataBox,
        isDarkMode: isDarkMode,
      );

      return;
    }
  }

  void handleElementHit({
    required String id,
    required int atlasIndex,
    required AtlasCache atlasCache,
    required Box<ElementMarkData> eleBox,
    required PageMarksNotifier pageMarksProv,
    required PageHighlightsNotifier pageHighlightProv,
    required MarkupMode markupMode,
    required UserMushafData mushafData,
    required Box<UserMushafData> mushafDataBox,
    required bool isDarkMode,
  }) {
    final defaultColor = isDarkMode ? whiteInt : blackInt;

    final element = eleBox
        .query(ElementMarkData_.key.equals(id))
        .build()
        .findFirst();

    if (markupMode == .eraser) {
      if (element != null) {
        eleBox.remove(element.id);
        atlasCache.pageMarkAtlas.colorList[atlasIndex] = defaultColor;
        pageMarksProv.remove(id);
        pageHighlightProv.remove(id);
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
        atlasCache.pageMarkAtlas.colorList[atlasIndex] = newElement.markColor!;
        pageMarksProv.update(id, mark);
      } else {
        pageHighlightProv.update(id, highlight);
      }
      return;
    }

    if (isMarkMode) {
      element.updateMark();
      eleBox.put(element);

      atlasCache.pageMarkAtlas.colorList[atlasIndex] =
          element.markColor ?? defaultColor;

      element.mark == .unknown
          ? pageMarksProv.remove(id)
          : pageMarksProv.update(id, element.mark);
    } else {
      element.updateHighlight();
      eleBox.put(element);

      element.highlight == .unknown
          ? pageHighlightProv.remove(id)
          : pageHighlightProv.update(id, element.highlight);
    }

    if (element.mark == .unknown &&
        element.highlight == .unknown &&
        element.annotation == null) {
      eleBox.remove(element.id);
    }
  }
}
