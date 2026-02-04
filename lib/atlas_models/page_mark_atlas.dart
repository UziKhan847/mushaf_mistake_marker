import 'dart:typed_data';

class PageMarksAtlas {
  const PageMarksAtlas({
    required this.colorList,
    required this.rectList,
    required this.transformList,
  });

  final Float32List rectList;
  final Float32List transformList;
  final Int32List colorList;
}
