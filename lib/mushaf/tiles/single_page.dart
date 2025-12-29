import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/page_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/screen.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

class MushafSinglePageTile extends StatelessWidget {
  const MushafSinglePageTile({
    super.key,
    required this.pageData,
    required this.constraints,
    // required this.isPortrait,
    required this.index,
  });

  final int index;
  final PageData pageData;
  final BoxConstraints constraints;
  // final bool isPortrait;

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

  (double, double) getWH(double pageW, double pageH, bool isPortrait) {
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
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final pageNumber = index + 1;

    final (pageW, pageH) = (pageData.pSize!.first, pageData.pSize!.last);

    final (w, h) = getWH(pageW, pageH, isPortrait);

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
                children: [PageNumberHeader(pageNumber: pageNumber)],
              ),
            ),
            MushafPageScreen(
              w: w,
              h: h,
              pageW: pageW,
              pageH: pageH,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
