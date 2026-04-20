import 'dart:typed_data';

class PageAnnotationsAtlas {
  const PageAnnotationsAtlas({
    required this.colorList,
    required this.rectList,
  });

  final Float32List rectList;
  final Int32List colorList;
}
