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
    required this.isPortrait,
  });

  final SpriteSheet spriteSheet;
  final PageData pageData;
  final Map<String, MarkType> markedPaths;
  final BoxConstraints constraints;
  final bool isPortrait;

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
    final (pageW, pageH) = (widget.pageData.width, widget.pageData.height);

    // final w = widget.constraints.maxWidth * 0.95;

    // final h = w * (pageH / pageW);

    // final h = widget.constraints.maxHeight * 0.875;

    // final w = h * (pageW / pageH);

    (double, double) getWH() {
      double w = widget.constraints.maxWidth * 0.9;
      double h = widget.constraints.maxHeight * 0.875;

      final isPortrait = widget.isPortrait;

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
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.constraints.maxHeight * 0.05,
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
              markedPaths: widget.markedPaths,
              spriteSheet: widget.spriteSheet,
            ),
          ],
        ),
      ),
    );
  }
}
