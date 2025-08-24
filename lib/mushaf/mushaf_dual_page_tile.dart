import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/single_page.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafDualPageTile extends StatefulWidget {
  const MushafDualPageTile({
    super.key,
    //required this.windowSize,
    required this.markedPaths,
    required this.spriteSheet,
    required this.pageData,
    required this.constraints,
  });

  final List<SpriteSheet> spriteSheet;
  final List<PageData> pageData;
  final List<Map<String, MarkType>> markedPaths;
  final BoxConstraints constraints;

  @override
  State<MushafDualPageTile> createState() => _MushafPageViewTileState();
}

class _MushafPageViewTileState extends State<MushafDualPageTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (pageOne, pageTwo) = (
      {'w': widget.pageData.first.width, 'h': widget.pageData.first.height},
      {'w': widget.pageData.last.width, 'h': widget.pageData.last.height},
    );

    // final w = widget.constraints.maxWidth * 0.95;

    // final h = w * (pageH / pageW);

    final h = widget.constraints.maxHeight;

    final (p1w, p2w) = (
      h * ((pageOne['w'] as double) / (pageOne['h'] as double)),
      h * ((pageTwo['w'] as double) / (pageTwo['h'] as double)),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.constraints.maxHeight,
          minWidth: widget.constraints.maxWidth,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SinglePage(
              w: p2w,
              h: h,
              pageW: pageTwo['w'] as double,
              pageH: pageTwo['h'] as double,
              markedPaths: widget.markedPaths.last,
              spriteSheet: widget.spriteSheet.last,
            ),
            SinglePage(
              w: p1w,
              h: h,
              pageW: pageOne['w'] as double,
              pageH: pageOne['h'] as double,
              markedPaths: widget.markedPaths.first,
              spriteSheet: widget.spriteSheet.first,
            ),
          ],
        ),
      ),
    );
  }
}
