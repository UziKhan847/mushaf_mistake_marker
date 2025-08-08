import 'dart:ui' as ui;
import 'package:mushaf_mistake_marker/png/png_data.dart';


class PngPage {
  PngPage({required this.pageImages, required this.pngDataList});

  Map<String, ui.Image> pageImages;
  List<PngData> pngDataList;
}
