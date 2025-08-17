import 'package:mushaf_mistake_marker/image/image_mushaf.dart';
import 'package:mushaf_mistake_marker/image/image_page.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';

//final Map<String, MarkType> markedPaths = {};

final ImageMushaf imageMushaf = ImageMushaf(
  pages: List.generate(
    604,
    (_) => ImagePage(pageImages: {}, imageDataList: []),
  ),
);

final spriteSheets = List.generate(604, (_) => SpriteSheet(sprites: []));

// final PngMushaf imageMushaf = PngMushaf(
//   pages: List.generate(604, (_) => ImagePage(image: null, imageDataList: [])),
// );

enum MarkType { mistake, oldMistake, doubt, tajwid }
