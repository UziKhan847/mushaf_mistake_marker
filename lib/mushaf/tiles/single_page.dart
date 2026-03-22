import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/juz_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/page_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/header/surah_number.dart';
import 'package:mushaf_mistake_marker/mushaf/page/screen.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

class MushafSinglePageTile extends StatelessWidget {
  const MushafSinglePageTile({
    super.key,
    required this.pageData,
    required this.constraints,
    required this.index,
  });

  final int index;
  final PageData pageData;
  final BoxConstraints constraints;

  (double, double) getWH(double pageW, double pageH, bool isPortrait) {
    var w = constraints.maxWidth * 0.9;
    var h = constraints.maxHeight * 0.875;

    if (isPortrait && (h * (pageW / pageH) < w)) {
      w = h * (pageW / pageH);
    } else {
      h = w * (pageH / pageW);
    }

    return (w, h);
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.orientationOf(context) == .portrait;

    final pageW = pageData.pSize![0];
    final pageH = pageData.pSize![1];

    final (w, h) = getWH(pageW, pageH, isPortrait);

    return SingleChildScrollView(
      scrollDirection: .vertical,
      child: Padding(
        padding: .symmetric(vertical: isPortrait ? 0 : 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            spacing: 20,
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: w,
                child: Stack(
                  children: [
                    Center(child: PageNumberHeader(currentPgIndex: index)),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        SurahNumberHeader(currentPgIndex: index),
                        JuzNumberHeader(currentPgIndex: index),
                      ],
                    ),
                  ],
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
      ),
    );
  }
}
