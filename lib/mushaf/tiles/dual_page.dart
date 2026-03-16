import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/page_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/surah_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/screen.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

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
    final pageOneIndex = dualPageIndex.first;
    final pageTwoIndex = dualPageIndex.last;

    final pageOne = {
      'w': pageData.first.pSize!.first,
      'h': pageData.first.pSize!.last,
    };
    final pageTwo = {
      'w': pageData.last.pSize!.first,
      'h': pageData.last.pSize!.last,
    };

    final (p1w, p1h) = getWH(pageOne['w'] as double, pageOne['h'] as double);
    final (p2w, p2h) = getWH(pageTwo['w'] as double, pageTwo['h'] as double);

    return SingleChildScrollView(
      scrollDirection: .vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          minWidth: constraints.maxWidth,
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            MushafPageScreen(
              w: p2w,
              h: p2h,
              pageW: pageTwo['w'] as double,
              pageH: pageTwo['h'] as double,
              index: dualPageIndex.last,
            ),
            SizedBox(
              width: 1,
              height: constraints.maxHeight,
              child: ColoredBox(color: Colors.grey),
            ),
            MushafPageScreen(
              w: p1w,
              h: p1h,
              pageW: pageOne['w'] as double,
              pageH: pageOne['h'] as double,
              index: dualPageIndex.first,
            ),
            // Column(
            //   children: [
            //     SurahNumberHeader(currentPgIndex: pageOneIndex),
            //     PageNumberHeader(
            //       currentPgIndex: pageOneIndex,
            //       pageSide: .rightSide,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
