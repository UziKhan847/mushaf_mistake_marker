import 'dart:typed_data';

class PageMarksAtlas {
  const PageMarksAtlas({
    required this.colorList,
    required this.rectList,
  });

  final Float32List rectList;
  final Int32List colorList;
}
