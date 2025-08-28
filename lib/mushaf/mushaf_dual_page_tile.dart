import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

class MushafDualPageTile extends StatelessWidget {
  const MushafDualPageTile({
    super.key,
    required this.markedPaths,
    required this.pageData,
    required this.constraints,
    required this.dualPageIndex,
  });

  final List<int> dualPageIndex;
  final List<PageData> pageData;
  final List<Map<String, MarkType>> markedPaths;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final (pageOne, pageTwo) = (
      {'w': pageData.first.width, 'h': pageData.first.height},
      {'w': pageData.last.width, 'h': pageData.last.height},
    );

    // final w = widget.constraints.maxWidth * 0.95;

    // final h = w * (pageH / pageW);

    final h = constraints.maxHeight;

    final (p1w, p2w) = (
      h * ((pageOne['w'] as double) / (pageOne['h'] as double)),
      h * ((pageTwo['w'] as double) / (pageTwo['h'] as double)),
    );

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
              h: h,
              pageW: pageTwo['w'] as double,
              pageH: pageTwo['h'] as double,
              markedPaths: markedPaths.last,
              index: dualPageIndex.last,
            ),
            SizedBox(width: 30),
            SinglePage(
              w: p1w,
              h: h,
              pageW: pageOne['w'] as double,
              pageH: pageOne['h'] as double,
              markedPaths: markedPaths.first,
              index: dualPageIndex.first,
            ),
          ],
        ),
      ),
    );
  }
}
