import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafSinglePageTile extends StatefulWidget {
  const MushafSinglePageTile({
    super.key,
    //required this.windowSize,
    required this.markedPaths,
    required this.spriteSheet,
    required this.pageData,
    required this.constraints,
    required this.orientation,
  });

  //final int pageNumber;
  //final Size windowSize;
  final SpriteSheet spriteSheet;
  final PageData pageData;
  final Map<String, MarkType> markedPaths;
  final BoxConstraints constraints;
  final Orientation orientation;

  @override
  State<MushafSinglePageTile> createState() => _MushafPageViewTileState();
}

class _MushafPageViewTileState extends State<MushafSinglePageTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    final pageW = widget.pageData.width;
    final pageH = widget.pageData.height;

    // final w = widget.constraints.maxWidth * 0.95;

    // final h = w * (pageH / pageW);

    // final h = widget.constraints.maxHeight * 0.875;

    // final w = h * (pageW / pageH);

    (double, double) getWH() {
      double w = widget.constraints.maxWidth * 0.9;
      double h = widget.constraints.maxHeight * 0.875;

      final isPortrait = widget.orientation == Orientation.portrait;

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
        constraints: BoxConstraints(minHeight: widget.constraints.maxHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SinglePage(
              w: w,
              h: h,
              pageW: pageW,
              pageH: pageH,
              markedPaths: widget.markedPaths,
              spriteSheet: widget.spriteSheet,
            ),
            SizedBox(height: widget.constraints.maxHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
