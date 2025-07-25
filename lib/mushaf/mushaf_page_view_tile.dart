import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/drawable_path/drawable_path.dart';
import 'package:mushaf_mistake_marker/extensions/num_extension.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';

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
    if (widget.mushafPage != null) {
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
                    painter: PagePainter(
                      paths: widget.mushafPage!.paths,
                      vBoxSize: Size(wMm, hMm),
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

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [CircularProgressIndicator(), Text('Loading Page')],
      ),
    );
  }
}

class PagePainter extends CustomPainter {
  PagePainter({required this.paths, required this.vBoxSize});

  final List<DrawablePath> paths;
  final Size vBoxSize;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final double scaleX = size.width / vBoxSize.width;
    final double scaleY = size.height / vBoxSize.height;

    canvas.scale(scaleX, scaleY);

    for (int i = 0; i < paths.length; i++) {
      final path = paths[i].path;

      paint.color = Colors.black;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
