import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/extensions/num_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class MushafPageViewTile extends StatefulWidget {
  const MushafPageViewTile({
    super.key,
    required this.mushafPage,
    required this.windowSize,
    required this.markedPaths,
  });

  //final int pageNumber;
  final MushafPageData? mushafPage;
  final Size windowSize;
  final Map<String, MarkType> markedPaths;

  @override
  State<MushafPageViewTile> createState() => _MushafPageViewTileState();
}

class _MushafPageViewTileState extends State<MushafPageViewTile> {
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
    final markedPaths = widget.markedPaths;

    final wMm = widget.mushafPage!.width;
    final hMm = widget.mushafPage!.height;

    final w = widget.windowSize.width * 0.8;

    final h = w * (hMm / wMm);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: widget.windowSize.height),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: w,
                height: h,
                child: GestureDetector(
                  onTapDown: (details) {
                    final localPos = details.localPosition;

                    final scaleX = w / wMm;
                    final scaleY = h / hMm;

                    final scaledPoint = Offset(
                      localPos.dx / scaleX,
                      localPos.dy / scaleY,
                    );

                    for (final drawablePath in widget.mushafPage!.paths) {
                      if (drawablePath.path.contains(scaledPoint)) {
                        final id = drawablePath.id;

                        switch (markedPaths[id]) {
                          case MarkType.doubt:
                            markedPaths[id] = MarkType.mistake;
                          case MarkType.mistake:
                            markedPaths[id] = MarkType.oldMistake;
                          case MarkType.oldMistake:
                            markedPaths[id] = MarkType.tajwid;
                          case MarkType.tajwid:
                            markedPaths.remove(id);
                          default:
                            markedPaths[id] = MarkType.doubt;
                        }

                        setState(() {});
                      }
                    }
                  },
                  child: CustomPaint(
                    painter: MushafPagePainter(
                      paths: widget.mushafPage!.paths,
                      vBoxSize: Size(wMm, hMm),
                      markedPaths: Map.from(markedPaths),
                      pageNumber: widget.mushafPage!.pageNumber,
                    ),
                  ),
                ),
              ),
              Text(
                widget.mushafPage!.pageNumber.toArabic(),
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
