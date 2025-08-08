
import 'package:mushaf_mistake_marker/png/png_mushaf.dart';
import 'package:mushaf_mistake_marker/png/png_page.dart';


//final Map<String, MarkType> markedPaths = {};

final PngMushaf pngMushaf = PngMushaf(
  pages: List.generate(604, (_) => PngPage(pageImages: {}, pngDataList: [])),
);

enum MarkType { mistake, oldMistake, doubt, tajwid }
