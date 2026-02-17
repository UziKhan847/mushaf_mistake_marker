import 'dart:typed_data';

class PageHighlightsAtlas {
  const PageHighlightsAtlas({
    required this.colorList,
    required this.rectList,
    required this.transformList,
  });

  final Float32List rectList;
  final Float32List transformList;
  final Int32List colorList;
}
