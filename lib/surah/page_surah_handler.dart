import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/surah/pages_with_multiple_surahs.dart';

class PageSurahHandler {
  PageSurahHandler({
    required this.indexOfSprite,
    required this.pageNumber,
    required this.ref,
  }) : pageHasTwoSurahs = pagesWithTwoSurahsRanges.keys.contains(pageNumber),
       pageHasThreeSurahs = pagesWithThreeSurahsRanges.keys.contains(
         pageNumber,
       );

  final int indexOfSprite;
  final int pageNumber;
  final WidgetRef ref;
  final bool pageHasTwoSurahs;
  final bool pageHasThreeSurahs;

  bool isIndexWithinRange(List<List<int>> rangeList) {
    for (final e in rangeList) {
      final isWithinRange = indexOfSprite >= e.first && indexOfSprite <= e.last;
      if (isWithinRange) {
        return isWithinRange;
      }
    }
    return false;
  }

  int getTwoSurahPSIndex() {
    final firstSurahRangeList =
        pagesWithTwoSurahsRanges[pageNumber] as List<List<int>>;

    if (!isIndexWithinRange(firstSurahRangeList)) {
      return 1;
    }

    return 0;
  }

  int getThreeSurahPSIndex() {
    final secondSurahRangeList =
        pagesWithThreeSurahsRanges[pageNumber]!['s2'] as List<List<int>>;
    final thirdSurahRangeList =
        pagesWithThreeSurahsRanges[pageNumber]!['s3'] as List<List<int>>;

    if (isIndexWithinRange(secondSurahRangeList)) {
      return 1;
    }

    if (isIndexWithinRange(thirdSurahRangeList)) {
      return 2;
    }

    return 0;
  }

  int getSurahIndex() {
    if (pageHasThreeSurahs) {
      return getThreeSurahPSIndex();
    }
    if (pageHasTwoSurahs) {
      return getTwoSurahPSIndex();
    }

    return 0;
  }
}
