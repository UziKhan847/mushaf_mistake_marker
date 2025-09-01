import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/surah/pages_with_multiple_surahs.dart';

class MushafDualPageTile extends StatelessWidget {
  const MushafDualPageTile({
    super.key,
    required this.pageData,
    required this.constraints,
    required this.dualPageIndex,
  });

  final List<int> dualPageIndex;
  final List<PageData> pageData;
  final BoxConstraints constraints;

  (double, double) getWH(double pageW, double pageH) {
    double w = constraints.maxWidth * 0.39;
    double h = constraints.maxHeight * 0.95;

    if (h * (pageW / pageH) > w) {
      h = w * (pageH / pageW);
    } else {
      w = h * (pageW / pageH);
    }

    return (w, h);
  }

  @override
  Widget build(BuildContext context) {
    final (pageOneNum, pageTwoNum) = (dualPageIndex.first, dualPageIndex.last);

    final (pageOne, pageTwo) = (
      {'w': pageData.first.width, 'h': pageData.first.height},
      {'w': pageData.last.width, 'h': pageData.last.height},
    );

    final (p1w, p1h) = (
      getWH(pageOne['w'] as double, pageOne['h'] as double).$1,
      getWH(pageOne['w'] as double, pageOne['h'] as double).$2,
    );
    final (p2w, p2h) = (
      getWH(pageTwo['w'] as double, pageTwo['h'] as double).$1,
      getWH(pageTwo['w'] as double, pageTwo['h'] as double).$2,
    );

    final (pgOneSurahsNum, pgTwoSurahsNum) = (
      pageData.first.surahNumber.map((e) {
        return e.keys.first;
      }).toSet(),
      pageData.last.surahNumber.map((e) {
        return e.keys.first;
      }).toSet(),
    );

    if (pagesWithLastLineNextSurah.contains(pageOneNum)) {
      pgOneSurahsNum.add(pgOneSurahsNum.last + 1);
    }

    if (pagesWithLastLineNextSurah.contains(pageTwoNum)) {
      pgTwoSurahsNum.add(pgTwoSurahsNum.last + 1);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          minWidth: constraints.maxWidth,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SinglePage(
              w: p2w,
              h: p2h,
              pageW: pageTwo['w'] as double,
              pageH: pageTwo['h'] as double,
              index: dualPageIndex.last,
              surahsNum: pgTwoSurahsNum.toList(),
            ),
            SizedBox(width: 30),
            SinglePage(
              w: p1w,
              h: p1h,
              pageW: pageOne['w'] as double,
              pageH: pageOne['h'] as double,
              index: dualPageIndex.first,
              surahsNum: pgOneSurahsNum.toList(),
            ),
          ],
        ),
      ),
    );
  }
}
