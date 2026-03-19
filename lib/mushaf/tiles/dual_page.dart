import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/screen.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/widgets/margin_lantern.dart';

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
    // final pageOneIndex = dualPageIndex[0];
    // final pageTwoIndex = dualPageIndex[1];

    final (p1w, p1h) = getWH(
      pageData.first.pSize![0],
      pageData.first.pSize![1],
    );
    final (p2w, p2h) = getWH(pageData.last.pSize![0], pageData.last.pSize![1]);

    return SingleChildScrollView(
      scrollDirection: .vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          minWidth: constraints.maxWidth,
        ),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            MarginLantern(),
            MushafPageScreen(
              w: p2w,
              h: p2h,
              pageW: pageData[1].pSize![0],
              pageH: pageData[1].pSize![1],
              index: dualPageIndex[1],
            ),
            SizedBox(
              width: 1,
              height: constraints.maxHeight,
              child: ColoredBox(color: Colors.grey),
            ),
            MushafPageScreen(
              w: p1w,
              h: p1h,
              pageW: pageData[0].pSize![0],
              pageH: pageData[0].pSize![1],
              index: dualPageIndex[0],
            ),
            MarginLantern(),
          ],
        ),
      ),
    );
  }
}
