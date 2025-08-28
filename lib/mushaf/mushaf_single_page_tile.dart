import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/page_data/surah_names.dart';

class MushafSinglePageTile extends StatelessWidget {
  const MushafSinglePageTile({
    super.key,
    required this.markedPaths,
    required this.pageData,
    required this.constraints,
    required this.isPortrait,
    required this.index,
  });

  final int index;
  final PageData pageData;
  final Map<String, MarkType> markedPaths;
  final BoxConstraints constraints;
  final bool isPortrait;

  bool elemBounds({
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

  @override
  Widget build(BuildContext context) {
    final pageNumber = pageData.pageNumber;
    final juzNumber = pageData.juzNumber.join(', ');

    final surahNumber = pageData.surahNumber.first.keys.first;
    final surahName = surahs['$surahNumber']!['name'] as String;
    final numberOfSurahVerses =
        surahs['$surahNumber']!['numberofVerses'] as int;
    final hizbNumber = pageData.hizbNumber.first;

    final surahInfo = '$surahNumber $surahName ($numberOfSurahVerses)';
    final juzuInfo = 'Juz $juzNumber';
    final hizbInfo = '(Hizb $hizbNumber)';

    final (pageW, pageH) = (pageData.width, pageData.height);

    // final w = widget.constraints.maxWidth * 0.95;

    // final h = w * (pageH / pageW);

    // final h = widget.constraints.maxHeight * 0.875;

    // final w = h * (pageW / pageH);

    (double, double) getWH() {
      double w = constraints.maxWidth * 0.9;
      double h = constraints.maxHeight * 0.875;

      if (isPortrait && (h * (pageW / pageH) < w)) {
        w = h * (pageW / pageH);
      } else {
        h = w * (pageH / pageW);
      }

      return (w, h);
    }

    final (w, h) = (getWH().$1, getWH().$2);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    surahInfo,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                  Text(
                    '$pageNumber',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        juzuInfo,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                      Text(' $hizbInfo'),
                    ],
                  ),
                ],
              ),
            ),
            SinglePage(
              w: w,
              h: h,
              pageW: pageW,
              pageH: pageH,
              markedPaths: markedPaths,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
