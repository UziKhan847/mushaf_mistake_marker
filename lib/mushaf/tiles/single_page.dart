import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/page_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/screen.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/surah/pages_with_multiple_surahs.dart';

class MushafSinglePageTile extends StatelessWidget {
  const MushafSinglePageTile({
    super.key,
    required this.pageData,
    required this.constraints,
    required this.isPortrait,
    required this.index,
  });

  final int index;
  final PageData pageData;
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

  (double, double) getWH(double pageW, double pageH) {
    double w = constraints.maxWidth * 0.9;
    double h = constraints.maxHeight * 0.875;

    if (isPortrait && (h * (pageW / pageH) < w)) {
      w = h * (pageW / pageH);
    } else {
      h = w * (pageH / pageW);
    }

    return (w, h);
  }

  @override
  Widget build(BuildContext context) {
    final pageNumber = index + 1;
  //  final juzNumber = pageData.jzNum.join(', ');

    final surahsNum = pageData.srNum;

    if (pagesWithLastLineNextSurah.contains(pageNumber)) {
      surahsNum.add(surahsNum.last + 1);
    }

   // final surah = Surah.fromJson(surahs[surahsNum.first - 1]);
   // final hizbNumber = pageData.hzNum.first;
  //  final juzuInfo = 'Juz $juzNumber';
   // final hizbInfo = '(Hizb $hizbNumber)';

    final (pageW, pageH) = (pageData.pSize!.first, pageData.pSize!.last);

    final (w, h) = getWH(pageW, pageH);

    return SingleChildScrollView(
      scrollDirection: .vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          spacing: 20,
          mainAxisAlignment: .center,
          children: [
            SizedBox(
              width: w,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                //  SurahNumberHeader(surah: surah),
                  PageNumberHeader(pageNumber: pageNumber),
                  //    JuzNumberHeader(surah: 'surah'),
                ],
              ),
            ),
            MushafPageScreen(
              w: w,
              h: h,
              pageW: pageW,
              pageH: pageH,
              index: index,
              surahsNum: surahsNum.toList(),
            ),
          ],
        ),
      ),
    );
  }
}
