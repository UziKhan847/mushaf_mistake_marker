import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

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
            Container(
              height: constraints.maxHeight * 0.05,
              width: w,
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Surah: [Surah Name]'),
                      Text('Juzu: [Juzu Number]'),
                    ],
                  ),
                  Text('Page: [Page Number]'),
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
