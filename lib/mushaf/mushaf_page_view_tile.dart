import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/drawable_path/drawable_path.dart';
import 'package:mushaf_mistake_marker/extensions/num_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_painter.dart';

class MushafPageViewTile extends StatefulWidget {
  const MushafPageViewTile({
    super.key,
    required this.mushafPage,
    required this.windowSize,
  });

  //final int pageNumber;
  final MushafPageData? mushafPage;
  final Size windowSize;

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
    // if (widget.mushafPage == null) {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       spacing: 16,
    //       children: [CircularProgressIndicator(), Text('Loading Page')],
    //     ),
    //   );
    // }

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
                child: CustomPaint(
                  painter: MushafPagePainter(
                    paths: widget.mushafPage!.paths,
                    vBoxSize: Size(wMm, hMm),
                  ),
                  willChange: false,
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
