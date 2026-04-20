import 'dart:typed_data';

class PageHighlightsAtlas {
  const PageHighlightsAtlas({
    required this.colorList,
    required this.rectList,
  });

  final Float32List rectList;
  final Int32List colorList;
}
