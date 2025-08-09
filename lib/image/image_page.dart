import 'dart:ui' as ui;
import 'package:mushaf_mistake_marker/image/image_data.dart';

class ImagePage {
  ImagePage({required this.pageImages, required this.imageDataList});

  Map<String, ui.Image> pageImages;
  //ui.Image? image;
  List<ImageData> imageDataList;
}
