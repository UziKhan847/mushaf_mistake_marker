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

const redInt = 0xFFFF0000;
const purpleInt = 0xFF800080; 
const blueInt   = 0xFF0000FF; 
const greenInt  = 0xFF00FF00; 
const blackInt  = 0xFF000000; 
